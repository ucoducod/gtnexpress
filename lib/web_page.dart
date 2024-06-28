//For webview
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
//For bar
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:flutter_webview_pro/platform_interface.dart';

const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML 
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter 
  webview</a> plugin.
</p>

</body>
</html>
''';

const String kTransparentBackgroundPage = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Transparent background test</title>
  </head>
  <style type="text/css">
    body { background: transparent; margin: 0; padding: 0; }
    #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
    #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
    p { text-align: center; }
  </style>
  <body>
    <div id="container">
      <p>Transparent background test</p>
      <div id="shape"></div>
    </div>
  </body>
  </html>
''';

class WebViewExample extends StatefulWidget {
  final int recordObject;

  // const WebViewExample({this.cookieManager});
  final CookieManager cookieManager;

  const WebViewExample({Key key, @required this.recordObject, this.cookieManager})
      : super(key: key);

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  int recordObject;
  String urlx = "quanlyvandon";
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool loggedIn = false;
  Future<String> fmcookie;
  final storage = const FlutterSecureStorage();
  String usernamex;
  String passwordx;
  String tokenx;

  _readtoken() async {
    final yourApiTokenHere = await storage.read(key: "storagetoken");
    setState(() {
      tokenx = yourApiTokenHere;
    });
    print("Lay thong tin pass $tokenx");
    return yourApiTokenHere;
  }
  _readusername() async {
    final all = await storage.read(key: "appusername");
    final yourApiTokenHere = await storage.read(key: "storagetoken");
    // print("Lay thong tin username ${all}");
    setState(() {
      usernamex = all;
      tokenx = yourApiTokenHere;
    });
    print("Lay thong tin pass${all} $tokenx");
    return all;
  }

  _readpassword() async {
    final all = await storage.read(key: "apppassword");
    // print("Lay thong tin pass${all}");
    setState(() => passwordx = all);
    return all;
  }

