import 'package:flutter/material.dart';
import 'package:meme_app/Feed.dart';
import 'package:meme_app/Settings.dart';
import 'package:meme_app/add_meme.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   int myIndex = 0;

   List<Widget>widgetList = [AddMeme(),Feed(),Settings()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meme App')),
      body: widgetList[myIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: (index) => {

          setState(() {
            myIndex = index;
          }),
        },
        currentIndex: myIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',backgroundColor: Colors.amber),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Feed',backgroundColor: Colors.red),
          BottomNavigationBarItem(icon: Icon(Icons.settings),label:'Settings',backgroundColor: Colors.blue), 
        ],
      ),
    );
  }
}