import 'dart:async';
import 'dart:convert';
import 'package:disabled_app/server.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'login.dart';

class register extends StatefulWidget {
  const register({ Key? key }) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {

  var Fname = TextEditingController();
  var Lname = TextEditingController();
  var email = TextEditingController();
  var pass = TextEditingController();
  var phone = TextEditingController();
  var age = TextEditingController();
  int activeIndex = 0;

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
                    labelText: 'First name',
                    hintText: 'Enter first name..',
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
                  controller: Lname,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    labelText: 'Last name',
                    hintText: 'Enter last name..',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
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
                  controller: email,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    labelText: 'Email',
                    hintText: 'Enter email id..',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                    ),
                    prefixIcon: Icon(Iconsax.magic_star, color: Colors.black, size: 18, ),
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
                    hintText: 'Enter password...',
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
                SizedBox(height: 20,),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: phone,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    labelText: 'Mobile number',
                    hintText: 'Enter mobile no...',
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
                SizedBox(height: 20,),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: age,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0.0),
                    labelText: 'Age',
                    hintText: 'Enter age',
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
                    String text1,text2,text3,text4,text5,text6;

                    text1 = Fname.text ;
                    text2 = Lname.text ;
                    text3 = email.text;
                    text4 = pass.text;
                    text5 = phone.text;
                    text6 = age.text;

                    final RegExp emailValidatorRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+.com");


                    if(text1 == '' || text2 == '' || text3 == '' || text4 == ''|| text5 == ''|| text6 == '')
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
                    else if(!emailValidatorRegExp.hasMatch(text3))
                    {
                      showDialog(
                        context: context,
                        builder: (context) {

                          return AlertDialog(
                            title: Text("Result"),
                            content: Text('Email must be valid'),
                            actions: [

                            ],
                          );
                        },
                      );
                    }
                    else if(text5.length != 10)
                    {
                      showDialog(
                        context: context,
                        builder: (context) {

                          return AlertDialog(
                            title: Text("Result"),
                            content: Text('Mobile number must be valid'),
                            actions: [

                            ],
                          );
                        },
                      );
                    }
                    else{
                      //url to send the post request to
                      final url = serverurl+"register";

                      //sending a post request to the url
                      final response = await http.post(Uri.parse(url), body: json.encode({'fname' : text1,'lname' : text2,'email' : text3,'password' : text4,'phone' : text5,'age' : text6}));

                      String responseBody = response.body;

                      if(responseBody == "success"){
                        showDialog(
                          context: context,
                          builder: (context) {
                            Widget okButton = TextButton(
                              child: Text("OK"),
                              onPressed: goToLoginScreen,
                            );
                            return AlertDialog(
                              title: Text("Result"),
                              content: Text("You have been registered !\nYou can now log in."),
                              actions: [
                                okButton,
                              ],
                            );
                          },
                        ).then((value) {
                          goToLoginScreen();
                        });
                      }
                      else if(responseBody == "notvalid"){
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("Please enter valid email !"),
                            );
                          },
                        );
                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("Something is wrong !"),
                            );
                          },
                        );
                      }
                    }


                  },

                  height: 45,
                  color: Colors.black,
                  child: Text("Register", style: TextStyle(color: Colors.white, fontSize: 16.0),),
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
                        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>LoginPage()));
                      },
                      child: Text('SIGN IN', style: TextStyle(color: Colors.blue, fontSize: 14.0, fontWeight: FontWeight.w400),),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }


  void goToLoginScreen() {
    Navigator.pushReplacementNamed(context, "/login");
  }

  void goToRegisterScreen() {
    Navigator.pushReplacementNamed(context, "/register");
  }


}
