import 'dart:convert';

import 'package:disabled_app/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;

import 'ViewVideo.dart';
import 'my-globals.dart';

class videos extends StatefulWidget {

  final String t;
  videos(this.t);

  @override
  State<videos> createState() => _videosState(t);
}

class _videosState extends State<videos> {

  final String title;
  _videosState(this.title);
  // ignore: deprecated_member_use
  List characterList = [];

  void getCharactersfromApi() async {
    CharacterApi.getCharacters(title).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        // print(list);
        characterList.addAll(list) ;
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
        title: new Text(title+" Videos"),
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
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ViewVideo(characterList[index][1].toString(),title,"video"+(index+1).toString())));
                } ,
                title: Row(

                  children: <Widget>[
                    Icon(
                      Icons.video_collection_outlined,
                      color: Colors.deepPurpleAccent,
                      size: 60.0,
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                            width: MediaQuery.of(context).size.width-140,
                            child: LocaleText(characterList[index][1].toString(),style: TextStyle(fontSize: 17),)),
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
    return http.get(Uri.parse(serverurl+"getVideos/"+level));
  }
}
