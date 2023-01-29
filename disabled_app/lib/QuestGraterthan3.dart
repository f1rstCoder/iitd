import 'dart:convert';
import 'dart:ffi';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:disabled_app/server.dart';
import 'package:disabled_app/videolevelgrater3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:http/http.dart' as http;

import 'Level_Page.dart';
import 'my-globals.dart';

class QuestGraterthan3 extends StatefulWidget {
  final String index,t;
  QuestGraterthan3(this.index,this.t);

  @override
  State<QuestGraterthan3> createState() => _QuestGraterthan3(index,t);
}

class _QuestGraterthan3 extends State<QuestGraterthan3> {
  final String index1,title;
  _QuestGraterthan3(this.index1,this.title);

  late InAppWebViewController webView;
  InAppWebViewController? webViewController;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewGroupOptions _options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        webViewController?.reload();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>videolevelgrater3(title)));
            }
        ),
        title: Text("Question no "+(int.parse(index1)+1).toString()),),
        // title: Text('Score ${globalseed} / ${globalList.length}'),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                    if(0 < int.parse(index1)){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>QuestGraterthan3((int.parse(index1)-1).toString(),title)));
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("No video"),
                      ));
                    }
                  },
                child: Icon(Icons.navigate_before),
              ),
              FloatingActionButton(
                onPressed: () {
                  if(globalList.length > int.parse(index1)+1){
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>QuestGraterthan3((int.parse(index1)+1).toString(),title)));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("This is last video"),
                    ));
                  }
                  // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>QuestGraterthan3((int.parse(index1)+1).toString())));
                },
                child: Icon(Icons.navigate_next),
              )
            ],
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          child:
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    child: InAppWebView(
                      key: webViewKey,
                      initialUrlRequest: URLRequest(
                          url: Uri.parse(globalList[int.parse(index1)][1])),
                      initialOptions: _options,
                      pullToRefreshController: pullToRefreshController,
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                      },
                      onLoadStart: (controller, url) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      androidOnPermissionRequest:
                          (controller, origin, resources) async {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("androidOnPermissionRequest"),
                        ));
                        return PermissionRequestResponse(
                            resources: resources,
                            action: PermissionRequestResponseAction.GRANT);

                      },
                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
                        // var uri = navigationAction.request.url!;
                        return NavigationActionPolicy.ALLOW;
                      },
                      onLoadStop: (controller, url) async {
                        pullToRefreshController.endRefreshing();
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onLoadError: (controller, url, code, message) {
                        pullToRefreshController.endRefreshing();
                      },
                      onProgressChanged: (controller, progress) {
                        if (progress == 100) {
                          pullToRefreshController.endRefreshing();
                        }
                        setState(() {
                          this.progress = progress / 100;
                          urlController.text = this.url;
                        });
                      },
                      onUpdateVisitedHistory: (controller, url, androidIsReload) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) async {
                        print(consoleMessage);
                      },
                    ),
                  ),
                  progress < 1.0
                      ? LinearProgressIndicator(value: progress)
                      : Container(),
                ],
              ),
              Divider(thickness: 1,),

              RadioListTile(
                title: LocaleText(globalList[int.parse(index1)][2]),
                value: globalList[int.parse(index1)][2].toString(),
                groupValue: globalList[int.parse(index1)][0],
                onChanged: (value){
                  setState(() {
                    globalList[int.parse(index1)][0]=value.toString();
                    if(globalList[int.parse(index1)][6].toString()==value)
                    {
                      globalseed++;
                      updateScore();
                      if(globalList.length == globalseed){
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
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Wrong answer"),
                      ));
                    }
                  });
                },
              ),

              RadioListTile(
                title: LocaleText(globalList[int.parse(index1)][3]),
                value: globalList[int.parse(index1)][3].toString(),
                groupValue: globalList[int.parse(index1)][0],
                onChanged: (value){
                  setState(() {
                    globalList[int.parse(index1)][0]=value.toString();
                    if(globalList[int.parse(index1)][6].toString()==value)
                    {
                      globalseed++;
                      updateScore();
                      if(globalList.length == globalseed){
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
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Wrong answer"),
                      ));
                    }
                  });
                },
              ),

              RadioListTile(
                title: LocaleText(globalList[int.parse(index1)][4]),
                value: globalList[int.parse(index1)][4].toString(),
                groupValue: globalList[int.parse(index1)][0],
                onChanged: (value){
                  setState(() {
                    globalList[int.parse(index1)][0]=value.toString();
                    if(globalList[int.parse(index1)][6].toString()==value)
                    {
                      globalseed++;
                      updateScore();
                      if(globalList.length == globalseed){
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
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Wrong answer"),
                      ));
                    }
                  });
                },
              ),

              RadioListTile(
                title: LocaleText(globalList[int.parse(index1)][5]),
                value: globalList[int.parse(index1)][5].toString(),
                groupValue: globalList[int.parse(index1)][0],
                onChanged: (value){
                  setState(() {
                    globalList[int.parse(index1)][0]=value.toString();
                    if(globalList[int.parse(index1)][6].toString()==value)
                    {
                      globalseed++;
                      updateScore();
                      if(globalList.length == globalseed){
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
                    else
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Wrong answer"),
                      ));
                    }
                  });
                },
              ),

            ],
          ),
        ),
      ),

    );
  }

  Future<void> updateScore() async {

    final url = serverurl+"updateMCQLevel";
    final response = await http.post(Uri.parse(url), body: json.encode({'score' : globalseed,'username' : globalUserName,'email' : globalHeaderEmail,'level' : title}));
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

