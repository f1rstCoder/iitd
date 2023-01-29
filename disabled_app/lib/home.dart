import 'dart:async';
import 'dart:convert';
import 'package:disabled_app/server.dart';
import 'package:disabled_app/video.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'games.dart';
import 'login.dart';
import 'my-globals.dart';

class home extends StatefulWidget {
  const home({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<home> {

  List characterList = [];

  void getCharactersfromApi() async {
    CharacterApi.getCharacters().then((response) {
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

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: new AppBar(
        title: new Text("Level 1"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: [
            new UserAccountsDrawerHeader(
              accountName: new Text(characterList[0][0]+" "+characterList[0][1]),
              accountEmail: new Text(characterList[0][2]),
              currentAccountPicture: new CircleAvatar(
                backgroundColor:
                Theme.of(context).platform==TargetPlatform. iOS
                    ? Colors.deepPurple
                    :Colors.white,
                child: new Text("RJ"),
              ),
              // otherAccountsPictures: [
              //   new CircleAvatar(
              //     backgroundColor:
              //     Theme.of(context).platform==TargetPlatform. iOS
              //         ? Colors.deepPurple
              //         :Colors.white,
              //     child: new Text("R"),
              //   ),
              // ],
            ),
            new ListTile(
              title: new Text("Home"),
              trailing: new Icon(Icons.home),
              // onTap: ()=> Navigator.of(context).pushNamed("/a")
              onTap: (){
                // Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>home()));
              },
            ),
            // new ListTile(
            //   title: new Text("Profile"),
            //   trailing: new Icon(Icons.r_mobiledata),
            //   // onTap: ()=> Navigator.of(context).pushNamed("/b")
            //   onTap: (){
            //     // Navigator.of(context).pop();
            //     Navigator.of(context).push(new MaterialPageRoute(
            //         builder: (BuildContext context)=>secondpage("PROFILE")));
            //   },
            // ),

            // new ListTile(
            //   title: new Text("ABOUT"),
            //   trailing: new Icon(Icons.circle_sharp),
            //   // onTap: ()=> Navigator.of(context).pushNamed("/c")
            //   onTap: (){
            //     // Navigator.of(context).pop();
            //     Navigator.of(context).push(new MaterialPageRoute(
            //         builder: (BuildContext context)=>thirdpage("ABOUT")));
            //   },
            // ),
            // new ListTile(
            //     title: new Text("close"),
            //     trailing: new Icon(Icons.close),
            //     onTap: ()=> Navigator.of(context).pop()
            //
            // ),
            new ListTile(
                title: new Text("logout"),
                trailing: new Icon(Icons.logout),
                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>LoginPage()))
            ),
          ],
        ),
      ),
      body:Center(
        child: Column(

          children: <Widget>[
            SizedBox(height: 20,),
            Text(
              'Please Select your Plan!',
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 25,),

            // ignore: deprecated_member_use

            // ButtonTheme(
            //   minWidth: 200.0,
            //   height: 250.0,
            //   child:RaisedButton(
            //
            //     child: Image.asset ("assets/screenshots/ss.jpg"),
            //
            //     color: Theme.of(context).accentColor,
            //
            //     elevation: 0.0,
            //     // splashColor: Colors.blueGrey,
            //     onPressed: () {
            //       // Navigator.of(context).pop();
            //       Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>videos()));
            //     },
            //   ),
            // ),

            SizedBox(height: 20,),
            // ignore: deprecated_member_use
            Text(
              'Please Select your Plan!',
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height * 0.03,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 25,),

            // ButtonTheme(
            //   minWidth: 200.0,
            //   height: 250.0,
            //   child:
            //   // ignore: deprecated_member_use
            //   RaisedButton(
            //     child: Image.asset ("assets/screenshots/vv.jpg"),
            //     color: Theme.of(context).colorScheme.secondary,
            //
            //     elevation: 0.0,
            //     // splashColor: Colors.blue,
            //     onPressed: () {
            //       // Navigator.of(context).pop();
            //       Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>games()));
            //     },
            //   ),
            // ),
            // Image.asset
          ], //<Widget>[]
        ), //Column
      ), //Center

    );
  }
}

class CharacterApi {
  static Future getCharacters() {
    return http.get(Uri.parse(serverurl+"getProfile/"+globalHeaderName));
  }
}