  @override
  void initState() {
    super.initState();
    _readtoken();
    _readusername();
    _readpassword();
    recordObject = widget.recordObject;
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recordObject == 1) {
      // print("yes${recordObject}");
      urlx = "vandon";
    }
    return Scaffold(
      // backgroundColor: Colors.green,
      // appBar: AppBar(
      //   // title:  Text(
      //   //   'Tao don',
      //   //   style: TextStyle(
      //   //     fontSize: 14,
      //   //     foreground: Paint()
      //   //       ..style = PaintingStyle.stroke
      //   //       ..strokeWidth = 1
      //   //       ..color = Colors.blue[700],
      //   //   ),
      //   // ),
      //   // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      //   actions: <Widget>[
      //     NavigationControls(_controller.future),
      //     SampleMenu(_controller.future, widget.cookieManager),
      //   ],
      // ),
      body: WebView(
        // initialUrl: 'https://gtnexpress.vn/auth/login?next=vandon',
        // initialUrl: 'https://gtnexpress.vn/$urlx',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          // final cookieManager = CookieManager();
          // cookieManager.clearCookies();
          Map<String, String> header =  {'Authorization': 'Bearer $tokenx'};
          print(header.toString());
          _controller.complete(webViewController);
          webViewController.loadUrl(
            'https://gtnexpress.vn/$urlx',
            // headers: header,
          );
        },
        onProgress: (int progress) {
          // print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            // print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          // print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          // print('Page started loading: $url');
        },
        // onPageFinished: (String url) {
        //   print('Page finished loading: $url');
        // },
        onPageFinished: (String url) {
          setState(() {
            // print('Page finished loading: $url');
            _controller.future.then((value) => value.evaluateJavascript('''
            if (document.contains(document.getElementById("mNavbar"))) {
                document.getElementById("mNavbar").remove();
            } else {
                // lastDiv.appendChild(submitButton);  
            }
            if (document.contains(document.getElementById("nav_menu"))) {
                document.getElementById("nav_menu").remove();
            }
            if (document.contains(document.getElementById("search_menu"))) {
                document.getElementById("search_menu").remove();
            }
            if (document.contains(document.getElementById(""))) {
                document.getElementById("nguoigui_menu").remove();
            }
            if (document.contains(document.getElementById("username"))) {
                var username = document.getElementById("username");
                 var password = document.getElementById("pwd_login");
                 username.value = "${usernamex.toString()}";
                 password.value = "${passwordx.toString()}";
                 document.getElementById('login').click();
            }
            
            '''));
            // print("loggedin 1 " + loggedIn.toString());

            // if(loggedIn == false) {
            //   _controller.future.then((value) =>
            //       value.evaluateJavascript('''
            //                  var username = document.getElementById("username");
            //                  var password = document.getElementById("pwd_login");
            //                  username.value = "${usernamex.toString()}";
            //                  password.value = "${passwordx.toString()}";
            //                  document.getElementById('login').click();
            //                '''));
            //   // _controller.future.then((value) {
            //   //   fmcookie = value.evaluateJavascript('''document.cookie''');
            //   //   if ( fmcookie == null) {
            //   //     print('No data fmcookie');
            //   //   } else {
            //   //     fmcookie.then((value) {
            //   //       String stringxx = value;
            //   //       print('Yes data fmcookie');
            //   //       print(stringxx);
            //   //     });
            //   //   }
            //   // });
            loggedIn = true;
            //   print("loggedin 2 " + loggedIn.toString());
            // }
          });
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    // if (recordObject == 99) {
    //   return FloatingActionButton(
    //     child: const Icon(Icons.home),
    //     onPressed: () => Navigator.of(context).pop(true),
    //     backgroundColor: Colors.lightBlueAccent,
    //     foregroundColor: Colors.black,
    //   );
    // } else {
    //   // return FutureBuilder<WebViewController>(
    //   //     future: _controller.future,
    //   //     builder: (BuildContext context,
    //   //         AsyncSnapshot<WebViewController> controller) {
    //   //       return FloatingActionButton(
    //   //         onPressed: () async {
    //   //           String url;
    //   //           if (controller.hasData) {
    //   //             url = (await controller.data.currentUrl());
    //   //           }
    //   //           ScaffoldMessenger.of(context).showSnackBar(
    //   //             SnackBar(
    //   //               content: Text(
    //   //                 controller.hasData
    //   //                     ? 'Favorited $url'
    //   //                     : 'Unable to favorite',
    //   //               ),
    //   //             ),
    //   //           );
    //   //         },
    //   //         child: const Icon(Icons.favorite),
    //   //       );
    //   //     });
    // }
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.cloud_upload_outlined),
      // onPressed: () => WebViewUpload(recordObject: 1),
      onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) =>WebViewUpload(recordObject: 1)));
      },
      backgroundColor: Colors.lightBlueAccent,
      foregroundColor: Colors.black,
    );
  }
}


class WebViewEdit extends StatefulWidget {
  final int recordObject;

  // const WebViewExample({this.cookieManager});
  final CookieManager cookieManager;
  const WebViewEdit({Key key, @required this.recordObject, this.cookieManager})
      : super(key: key);

  @override
  _WebViewEditState createState() => _WebViewEditState();
}

class _WebViewEditState extends State<WebViewEdit> {
  int recordObject;
  String urlx = "suavandon";
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  bool loggedIn = false;
  Future<String> fmcookie;
  final storage = const FlutterSecureStorage();
  String usernamex;
  String passwordx;
  String tokenx;
  _readtoken() async {
    final yourApiTokenHere = await storage.read(key: "storagetoken");
    setState(() {
      tokenx = yourApiTokenHere;
    });
    return yourApiTokenHere;
  }
  _readusername() async {
    final all = await storage.read(key: "appusername");
    final yourApiTokenHere = await storage.read(key: "storagetoken");
    // print("Lay thong tin username ${all}");
    setState(() {
      usernamex = all;
      tokenx = yourApiTokenHere;
    });
    return all;
  }

  _readpassword() async {
    final all = await storage.read(key: "apppassword");
    // print("Lay thong tin pass${all}");
    setState(() => passwordx = all);
    return all;
  }

