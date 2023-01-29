import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audio_cache.dart';
import 'package:disabled_app/my-globals.dart';
import 'package:disabled_app/server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Level_Page.dart';

class MatchFollow extends StatefulWidget {

  final String t;
  MatchFollow(this.t);
  createState() => _ColorGameState(t);
}

class _ColorGameState extends State<MatchFollow> {

  final String title;
  _ColorGameState(this.title);
  Map choices= {};

  /// Map to keep track of score
  final Map<String, bool> score = {};

  @override
  void initState() {
    super.initState();
    if (title == "Level 1"){
      choices=Level1;
    }
    else
    {
      choices=Level2;
    }
  }

  int seed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Score ${score.length} / 6'),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            score.clear();
            seed++;
          });
        },
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: choices.keys.map((emoji) {
                  return Draggable<String>(

                    // data: emoji,
                    // child: Text(emoji,style: TextStyle(fontSize: 25,),),
                    // feedback: Emoji(emoji: emoji),
                    // childWhenDragging: Text(""),

                    data: emoji,
                    child: Emoji(emoji: score[emoji] == true ? '✅' : emoji),
                    // child: Emoji(emoji: score[emoji] == true ? '✅' : emoji),
                    feedback: Emoji(emoji: emoji),
                    childWhenDragging: Text(""),

                  );
                }).toList()),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              choices.keys.map((emoji) => _buildDragTarget(emoji)).toList()
                ..shuffle(Random(seed)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDragTarget(emoji) {
    return DragTarget<String>(
      builder: (context,incoming,rejected) {
        if (score[emoji] == true) {
          return Container(
            alignment: Alignment.center,
            height: 65,
            width: 150,
            child: Container(
              alignment: Alignment.center,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: Text('Correct !',style: TextStyle(fontSize: 25),),
            ),
          );
        } else {
          // return Container(color: choices[emoji], height: 80, width: 200);
          return Container(child: Center(child: Text(emoji,style: TextStyle(fontSize: 25,),)), height: 65, width: 150);
        }
      },
      onWillAccept: (data) => data == emoji,
      onAccept: (data) {
        setState(() {
          score[emoji] = true;

          updateScore(score.length);

          plyr.play('success.mp3');

          if(score.length == 6){
            showDialog(
              context: context,
              builder: (context) {
                Widget okButton = TextButton(
                  child: Text("OK"),
                  onPressed: (){
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Level_Page(title)));
                  },
                );
                return AlertDialog(
                  title: Text("Result"),
                  content: Text('You passed this game !'),
                  actions: [
                    okButton,
                  ],
                );
              },
            );
          }
        });
      },
      onLeave: (data) {},
    );
  }

  Future<void> updateScore(int score) async {

    final url = serverurl+"updateMatchLevel";
    final response = await http.post(Uri.parse(url), body: json.encode({'score' : score,'username' : globalUserName,'email' : globalHeaderEmail,'level' : title}));
    String responseBody = response.body;

    if(responseBody == "levelpassed")
    {
      showDialog(
        context: context,
        builder: (context) {
          Widget okButton = TextButton(
            child: Text("OK"),
            onPressed: goToLoginScreen,
          );
          return AlertDialog(
            title: Text("Result"),
            content: Text('You passed this level !\n Move to next level.'),
            actions: [
              okButton,
            ],
          );
        },
      );
    }

  }

  Future<void> goToLoginScreen() async {

    final url = serverurl+"getUserLevel";
    final response = await http.post(Uri.parse(url), body: json.encode({'email' : globalHeaderEmail}));
    String responseBody = response.body;

    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Level_Page(responseBody.toString())));

  }

}

class Emoji extends StatelessWidget {
  const Emoji({Key? key, required this.emoji}) : super(key: key);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: emoji == '✅' ? new Container(
        alignment: Alignment.center,
        height: 65,
        // padding: EdgeInsets.all(10),
        child: Text(
          emoji,
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ) : Container(
        alignment: Alignment.center,
        height: 65,
        child: new Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
          ),
          alignment: Alignment.center,
          height: 40,
          padding: EdgeInsets.all(7),
          child: Text(
            emoji,
            style: TextStyle(color: Colors.black, fontSize: 23,fontFamily: "PressStart"),
          ),
        ),
      ),
    );
  }
}

AudioCache plyr = AudioCache();