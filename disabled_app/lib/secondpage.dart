import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Level_Page.dart';
import 'my-globals.dart';
class secondpage extends StatelessWidget {

  final String title;
  secondpage(this.title);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Profile"),
          elevation:defaultTargetPlatform==TargetPlatform.android ? 5.0 : 0.0 ,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  child: const CircleAvatar(
                    radius: 60,
                    child: Icon(Icons.person,size: 100.0,),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.deepPurple,
                      width: 5.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * .3,
                  child: Row(
                    children: [
                      Text(
                        globalHeaderName,
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                          height: 22,
                          child: Image.asset("assets/screenshots/verified.png")),
                    ],
                  ),
                ),
                Text(
                  globalHeaderEmail,
                  style: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
                Text(
                  "Current level : "+title,
                  style: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(
                  width: size.width,
                  child: Column(
                    children: [
                      for ( var i=1;i<int.parse(globallevel.split(" ")[1])+1;i++ ) GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Level_Page("Level "+i.toString())));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.verified,
                                    color: Colors.deepPurple,
                                    size: 24,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  new GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Level_Page("Level "+i.toString())));
                                    },
                                    child: new Text(
                                      "Level "+i.toString(),
                                      style: TextStyle(
                                        color: Colors.deepPurple,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   "Level "+i.toString(),
                                  //   style: TextStyle(
                                  //     color: Colors.deepPurple,
                                  //     fontSize: 18,
                                  //     fontWeight: FontWeight.w600,
                                  //   ),
                                  // ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.deepPurple,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