  @override
  void initState() {
    super.initState();
    _readtoken();
    _readusername();
    _readpassword();
    recordObject = widget.recordObject;
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        // title:  Text(
        //   'Danhboard',
        //   style: TextStyle(
        //     fontSize: 14,
        //     foreground: Paint()
        //       ..style = PaintingStyle.stroke
        //       ..strokeWidth = 1
        //       ..color = Colors.blue[700],
        //   ),
        // ),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          // NavigationControls(_controller.future),
          // SampleMenu(_controller.future, widget.cookieManager),
        ],
      ),
      body: WebView(
        // initialUrl: 'https://gtnexpress.vn/auth/login?next=vandon',
        // initialUrl: 'https://gtnexpress.vn/$urlx?van_don_id=$recordObject',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          // final cookieManager = CookieManager();
          // cookieManager.clearCookies();
          Map<String, String> header =  {'Authorization': 'Bearer $tokenx'};
          print(header.toString());
          _controller.complete(webViewController);
          webViewController.loadUrl(
            'https://gtnexpress.vn/$urlx?van_don_id=$recordObject',
            // headers: header,
          );
        },
        onProgress: (int progress) {
          // print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            // print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          // print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          // print('Page started loading: $url');
        },
        // onPageFinished: (String url) {
        //   print('Page finished loading: $url');
        // },
        onPageFinished: (String url) {
          setState(() {
            // print('Page finished loading: $url');
            _controller.future.then((value) => value.evaluateJavascript('''
            if (document.contains(document.getElementById("mNavbar"))) {
                document.getElementById("mNavbar").remove();
            } else {
                // lastDiv.appendChild(submitButton);  
            }
            if (document.contains(document.getElementById("nav_menu"))) {
                document.getElementById("nav_menu").remove();
            }
            if (document.contains(document.getElementById("search_menu"))) {
                document.getElementById("search_menu").remove();
            }
            if (document.contains(document.getElementById("username"))) {
                var username = document.getElementById("username");
                 var password = document.getElementById("pwd_login");
                 username.value = "${usernamex.toString()}";
                 password.value = "${passwordx.toString()}";
                 document.getElementById('login').click();
            }
            '''));
            // print("loggedin 1 " + loggedIn.toString());
            loggedIn = true;

          });
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
      floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
      return FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.home),
        // onPressed: () => Navigator.of(context).pop(true),
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) =>WebViewExample(recordObject: 1)));
        },
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.black,
      );
  }
}

class WebViewUpload extends StatefulWidget {
  final int recordObject;

  // const WebViewExample({this.cookieManager});
  final CookieManager cookieManager;
  const WebViewUpload({Key key, @required this.recordObject, this.cookieManager})
      : super(key: key);

  @override
  _WebViewUploadState createState() => _WebViewUploadState();
}

class _WebViewUploadState extends State<WebViewUpload> {
  int recordObject;
  String urlx = "suavandon";
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  bool loggedIn = false;
  Future<String> fmcookie;
  final storage = const FlutterSecureStorage();
  String usernamex;
  String passwordx;
  String tokenx;
  _readtoken() async {
    final yourApiTokenHere = await storage.read(key: "storagetoken");
    setState(() {
      tokenx = yourApiTokenHere;
    });
    return yourApiTokenHere;
  }
  _readusername() async {
    final all = await storage.read(key: "appusername");
    final yourApiTokenHere = await storage.read(key: "storagetoken");
    // print("Lay thong tin username ${all}");
    setState(() {
      usernamex = all;
      tokenx = yourApiTokenHere;
    });
    return all;
  }

  _readpassword() async {
    final all = await storage.read(key: "apppassword");
    // print("Lay thong tin pass${all}");
    setState(() => passwordx = all);
    return all;
  }

