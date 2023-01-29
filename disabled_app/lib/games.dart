import 'package:flutter/material.dart';

import 'FillInBlanks.dart';
import 'Level_Page.dart';
import 'MCQ.dart';
import 'MatchFollow.dart';

class games extends StatefulWidget {
  final String t;
  games(this.t);

  @override
  State<games> createState() => _gamesState(t);
}

class _gamesState extends State<games> {

  final String title;
  _gamesState(this.title);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Level_Page(title)));
              }
          ),
          title: Text(title+" games"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 1/3.5,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>MatchFollow(title)));
                    } ,
                    title: Column(
                      children: <Widget>[
                        Image.asset ("assets/screenshots/ss.jpg",
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 1/5,
                            fit: BoxFit.cover),
                        SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                child: Text("Match the followings",style: TextStyle(fontSize: 17),)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

              ),
            ),


            Container(
              height: MediaQuery.of(context).size.height * 1/3.5,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>FillInBlanks(title)));
                    } ,
                    title: Column(
                      children: <Widget>[
                        Image.asset ("assets/screenshots/ss.jpg",
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 1/5,
                            fit: BoxFit.cover),
                        SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                child: Text("Fill in the blanks",style: TextStyle(fontSize: 17),)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

              ),
            ),


            Container(
              height: MediaQuery.of(context).size.height * 1/3.5,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>MUltiQuestions(title)));
                    } ,
                    title: Column(
                      children: <Widget>[
                        Image.asset ("assets/screenshots/ss.jpg",
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 1/5,
                            fit: BoxFit.cover),
                        SizedBox(height: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                child: Text("Multiple choice questions",style: TextStyle(fontSize: 17),)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),

              ),
            ),

          ],
        )
      ),
    );
  }
}
