import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/Feed.dart';
import 'package:meme_app/Home.dart';
import 'package:meme_app/Profile.dart';
import 'package:meme_app/Settings.dart';
import 'package:meme_app/add_meme.dart';
import 'package:meme_app/firebase_options.dart';
import 'package:meme_app/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



Future<void> main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
 );

 await Supabase.initialize(
  url: 'https://tqrgymwtxkmfnvxdliur.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InRxcmd5bXd0eGttZm52eGRsaXVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzUwNDE4NDUsImV4cCI6MjA5MDYxNzg0NX0.Sjp4qzCg57ThZSPWGDXO1BARArlv2reJ2PTi-sBCXBs'
 );



  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme:  .fromSeed(seedColor: Colors.deepPurple)),
      home:  SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/Home' :(context) => const Home(),
        '/Feed' :(context) => Feed(),
        '/Profile' :(context) =>const Profile(),
        '/Settings' :(context) =>const Settings(),
        '/Addmeme' :(context) =>const AddMeme(),
      },
    );
  }
}