  @override
  void initState() {
    super.initState();
    _readtoken();
    _readusername();
    _readpassword();
    recordObject = widget.recordObject;
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    // Enable virtual display.
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        // title:  Text(
        //   'Danhboard',
        //   style: TextStyle(
        //     fontSize: 14,
        //     foreground: Paint()
        //       ..style = PaintingStyle.stroke
        //       ..strokeWidth = 1
        //       ..color = Colors.blue[700],
        //   ),
        // ),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          // NavigationControls(_controller.future),
          // SampleMenu(_controller.future, widget.cookieManager),
        ],
      ),
      body: WebView(
        // initialUrl: 'https://gtnexpress.vn/auth/login?next=vandon',
        // initialUrl: 'https://gtnexpress.vn/$urlx?van_don_id=$recordObject',
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          // final cookieManager = CookieManager();
          // cookieManager.clearCookies();
          Map<String, String> header =  {'Authorization': 'Bearer $tokenx'};
          print(header.toString());
          _controller.complete(webViewController);
          webViewController.loadUrl(
            'https://gtnexpress.vn/uploads',
            // headers: header,
          );
        },
        onProgress: (int progress) {
          // print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            // print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          // print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          // print('Page started loading: $url');
        },
        // onPageFinished: (String url) {
        //   print('Page finished loading: $url');
        // },
        onPageFinished: (String url) {
          setState(() {
            // print('Page finished loading: $url');
            _controller.future.then((value) => value.evaluateJavascript('''
            if (document.contains(document.getElementById("mNavbar"))) {
                document.getElementById("mNavbar").remove();
            } else {
                // lastDiv.appendChild(submitButton);  
            }
            if (document.contains(document.getElementById("nav_menu"))) {
                document.getElementById("nav_menu").remove();
            }
            if (document.contains(document.getElementById("search_menu"))) {
                document.getElementById("search_menu").remove();
            }
            if (document.contains(document.getElementById("username"))) {
                var username = document.getElementById("username");
                 var password = document.getElementById("pwd_login");
                 username.value = "${usernamex.toString()}";
                 password.value = "${passwordx.toString()}";
                 document.getElementById('login').click();
            }
            '''));
            // print("loggedin 1 " + loggedIn.toString());
            loggedIn = true;

          });
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
      // floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FloatingActionButton(
      heroTag: null,
      child: const Icon(Icons.add),
      // onPressed: () => WebViewUpload(recordObject: 1),
      onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: (context) =>WebViewExample(recordObject: 1)));
      },
      backgroundColor: Colors.lightBlueAccent,
      foregroundColor: Colors.black,
    );
  }
}

enum MenuOptions {
  showUserAgent,
  listCookies,
  listVandons,
  createVandons,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
  doPostRequest,
  loadLocalFile,
  loadFlutterAsset,
  loadHtmlString,
  transparentBackground,
  setCookie,
}

class SampleMenu extends StatelessWidget {
  SampleMenu(this.controller, CookieManager cookieManager, {Key key})
      : cookieManager = cookieManager ?? CookieManager(), super(key: key);

