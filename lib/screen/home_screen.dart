import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:netflix/widget/carousel_slider.dart';

import '../model/model_movie.dart';

class HomeScreen extends StatefulWidget{
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;

  @override
  void initState(){
    super.initState();
    streamData = firestore.collection('movie').snapshots();
  }

  Widget _fetchData(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: streamData, //strestore.collection('movie').snapshots()
        builder: (context, snapshot){
          if(!snapshot.hasData) return LinearProgressIndicator();
          return _buildBody(context, snapshot.data!.docs);
        },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot){
    List<Movie>? movies = snapshot.map((d) => Movie.fromSnapshot(d)).toList();
    // List<Movie>? movies;
    // setState(() {
    //   if(_movies != null){
    //     movies = _movies;
    //   }
    // });

    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            CarouselImage(movies: movies),
            TopBar(),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    return _fetchData(context);
  }
}

class TopBar extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'images/meong.jpg',
            fit: BoxFit.contain,
            height: 25,
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}