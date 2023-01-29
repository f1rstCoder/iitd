import 'dart:convert';

import 'package:disabled_app/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;

import 'Level_Page.dart';
import 'QuestGraterthan3.dart';
import 'ViewVideo.dart';
import 'my-globals.dart';

class videolevelgrater3 extends StatefulWidget {

  final String t;
  videolevelgrater3(this.t);

  @override
  State<videolevelgrater3> createState() => _videolevelgrater3(t);
}

class _videolevelgrater3 extends State<videolevelgrater3> {

  final String title;
  _videolevelgrater3(this.title);
  // ignore: deprecated_member_use
  List characterList = [];

  void getCharactersfromApi() async {
    CharacterApi.getCharacters(title).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        // print(list);
        characterList.addAll(list) ;
        globalList=characterList;
        globalseed=0;
        // Iterable list = json.decode(response.body);
        // characterList = list;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCharactersfromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Level_Page(title)));
            }
        ),
        title: new Text(title+" questions"),
      ),
      body: ListView.builder(
        itemCount: characterList.length,
        itemBuilder: (context, index) {
          return  Card(
            elevation: 1.5,
            child: Padding(

              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                onTap: (){
                  globalvideolink = characterList[index][2].toString();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>QuestGraterthan3(index.toString(),title)));
                } ,
                title: Row(

                  children: <Widget>[
                    Icon(
                      Icons.question_answer,
                      color: Colors.deepPurpleAccent,
                      size: 60.0,
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                            width: MediaQuery.of(context).size.width-140,
                            child: Text("Question no "+(index+1).toString(),style: TextStyle(fontSize: 20),)),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },

      ),

    );
  }
}

class CharacterApi {
  static Future getCharacters(String level) {
    return http.get(Uri.parse(serverurl+"getMcqQues/"+level));
  }
}
