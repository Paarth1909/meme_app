import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as path;

class AddMeme extends StatefulWidget {
  const AddMeme({super.key});

  @override
  State<AddMeme> createState() => _AddMemeState();
}

class _AddMemeState extends State<AddMeme> {
  final SupabaseClient supabase = Supabase.instance.client;

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final TextEditingController _captionController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final String fileName =
          "${DateTime.now().microsecondsSinceEpoch}_${path.basename(_selectedImage!.path)}";

      await supabase.storage
          .from("meme_bucket")
          .upload(
            'public/#{filename}',
            _selectedImage!,
            fileOptions: const FileOptions(upsert: true),
          );

      final String imageUrl = supabase.storage
          .from('meme_bucket')
          .getPublicUrl('public/${fileName}');
      print(imageUrl);
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select an image')));
      return;
    }

    if (_captionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a caption')));
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final String fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${path.basename(_selectedImage!.path)}';

      await supabase.storage
          .from('meme_bucket')
          .upload(
            'public/$fileName',
            _selectedImage!,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );

      final String imageUrl = supabase.storage
          .from('meme_bucket')
          .getPublicUrl('public/$fileName');
      print(imageUrl);

      final memeData = <String, dynamic>{
        'caption': _captionController.text,
        'imageUrl': imageUrl,
        'timestamp': DateTime.now().toIso8601String(),
        'like': 0,
      };

      await db.collection("memes").add(memeData).then((DocumentReference doc) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Meme added successfully with ID: ${doc.id}')),
        );
        // Clear form
        // _captionController.clear();
        setState(() {
          _selectedImage = null;
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error adding meme: $e')));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 200)
                : Text("No Image Selected"),
            SizedBox(height: 50),
            TextField(
              controller: _captionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Caption",
              ),
            ),
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [ 
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.gallery),
                    child: Text("Pick from Gallery"),
                  ),
                  ElevatedButton(
                    onPressed: () => pickImage(ImageSource.camera),
                    child: Text("Pick from Camera"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => uploadImage(),
              child: Text("Upload Image"),
            ),
           
          ],
        ),
      ),
    );
  }
}
