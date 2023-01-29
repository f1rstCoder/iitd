
import 'package:disabled_app/secondpage.dart';
import 'package:disabled_app/server.dart';
import 'package:disabled_app/videolevelgrater3.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;
import 'package:disabled_app/video.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'games.dart';
import 'login.dart';
import 'my-globals.dart';

class Level_Page extends StatelessWidget {

  final String title;
  Level_Page(this.title);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: new AppBar(
        title: new Text(title),
        elevation:defaultTargetPlatform==TargetPlatform.android ? 5.0 : 0.0 ,
      ),
      drawer: new Drawer(
        child: new ListView(
          children: [
            new UserAccountsDrawerHeader(
              accountName: new Text(globalHeaderName),
              accountEmail: new Text(globalHeaderEmail),
              currentAccountPicture: new CircleAvatar(
                backgroundColor:
                Theme.of(context).platform==TargetPlatform. iOS
                    ? Colors.deepPurple
                    :Colors.white,
                child: new Text(globalHeaderName.split(" ")[0][0].toUpperCase()+globalHeaderName.split(" ")[1][0].toUpperCase()),
                // child: new Text("UN"),
              ),
            ),
            new ListTile(
              title: new Text("Home"),
              trailing: new Icon(Icons.home),
              // onTap: ()=> Navigator.of(context).pushNamed("/a")
              onTap: (){
                // Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>Level_Page(title)));
              },
            ), new ListTile(
              title: new Text("Profile"),
              trailing: new Icon(Icons.r_mobiledata),
              // onTap: ()=> Navigator.of(context).pushNamed("/b")
              onTap: (){
                // Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context)=>secondpage(title)));
              },
            ),
            new ListTile(
                title: new Text("close"),
                trailing: new Icon(Icons.close),
                onTap: ()=> Navigator.of(context).pop()

            ),
            new ListTile(
                title: new Text("logout"),
                trailing: new Icon(Icons.logout),
                onTap: ()=> Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>LoginPage()))
            ),
          ],
        ),
      ),
      body:SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>videos(title)));
                }, // Image tapped
                child: Image.asset ("assets/screenshots/ss.jpg",
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.44,
                    fit: BoxFit.cover),
              ),
              GestureDetector(
                onTap: () {
                    if(title == 'Level 1' || title == 'Level 2'){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>games(title)));
                    }
                    else{
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>videolevelgrater3(title)));
                    }
                  }, // Image tapped
                child: Image.asset ("assets/screenshots/vv.jpg",
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.44,
                    fit: BoxFit.cover),
              )
              // Image.asset
            ], //<Widget>[]
          ), //Column
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.language_outlined,),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LanguagePage(title)),
        ),
      ),//Center

    );
  }

}

class LanguagePage extends StatefulWidget {

  final String title1;
  LanguagePage(this.title1);
  @override
  _LanguagePageState createState() => _LanguagePageState(title1);
}

class _LanguagePageState extends State<LanguagePage> {
  final String title2;
  _LanguagePageState(this.title2);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: LocaleText("language"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("English"),
            onTap: () => [LocaleNotifier.of(context).change('en'),Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Level_Page(title2)),
            ),
            ],
          ),
          ListTile(
            title: Text("हिन्दी"),
            onTap: () => [LocaleNotifier.of(context).change('hi'),Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Level_Page(title2)),
            ),
            ],
          ),
          ListTile(
            title: Text("ਪੰਜਾਬੀ"),
            onTap: () => [LocaleNotifier.of(context).change('pa'),Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Level_Page(title2)),
            ),
            ],
          ),
        ],
      ),
    );
  }
}
