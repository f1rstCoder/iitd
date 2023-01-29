import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class ChangeLang extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<ChangeLang> {

  GoogleTranslator translator = new GoogleTranslator();   //using google translator
  
  
  // late String out;
  final lang=TextEditingController();   //getting text


  void trans()
  {
    
    translator.translate(lang.text, to: 'hi')   //translating to hi = hindi
      .then((output) 
      {
          // setState(() {
          //  output;                          //placing the translated text to the String to be used
          // });
          print(output);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transalate !!"),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: lang,
              ),
              TextButton(
            child: Text("Press !!"),            //on press to translate the language using function
            onPressed: ()
            {
              trans();
            },
          ),
          // Text(out.toString())                    //translated string
            ],
          )
        ),
      ),
    );
  }
}

