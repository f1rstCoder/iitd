import 'dart:async';
import 'dart:convert';
import 'package:disabled_app/register.dart';
import 'package:disabled_app/server.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'Level_Page.dart';
import 'my-globals.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var Fname = TextEditingController(text: "yash");
  var pass = TextEditingController(text: "a");
  int activeIndex = 0;
  List characterList = [];

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        activeIndex++;
        if (activeIndex == 4)
          activeIndex = 0;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Container(
                height: 350,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedOpacity(
                        opacity: activeIndex == 0 ? 1 : 0, 
                        duration: Duration(seconds: 1,),
                        curve: Curves.linear,
                        child: Image.asset('assets/screenshots/ab.png', height: 400,),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedOpacity(
                        opacity: activeIndex == 1 ? 1 : 0, 
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                        child: Image.asset('assets/screenshots/bc.png', height: 400,),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedOpacity(
                        opacity: activeIndex == 2 ? 1 : 0, 
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                        child: Image.asset('assets/screenshots/cb.png', height: 400,),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedOpacity(
                        opacity: activeIndex == 3 ? 1 : 0, 
                        duration: Duration(seconds: 1),
                        curve: Curves.linear,
                        child: Image.asset('assets/screenshots/yz.png', height: 400,),
                      ),
                    )
                  ]
                ),
              ),
              SizedBox(height: 40,),
              TextField(
                controller: Fname,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Username',
                  hintText: 'Username',
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  prefixIcon: Icon(Iconsax.user, color: Colors.black, size: 18, ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: pass,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                  labelText: 'Password',
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(Iconsax.key, color: Colors.black, size: 18, ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  floatingLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {}, 
                    child: Text('Forgot Password?', style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w400),),
                  )
                ],
              ),

              SizedBox(height: 30,),
              MaterialButton(
                onPressed: () async {
                  String text1,text2;

                  text1 = Fname.text ;
                  text2 = pass.text ;
                  globalUserName=text1;
                  if(text1 == '' || text2 == '')
                  {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Result"),
                          content: Text('Text Field is empty, Please Fill All Data'),
                          actions: [
                          ],
                        );
                      },
                    );
                  }
                  else{
                  //url to send the post request to
                    final url = serverurl+"login";
                    final response = await http.post(Uri.parse(url), body: json.encode({'fname' : text1,'pass' : text2}));
                    String responseBody = response.body;

                    if(responseBody != "fail"){

                      Iterable list = json.decode(response.body);
                      characterList.clear();
                      characterList.addAll(list) ;
                      print(list);
                      globalHeaderName= characterList[0]+" "+characterList[1];
                      globalHeaderEmail= characterList[2];
                      globallevel= characterList[6];
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Level_Page(characterList[6])));

                    }
                    else{
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("Invalid username and Password"),
                          );
                        },
                      );
                    }
                  }
                },
                height: 45,
                color: Colors.black,
                child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 16.0),),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?', style: TextStyle(color: Colors.grey.shade600, fontSize: 14.0, fontWeight: FontWeight.w400),),
                  TextButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>register()));
                    },
                    child: Text('SIGN-UP', style: TextStyle(color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.w400),),
                  )
                ],
              ),
            ],
          ),
        ),
      )
    );
  }

  void goToRegisterScreen() {
    Navigator.pushReplacementNamed(context, "/register");
  }
}
