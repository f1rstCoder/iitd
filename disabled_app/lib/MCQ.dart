import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:disabled_app/server.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;


import 'Level_Page.dart';
import 'ViewVideo.dart';
import 'ViewVideo1.dart';
import 'games.dart';
import 'my-globals.dart';

class MUltiQuestions extends StatefulWidget {
  final String t;
  MUltiQuestions(this.t);

  @override
  State<MUltiQuestions> createState() => _MUltiQuestionsState(t);
}

class _MUltiQuestionsState extends State<MUltiQuestions> {
  // ignore: deprecated_member_use
  final String title;
  _MUltiQuestionsState(this.title);
  List characterList = [];

  void getCharactersfromApi() async {
    CharacterApi.getCharacters(title).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        print(list);
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

  int seed = 0;
  // String? gender;
  // String? gender1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>games(title)));
            }
        ),
        title: Text('MCQ'),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
                child: Icon(Icons.view_agenda_outlined),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      Widget okButton = TextButton(
                        child: Text("OK"),
                        onPressed: (){
                          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>MUltiQuestions(title)));
                        },
                      );
                      return AlertDialog(
                        title: Text("Result"),
                        content: Text('Score ${seed} / ${characterList.length}'),
                        actions: [
                          okButton,
                        ],
                      );
                    },
                  );
                }
            ),
            FloatingActionButton(
              child: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  seed = 0;
                });
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: characterList.length,
        itemBuilder: (context, index) {
          return  Card(
            margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
            elevation: 1.5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                padding: EdgeInsets.all(20),
                child:
                Column(
                  children: [

                    if(characterList[index][1].toString().split("?")[1] == "")...[

                      if(characterList[index][1].toString().startsWith('https://drive.google.com/'))...[

                        RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: (index+1).toString()+") ",
                                  style: TextStyle(fontSize: 18, color: Colors.black)),
                              TextSpan(
                                  text: characterList[index][1],
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      globalvideolink = characterList[index][1].toString();
                                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>ViewVideo1(characterList[index][1].toString())));
                                    })
                            ])),

                      ]else...[
                        AutoSizeText((index+1).toString()+") "+characterList[index][1], style: TextStyle(
                            fontSize: 18
                        ),),
                      ]

                    ]else...[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              child: Image.network(serverurl+characterList[index][1].toString().split("?")[1],height: 100,),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: AutoSizeText((index+1).toString()+") "+characterList[index][1].toString().split("?")[0]+" ?"),
                          ),
                        ],
                      )
                    ],

                    Divider(thickness: 1,),

                    RadioListTile(
                      title: Row(
                        children: <Widget>[
                          if(characterList[index][2].startsWith('static'))...[
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: Image.network(serverurl+characterList[index][2],height: 100,),
                              ),
                            )
                          ]else...[
                            AutoSizeText(characterList[index][2]),
                          ]
                        ],
                      ),
                      value: characterList[index][2].toString(),
                      groupValue: characterList[index][0],
                      onChanged: (value){
                        setState(() {
                          characterList[index][0]=value.toString();
                          if(characterList[index][6].toString()==value)
                          {
                            seed++;
                            updateScore();

                            if(characterList.length == seed){
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
                          }
                        });
                      },
                    ),

                    RadioListTile(
                      title: Row(
                        children: <Widget>[
                          if(characterList[index][3].startsWith('static'))...[
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: Image.network(serverurl+characterList[index][3],height: 100),
                              ),
                            )
                          ]else...[
                            AutoSizeText(characterList[index][3]),
                          ]
                        ],
                      ),
                      value: characterList[index][3].toString(),
                      groupValue: characterList[index][0],
                      onChanged: (value){
                        characterList[index][0]=value.toString();
                        setState(() {
                          if(characterList[index][6].toString()==value)
                          {
                            seed++;
                            updateScore();
                            if(characterList.length == seed){
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
                          }
                        });
                      },
                    ),

                    RadioListTile(
                      title: Row(
                        children: <Widget>[
                          if(characterList[index][4].startsWith('static'))...[
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: Image.network(serverurl+characterList[index][4],height: 100),
                              ),
                            )
                          ]else...[
                            AutoSizeText(characterList[index][4]),
                          ]
                        ],
                      ),
                      value: characterList[index][4].toString(),
                      groupValue: characterList[index][0],
                      onChanged: (value){
                        setState(() {
                          characterList[index][0]=value.toString();
                          if(characterList[index][6].toString()==value)
                          {
                            seed++;
                            updateScore();
                            if(characterList.length == seed){
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
                          }
                        });
                      },
                    ),

                    RadioListTile(
                      title: Row(
                        children: <Widget>[
                          if(characterList[index][5].startsWith('static'))...[
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                child: Image.network(serverurl+characterList[index][5],height: 100),
                              ),
                            )
                          ]else...[
                            AutoSizeText(characterList[index][5]),
                          ]
                        ],
                      ),
                      value: characterList[index][5].toString(),
                      groupValue: characterList[index][0],
                      onChanged: (value){
                        setState(() {
                          characterList[index][0]=value.toString();
                          if(characterList[index][6].toString()==value)
                          {
                            seed++;
                            updateScore();
                            if(characterList.length == seed){
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
                          }
                        });
                      },
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

  Future<void> updateScore() async {

    final url = serverurl+"updateMCQLevel";
    final response = await http.post(Uri.parse(url), body: json.encode({'score' : seed,'username' : globalUserName,'email' : globalHeaderEmail,'level' : title}));
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

class CharacterApi {
  static Future getCharacters(level) {
    return http.get(Uri.parse(serverurl+"getMcqQues/"+level));
  }
}