  final Future<WebViewController> controller;
  final CookieManager cookieManager;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        return PopupMenuButton<MenuOptions>(
          key: const ValueKey<String>('ShowPopupMenu'),
          onSelected: (MenuOptions value) {
            switch (value) {
              case MenuOptions.listVandons:
                _onListVandons(controller.data, context);
                break;
              case MenuOptions.createVandons:
                _onCreateVandons(controller.data, context);
                break;
              case MenuOptions.showUserAgent:
                _onShowUserAgent(controller.data, context);
                break;
              case MenuOptions.listCookies:
                _onListCookies(controller.data, context);
                break;
              case MenuOptions.clearCookies:
                _onClearCookies(context);
                break;
              case MenuOptions.addToCache:
                _onAddToCache(controller.data, context);
                break;
              case MenuOptions.listCache:
                _onListCache(controller.data, context);
                break;
              case MenuOptions.clearCache:
                _onClearCache(controller.data, context);
                break;
              case MenuOptions.navigationDelegate:
                _onNavigationDelegateExample(controller.data, context);
                break;
              case MenuOptions.doPostRequest:
                _onDoPostRequest(controller.data, context);
                break;
              case MenuOptions.loadLocalFile:
                _onLoadLocalFileExample(controller.data, context);
                break;
              case MenuOptions.loadFlutterAsset:
                _onLoadFlutterAssetExample(controller.data, context);
                break;
              case MenuOptions.loadHtmlString:
                _onLoadHtmlStringExample(controller.data, context);
                break;
              case MenuOptions.transparentBackground:
                _onTransparentBackground(controller.data, context);
                break;
              case MenuOptions.setCookie:
                _onSetCookie(controller.data, context);
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<MenuOptions>>[
            PopupMenuItem<MenuOptions>(
              value: MenuOptions.showUserAgent,
              child: const Text('Show user agent'),
              enabled: controller.hasData,
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listVandons,
              child: Text('List vandons'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.createVandons,
              child: Text('Create vandons'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listCookies,
              child: Text('List cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCookies,
              child: Text('Clear cookies'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.addToCache,
              child: Text('Add to cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.listCache,
              child: Text('List cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.clearCache,
              child: Text('Clear cache'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.navigationDelegate,
              child: Text('Navigation Delegate example'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.doPostRequest,
              child: Text('Post Request'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.loadHtmlString,
              child: Text('Load HTML string'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.loadLocalFile,
              child: Text('Load local file'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.loadFlutterAsset,
              child: Text('Load Flutter Asset'),
            ),
            const PopupMenuItem<MenuOptions>(
              key: ValueKey<String>('ShowTransparentBackgroundExample'),
              value: MenuOptions.transparentBackground,
              child: Text('Transparent background example'),
            ),
            const PopupMenuItem<MenuOptions>(
              value: MenuOptions.setCookie,
              child: Text('Set cookie'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _onShowUserAgent(
      WebViewController controller, BuildContext context) async {
    // Send a message with the user agent string to the Toaster JavaScript channel we registered
    // with the WebView.
    await controller.runJavascript(
        'Toaster.postMessage("User Agent: " + navigator.userAgent);');
  }

  Future<void> _onListCookies(
      WebViewController controller, BuildContext context) async {
    final String cookies =
        await controller.runJavascriptReturningResult('document.cookie');

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Cookies:'),
          _getCookieList(cookies),
        ],
      ),
    ));
  }

  Future<void> _onListVandons(
      WebViewController controller, BuildContext context) async {
    // final String cookies = await controller.runJavascriptReturningResult('document.cookie');
    await controller.loadUrl('https://gtnexpress.vn/quanlyvandon');
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //       const Text('Cookies:'),
    //       _getCookieList(cookies),
    //     ],
    //   ),
    // ));
  }

  Future<void> _onCreateVandons(
      WebViewController controller, BuildContext context) async {
    // final String cookies = await controller.runJavascriptReturningResult('document.cookie');
    await controller.loadUrl('https://gtnexpress.vn/vandon');
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     mainAxisSize: MainAxisSize.min,
    //     children: <Widget>[
    //       const Text('Cookies:'),
    //       _getCookieList(cookies),
    //     ],
    //   ),
    // ));
  }

  Future<void> _onAddToCache(
      WebViewController controller, BuildContext context) async {
    await controller.runJavascript(
        'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Added a test entry to cache.'),
    ));
  }

  Future<void> _onListCache(
      WebViewController controller, BuildContext context) async {
    await controller.runJavascript('caches.keys()'
        '.then((cacheKeys) => JSON.stringify({"cacheKeys" : cacheKeys, "localStorage" : localStorage}))'
        '.then((caches) => Toaster.postMessage(caches))');
  }

  Future<void> _onClearCache(
      WebViewController controller, BuildContext context) async {
    await controller.clearCache();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Cache cleared.'),
    ));
  }

  Future<void> _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> _onNavigationDelegateExample(
      WebViewController controller, BuildContext context) async {
    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(kNavigationExamplePage));
    await controller.loadUrl('data:text/html;base64,$contentBase64');
  }

  Future<void> _onSetCookie(
      WebViewController controller, BuildContext context) async {
    await cookieManager.setCookie(
      const WebViewCookie(
          // name: 'foo', value: 'bar', domain: 'httpbin.org', path: '/anything'),
          name: 'appsession',
          value: 'Login by app',
          domain: 'gtnexpress.vn',
          path: '/'),
    );
    await controller.loadUrl('https://gtnexpress.vn/quanlyvandon');
  }

  Future<void> _onDoPostRequest(
      WebViewController controller, BuildContext context) async {
    final WebViewRequest request = WebViewRequest(
      uri: Uri.parse('https://httpbin.org/post'),
      method: WebViewRequestMethod.post,
      headers: <String, String>{'foo': 'bar', 'Content-Type': 'text/plain'},
      body: Uint8List.fromList('Test Body'.codeUnits),
    );
    await controller.loadRequest(request);
  }

  Future<void> _onLoadLocalFileExample(
      WebViewController controller, BuildContext context) async {
    final String pathToIndex = await _prepareLocalFile();

    await controller.loadFile(pathToIndex);
  }

  Future<void> _onLoadFlutterAssetExample(
      WebViewController controller, BuildContext context) async {
    await controller.loadFlutterAsset('assets/www/index.html');
  }

  Future<void> _onLoadHtmlStringExample(
      WebViewController controller, BuildContext context) async {
    await controller.loadHtmlString(kLocalExamplePage);
  }

  Future<void> _onTransparentBackground(
      WebViewController controller, BuildContext context) async {
    await controller.loadHtmlString(kTransparentBackgroundPage);
  }

  Widget _getCookieList(String cookies) {
    if (cookies == null || cookies == '""') {
      return Container();
    }
    final List<String> cookieList = cookies.split(';');
    final Iterable<Text> cookieWidgets =
        cookieList.map((String cookie) => Text(cookie));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: cookieWidgets.toList(),
    );
  }

  static Future<String> _prepareLocalFile() async {
    final String tmpDir = (await getTemporaryDirectory()).path;
    final File indexFile = File(
        <String>{tmpDir, 'www', 'index.html'}.join(Platform.pathSeparator));

    await indexFile.create(recursive: true);
    await indexFile.writeAsString(kLocalExamplePage);

    return indexFile.path;
  }
}

class NavigationControls extends StatelessWidget {
  const NavigationControls(this._webViewControllerFuture)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoBack()) {
                        await controller.goBack();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('No back history item')),
                        );
                        return;
                      }
                    },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: !webViewReady
                  ? null
                  : () async {
                      if (await controller.canGoForward()) {
                        await controller.goForward();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('No forward history item')),
                        );
                        return;
                      }
                    },
            ),
            // IconButton(
            //   icon: const Icon(Icons.replay),
            //   onPressed: webViewReady
            //       ? null
            //       : () {
            //     controller.reload();
            //   },
            // ),
          ],
        );
      },
    );
  }
}

