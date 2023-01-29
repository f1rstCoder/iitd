
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:disabled_app/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_locales/flutter_locales.dart';

import 'Level_Page.dart';
import 'my-globals.dart';
import 'package:http/http.dart' as http;

class ViewVideo extends StatefulWidget {

  final String t,l,i;
  ViewVideo(this.t,this.l,this.i);

  @override
  State<ViewVideo> createState() => _gamesState(t,l,i);
}

class _gamesState extends State<ViewVideo> {

  final String title,level,id;
  _gamesState(this.title,this.level,this.id);

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
        title: LocaleText(title),
      ),
        body: SafeArea(
            child: Column(children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      initialUrlRequest: URLRequest(
                          url: Uri.parse(globalvideolink)),
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

                        final url = serverurl+"updateVideoLevel";
                        final response = await http.post(Uri.parse(url), body: json.encode({'id' : id,'level' : level,'username' : globalUserName,'email' : globalHeaderEmail}));
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
                        else{
                          final url = serverurl+"getunseenvideos";
                          final response = await http.post(Uri.parse(url), body: json.encode({'email' : globalHeaderEmail}));
                          String responseBody = response.body;

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: AutoSizeText(responseBody),
                          ));

                        }
                      },
                    ),
                    progress < 1.0
                        ? LinearProgressIndicator(value: progress)
                        : Container(),
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: Icon(Icons.refresh),
                    onPressed: () {
                      webViewController?.reload();
                    },
                  ),
                ],
              ),
            ])));
  }

  Future<void> goToLoginScreen() async {

    final url = serverurl+"getUserLevel";
    final response = await http.post(Uri.parse(url), body: json.encode({'email' : globalHeaderEmail}));
    String responseBody = response.body;

    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context)=>Level_Page(responseBody.toString())));
  }
}
