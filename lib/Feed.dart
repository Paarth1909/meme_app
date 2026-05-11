import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  late final Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();

    // 🔥 Fetch memes from Firestore
    _stream = FirebaseFirestore.instance
        .collection('memes')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void handleLike() {
    print('post was liked');
  }

  void handleComment() {
    print('post was commented');
  }

  void handleShare() {
    print('post was shared');
  }

  Future<void> handleDelete(String docId, String imageUrl) async {
    final storage = Supabase.instance.client.storage;
    String? storagePath;

    try {
      final uri = Uri.tryParse(imageUrl);
      if (uri != null) {
        final publicIndex = uri.pathSegments.indexOf('public');
        if (publicIndex != -1) {
          storagePath = uri.pathSegments.sublist(publicIndex).join('/');
        } else {
          storagePath = uri.path.startsWith('/') ? uri.path.substring(1) : uri.path;
        }
      }
    } catch (_) {
      storagePath = null;
    }

    if (storagePath != null && storagePath.isNotEmpty) {
      try {
        await storage.from('meme_bucket').remove([storagePath]);
      } catch (e) {
        debugPrint('Failed to delete Supabase image: $e');
      }
    }

    await FirebaseFirestore.instance.collection('memes').doc(docId).delete();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Meme was deleted!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Meme Feed"), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          // 🔴 Error State
          if (snapshot.hasError) {
            return const Center(child: Text("Error fetching memes"));
          }

          // 🟡 Loading State
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ⚪ Empty State
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No memes found", textAlign: TextAlign.center),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
              await Future.delayed(const Duration(microseconds: 1000));
              return;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final doc = snapshot.data!.docs[index];
                  final data = doc.data() as Map<String, dynamic>;
                  final imageUrl = data['imageUrl'];
                  final caption = data['caption'];
                  final like = data['like'];
                  final timestamp = data['timestamp'];

                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://static.thenounproject.com/png/2616532-200.png',
                                ),
                                // child: Text("T"),
                              ),
                              SizedBox(width: 8),
                              Text('MemeApp User'),
                              Spacer(),
                              PopupMenuButton<String>(
                                icon: Icon(Icons.more_vert),
                                onSelected: (value) {
                                  switch (value) {
                                    case 'delete':
                                      handleDelete(doc.id, imageUrl);
                                      break;
                                    case 'save':
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Save selected'),
                                        ),
                                      );
                                      break;
                                    case 'share':
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Share selected'),
                                        ),
                                      );
                                      break;
                                  }
                                },
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: ListTile(
                                      title: Text('Delete'),
                                      iconColor: Colors.redAccent,
                                      trailing: Icon(Icons.delete),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'save',
                                    child: Text('Save'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'share',
                                    child: Text('Share'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        AspectRatio(
                          aspectRatio: 3 / 4,
                          child: Image.network(imageUrl, fit: BoxFit.contain),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(caption),
                              SizedBox(height: 20),
                              Text(timeago.format(DateTime.parse(timestamp))),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: handleLike,
                              icon: Icon(Icons.favorite),
                            ),
                            IconButton(
                              onPressed: handleComment,
                              icon: Icon(Icons.comment),
                            ),
                            IconButton(
                              onPressed: handleShare,
                              icon: Icon(Icons.share),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