////For Bar
BuildContext testContext;

class MyAppX extends StatelessWidget {
  const MyAppX({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Bottom Navigation Bar example project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CustomWidgetExample(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/first': (context) => const MainScreen2(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => const MainScreen3(),
      },
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Project"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              child: const Text("Custom widget example"),
              onPressed: () => pushNewScreen(
                context,
                screen: CustomWidgetExample(
                  menuScreenContext: context,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              child: const Text("Built-in styles example"),
              onPressed: () => pushNewScreen(
                context,
                screen: ProvidedStylesExample(
                  menuScreenContext: context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------- Provided Style ----------------------------------------- //

class ProvidedStylesExample extends StatefulWidget {
  final BuildContext menuScreenContext;
  const ProvidedStylesExample({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<ProvidedStylesExample> {
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => const MainScreen2(),
            '/second': (context) => const MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.add),
          title: ("Add"),
          activeColorPrimary: Colors.blueAccent,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.white,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: '/',
            routes: {
              '/first': (context) => const MainScreen2(),
              '/second': (context) => const MainScreen3(),
            },
          ),
          onPressed: (context) {
            pushDynamicScreen(context,
                screen: SampleModalScreen(), withNavBar: true);
          }),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.message),
        title: ("Messages"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => const MainScreen2(),
            '/second': (context) => const MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => const MainScreen2(),
            '/second': (context) => const MainScreen3(),
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Bar Demo')),
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text('This is the Drawer'),
            ],
          ),
        ),
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
            ? 0.0
            : kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: const EdgeInsets.all(0.0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        onWillPop: (context) async {
          await showDialog(
            context: context,
            useSafeArea: true,
            builder: (context) => Container(
              height: 50.0,
              width: 50.0,
              color: Colors.white,
              child: ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        selectedTabScreenContext: (context) {
          testContext = context;
        },
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
            colorBehindNavBar: Colors.indigo,
            borderRadius: BorderRadius.circular(20.0)),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style17, // Choose the nav bar style with this property
      ),
    );
  }
}

// ----------------------------------------- Custom Style ----------------------------------------- //

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget({
    Key key,
    this.selectedIndex,
    @required this.items,
    this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0,
                  color: isSelected
                      ? (item.activeColorSecondary ?? item.activeColorPrimary)
                      : item.inactiveColorPrimary ?? item.activeColorPrimary),
              child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                item.title,
                style: TextStyle(
                    color: isSelected
                        ? (item.activeColorSecondary ?? item.activeColorPrimary)
                        : item.inactiveColorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  const MainScreen(
      {Key key,
      this.menuScreenContext,
      this.onScreenHideButtonPressed,
      this.hideStatus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Scaffold(
          backgroundColor: Colors.indigo,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 20.0),
                child: TextField(
                  decoration: InputDecoration(hintText: "Test Text Field"),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    pushNewScreenWithRouteSettings(
                      context,
                      settings: const RouteSettings(name: '/home'),
                      screen: const MainScreen2(),
                      pageTransitionAnimation:
                          PageTransitionAnimation.scaleRotate,
                    );
                  },
                  child: const Text(
                    "Go to Second Screen ->",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      useRootNavigator: true,
                      builder: (context) => Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Exit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Push bottom sheet on TOP of Nav Bar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      useRootNavigator: false,
                      builder: (context) => Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Exit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Push bottom sheet BEHIND the Nav Bar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    pushDynamicScreen(context,
                        screen: SampleModalScreen(), withNavBar: true);
                  },
                  child: const Text(
                    "Push Dynamic/Modal Screen",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    onScreenHideButtonPressed();
                  },
                  child: Text(
                    hideStatus
                        ? "Unhide Navigation Bar"
                        : "Hide Navigation Bar",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(menuScreenContext).pop();
                  },
                  child: const Text(
                    "<- Main Menu",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreen2 extends StatelessWidget {
  const MainScreen2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                pushNewScreen(context, screen: const MainScreen3());
              },
              child: const Text(
                "Go to Third Screen",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Go Back to First Screen",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen3 extends StatelessWidget {
  const MainScreen3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrangeAccent,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Go Back to Second Screen",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class SampleModalScreen extends ModalRoute<void> {
  SampleModalScreen();

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width * 0.3,
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            "This is a modal screen",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 26.0,
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Return",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomWidgetExample extends StatefulWidget {
  final BuildContext menuScreenContext;
  const CustomWidgetExample({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _CustomWidgetExampleState createState() => _CustomWidgetExampleState();
}

class _CustomWidgetExampleState extends State<CustomWidgetExample> {
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.add),
        title: ("Add"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.custom(
      context,
      controller: _controller,
      screens: _buildScreens(),
      confineInSafeArea: true,
      itemCount: 5,
      handleAndroidBackButtonPress: true,
      stateManagement: true,
      hideNavigationBar: _hideNavBar,
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      customWidget: CustomNavBarWidget(
        items: _navBarsItems(),
        onItemSelected: (index) {
          setState(() {
            _controller.index = index; // THIS IS CRITICAL!! Don't miss it!
          });
        },
        selectedIndex: _controller.index,
      ),
    );
  }
}

//Quanlyvandonwebview
class WebViewQuanly extends StatefulWidget {
  const WebViewQuanly({this.cookieManager});

  final CookieManager cookieManager;

  @override
  _WebViewQuanlyState createState() => _WebViewQuanlyState();
}

class _WebViewQuanlyState extends State<WebViewQuanly> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool loggedIn = false;
  Future<String> fmcookie;

  final storage = const FlutterSecureStorage();
  String usernamex;
  String passwordx;
  String tokenx;
  _readtoken() async {
    // final all = await storage.read(key: "appusername");
    final yourApiTokenHere = await storage.read(key: "storagetoken");
    // print("Lay thong tin username ${all}");
    setState(() {
      tokenx = yourApiTokenHere;
    });
    return yourApiTokenHere;
  }
  _readusername() async {
    final all = await storage.read(key: "appusername");
    final yourApiTokenHere = await storage.read(key: "storagetoken");
    // print("Lay thong tin username ${all}");
    setState(() {
      usernamex = all;
      tokenx = yourApiTokenHere;
    });
    return all;
  }

  _readpassword() async {
    final all = await storage.read(key: "apppassword");
    // print("Lay thong tin pass${all}");
    setState(() => passwordx = all);
    return all;
  }

  @override
  void initState() {
    super.initState();
    _readtoken();
    _readusername();
    _readpassword();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      appBar: AppBar(
        title:  Text(
          'Danhboard',
          style: TextStyle(
            fontSize: 14,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Colors.blue[700],
          ),
        ),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
          NavigationControls(_controller.future),
          // SampleMenu(_controller.future, widget.cookieManager),
        ],
      ),
      body: WebView(
        // initialUrl: 'https://gtnexpress.vn/vandon',
        // "https://gtnexpress.vn/vandon", headers: {"Authorization": "Bearer ${tokenx}"},
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          // final cookieManager = CookieManager();
          // cookieManager.clearCookies();
          Map<String, String> header =  {'Authorization': 'Bearer ${tokenx?.toString()}'};
          print(header.toString());
          _controller.complete(webViewController);
          webViewController.loadUrl(
            'https://gtnexpress.vn/vandon',
            // headers: header,
          );
        },
        onProgress: (int progress) {
          // print('WebView is loading (progress : $progress%)');
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            // print('blocking navigation to $request}');
            return NavigationDecision.prevent;
          }
          // print('allowing navigation to $request');
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          // print('Page started loading: $url');
        },
        // onPageFinished: (String url) {
        //   print('Page finished loading: $url');
        // },
        onPageFinished: (String url) {
          setState(() {
            // print('Page finished loading: $url');

            _controller.future.then((value) => value.evaluateJavascript('''
            if (document.contains(document.getElementById("mNavbar"))) {
                document.getElementById("mNavbar").remove();
            } else {
                // lastDiv.appendChild(submitButton);  
            }
            if (document.contains(document.getElementById("nav_menu"))) {
                document.getElementById("nav_menu").remove();
            }
            if (document.contains(document.getElementById("username"))) {
                var username = document.getElementById("username");
                 var password = document.getElementById("pwd_login");
                 username.value = "${usernamex.toString()}";
                 password.value = "${passwordx.toString()}";
                 document.getElementById('login').click();
            }
            '''));

            // print("loggedin " + loggedIn.toString());
            // if(loggedIn == false) {
            //   _controller.future.then((value) =>
            //       value.evaluateJavascript('''
            //                  var username = document.getElementById("username");
            //                  var password = document.getElementById("pwd_login");
            //                  username.value = "mexpress";
            //                  password.value = "123";
            //                  document.getElementById('login').click();
            //                '''));
            //   _controller.future.then((value) {
            //     fmcookie = value.evaluateJavascript('''document.cookie''');
            //     if ( fmcookie == null) {
            //       print('No data fmcookie');
            //     } else {
            //       fmcookie.then((value) {
            //         String stringxx = value;
            //         print('Yes data fmcookie');
            //         print(stringxx);
            //       });
            //     }
            //   });
            loggedIn = true;
            //   print("loggedin " + loggedIn.toString());
            // }
          });
        },
        gestureNavigationEnabled: true,
        backgroundColor: const Color(0x00000000),
      ),
      // floatingActionButton: favoriteButton(),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          return FloatingActionButton(
            heroTag: null,
            onPressed: () async {
              String url;
              if (controller.hasData) {
                url = (await controller.data.currentUrl());
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    controller.hasData
                        ? 'Favorited $url'
                        : 'Unable to favorite',
                  ),
                ),
              );
            },
            child: const Icon(Icons.favorite),
          );
        });
  }
}



