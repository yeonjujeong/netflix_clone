import 'package:flutter/material.dart';
import 'package:netflix/screen/home_screen.dart';
import 'package:netflix/widget/bottom_bar.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class MainPage extends StatefulWidget {
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        title: 'MeongFlix',
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            accentColor: Colors.white
        ),
        home: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                HomeScreen(),
                Container(child: Center(child: Text('search'),),),
                Container(child: Center(child: Text('save'),),),
                Container(child: Center(child: Text('more'),),),
              ],
            ),
            bottomNavigationBar: Bottom(),
          ),
        )
    );
  }
}