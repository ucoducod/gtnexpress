import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:GTNexpress/vandonship.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:GTNexpress/api_connection/api_connection.dart';
import 'package:GTNexpress/pie_chart.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:GTNexpress/web_page.dart';
import 'package:GTNexpress/side_menu.dart';

import 'package:GTNexpress/home_page.dart';
// import 'package:GTNexpress/vandon.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:easy_search/easy_search.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;


import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/authentication_bloc.dart';
import 'constants.dart';


import 'package:camera/camera.dart';
// import 'package:path/path.dart' as path;
// import 'package:http_parser/http_parser.dart';

// String getFileName(String _path){
//   return path.basename(_path);
// }


class Severity {
  int moi_tao;
  int da_chap_nhan;
  int dang_nhan;
  int da_nhan;
  int dang_nhan_lai;
  int dang_giao;
  int cho_giao_lai;
  int da_giao;
  int cho_chuyen_cod;
  int da_chuyen_cod;
  int hoan_tat;
  int luu_kho;
  int cho_tra;
  int da_tra;
  int tong_don_hang;
  dynamic tong_cuoc;
  dynamic tong_thu_cod;
  dynamic tong_tra_cod;
  dynamic tong_cho_tra_cod;
  dynamic dang_giao_cod;

  Severity(
      {this.moi_tao,
        this.da_chap_nhan,
        this.dang_nhan,
        this.da_nhan,
        this.dang_nhan_lai,
        this.dang_giao,
        this.cho_giao_lai,
        this.da_giao,
        this.cho_chuyen_cod,
        this.da_chuyen_cod,
        this.hoan_tat,
        this.luu_kho,
        this.cho_tra,
        this.da_tra,
        this.tong_don_hang,
        this.tong_cuoc,
        this.tong_thu_cod,
        this.tong_tra_cod,
        this.tong_cho_tra_cod,
        this.dang_giao_cod
      });
}

class MainScreenX extends StatefulWidget {
  const MainScreenX({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainScreenX> {
  int _index = 0;
  // GlobalKey globalKey = GlobalKey(debugLabel: 'btm_app_bar');



  // int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  // TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text(
  //     'Index 0: Home',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 1: Business',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: School',
  //     style: optionStyle,
  //   ),
  // ];
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }


  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('vi', ''), // Spanish, no country code
      ],
      home: Scaffold(
        appBar: AppBar(
          // leading: Builder(
          //   builder: (BuildContext context) {
          //     return IconButton(
          //       icon: const Icon(Icons.menu),
          //       onPressed: () { Scaffold.of(context).openDrawer(); },
          //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          //     );
          //   },
          // ),
          // title: Text('GTN Express - ${globals["username"]??""} ${globals["id"]}  ${globals["roles"]} ${globals["name"]}  '),
          title: Text('GTN Express - ${globals["name"]}'),
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchBookPage())),
                icon: Icon(Icons.search))
          ],
        ),
        // appBar: AppBar(title: const Text('gtnexpress')),
        body: LazyLoadIndexedStack(
          // body: IndexedStack(
          index: _index,
          children: [
            if( int.parse(globals["roles"]) == 7 || int.parse(globals["roles"]) == 9 ) ...[
              // const Pie(),
              PiegtnsgXX(),
              // WebViewExample(),
              // MyAppX(),
              // ProfileScreen(),
              // const WebViewExample(recordObject: 1),
              // WebViewQuanly(),
              // ProfileScreen(),
              // const SearchBookPage(),

              // FormCodeScreen(),//QRCODEXXXXX--edit van don
              TrackQRScreen(),
              // LookupScreen(),//Seach HT
              // MyHomePage(),
              Piegtnsg(),
              const SideMenu(),
            ]
            else if( int.parse(globals["roles"]) > 5 ) ...[
              const Pie(),
              PiegtnsgXX(),
              // WebViewExample(),
              // MyAppX(),
              // ProfileScreen(),
              const WebViewExample(recordObject: 1),
              // WebViewQuanly(),
              // ProfileScreen(),
              // const SearchBookPage(),

              // FormCodeScreen(),//QRCODEXXXXX--edit van don
              TrackQRScreen(),
              // LookupScreen(),//Seach HT
              // MyHomePage(),
              Piegtnsg(),
              const SideMenu(),
            ]
            else ...[
              const Pie(),
                PiegtnsgXX(),
              const WebViewExample(recordObject: 1),
              const SideMenu(),
            ]
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          // key: globalKey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            // if (index == 0 ){
            //   setState(() => _index = index);
            //   return Pie();
            // }
            setState(() => _index = index);
          },
          currentIndex: _index,
          items: [
            if( int.parse(globals["roles"]) == 7 || int.parse(globals["roles"]) == 9 ) ...[
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.pie_chart),
              //   label: 'Thống kê',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Quản lý',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.add_outlined),
              //   label: 'Tạo đơn',
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code),
                label: 'Hành trình',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on_outlined),
                label: 'Thu nhập',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Tài khoản',
              ),
            ]
            else if( int.parse(globals["roles"]) > 5 ) ...[
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart),
                label: 'Thống kê',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Quản lý',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_outlined),
                label: 'Tạo đơn',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.qr_code),
                label: 'Hành trình',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.monetization_on_outlined),
                label: 'Thu nhập',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Tài khoản',
              ),
            ] else ...[
                BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart),
                label: 'Thống kê',
                ),
                BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Quản lý',
                ),
                BottomNavigationBarItem(
                icon: Icon(Icons.add_outlined),
                label: 'Tạo đơn',
                ),
                BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Tài khoản',
                ),
            ]
          ],
        ),
        // key: context.read<MenuController>().scaffoldKey,
        // drawer: SideMenu(),
        // floatingActionButton: favoriteButton(),

        // drawer: Drawer(
        //   // Add a ListView to the drawer. This ensures the user can scroll
        //   // through the options in the drawer if there isn't enough vertical
        //   // space to fit everything.
        //   child: ListView(
        //     // Important: Remove any padding from the ListView.
        //     padding: EdgeInsets.zero,
        //     children: [
        //       // const DrawerHeader(
        //       //   decoration: BoxDecoration(
        //       //     color: Colors.blue,
        //       //   ),
        //       //   child: Text('Drawer Header'),
        //       // ),
        //       DrawerHeader(
        //         child: Image.asset("assets/images/logo.png"),
        //         decoration: BoxDecoration(color: Colors.blue),
        //         margin: const EdgeInsets.all(0.0),
        //         padding: const EdgeInsets.all(0.0),
        //       ),
        //       ListTile(
        //         title: const Text('KH'),
        //         selected: _selectedIndex == 0,
        //         onTap: () {
        //           Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormAddScreen(),));
        //         },
        //       ),
        //       // ListTile(
        //       //   title: const Text('Business'),
        //       //   selected: _selectedIndex == 1,
        //       //   onTap: () {
        //       //     // Update the state of the app
        //       //     _onItemTapped(1);
        //       //     // Then close the drawer
        //       //     Navigator.pop(context);
        //       //   },
        //       // ),
        //       // ListTile(
        //       //   title: const Text('School'),
        //       //   selected: _selectedIndex == 2,
        //       //   onTap: () {
        //       //     // Update the state of the app
        //       //     _onItemTapped(2);
        //       //     // Then close the drawer
        //       //     Navigator.pop(context);
        //       //   },
        //       // ),
        //     ],
        //   ),
        // ),

      ),
    );
  }

  Widget favoriteButton() {
    return FloatingActionButton(
      onPressed: ()  {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewExample(),));
        setState(() {});
      },
      child: const Icon(Icons.refresh),
    );
  }
}

// abstract class AbstractBookDetailsPageState<T extends StatefulWidget> extends State<T> {
// }
// abstract class AbstractSearchBookState<T extends StatefulWidget> extends State<T> {
//   List<Vandon> items = [];
//
//   final subject =  PublishSubject<String>();
//
//   bool isLoading = false;
//
//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
//
//   var client = http.Client();
//
//   Future<void> getBooks(String input) async {
//     String yourApiTokenHere = await storage.read(key: "storagetoken");
//     // print("Start Search");
//     http.Response response = await client.get(
//       Uri.parse(
//           'https://gtnexpress.vn/api/vdallapi?search=$input'),
//       headers: {
//         HttpHeaders.authorizationHeader: 'Bearer $yourApiTokenHere',
//       },
//     );
//     if (response.statusCode == 200) {
//       List responseJson = json.decode(response.body);
//       responseJson.map((m) => items.add(Vandon.fromJson(m))).toList();
//       print("Ket Qua: "+items.length.toString());
//     } else {
//       // print("End Search error");
//       throw ('error');
//     }
//   }
//
//
//   void _textChanged(String text) {
//     if(text.isEmpty) {
//       setState((){isLoading = false;});
//       _clearList();
//       return;
//     }
//
//     //LENGTH
//     if (text.length >4) {
//
//       setState(() {
//         isLoading = true;
//       });
//       _clearList();
//       // print("Check $text");
//       getBooks(text)
//           .then((books) {
//         setState(() {
//           isLoading = false;
//           if (items.isNotEmpty) {
//             // items = books.body;
//           } else {
//             scaffoldKey.currentState.showSnackBar(const SnackBar(content: Text("Không tìm thấy")));
//           }
//         });
//       });
//
//
//
//     } else {
//       setState((){isLoading = false;});
//       _clearList();
//       return;
//     }
//
//
//
//   }
//
//
//   void _clearList() {
//     setState(() {
//       items.clear();
//     });
//   }
//
//   @override
//   void dispose() {
//     subject.close();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     subject.stream.debounce(const Duration(milliseconds: 600)).listen(_textChanged);
//   }
//
// }
//
// class SearchBookPage extends StatefulWidget {
//   const SearchBookPage({Key key}) : super(key: key);
//
//
//   @override
//   _SearchBookState createState() => _SearchBookState();
// }
//
// class _SearchBookState extends AbstractSearchBookState<SearchBookPage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: AppBar(
//         title: const Text("Tìm kiếm"),
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             TextField(
//               decoration: const InputDecoration(
//                 hintText: 'Nhập MVĐ | ĐT | Tên NN',
//               ),
//               onChanged: (string) => (subject.add(string)),
//             ),
//             isLoading? const CircularProgressIndicator(): Container(),
//             Expanded(
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(8.0),
//                 itemCount: items.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return  BookCard(
//                     book: items[index],
//                     onCardClick: (){
//
//                     },
//                     onStarClick: (){
//                       setState(() {
//
//                       });
//
//                     },
//                   );
//                   //  return new BookCardMinimalistic(_items[index]);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class BookCard extends StatefulWidget {
//
//   const BookCard({
//     this.book,
//     @required this.onCardClick,
//     @required this.onStarClick,
//   });
//
//   final Vandon book;
//
//   final VoidCallback onCardClick;
//   final VoidCallback onStarClick;
//
//   @override
//   State<StatefulWidget> createState() => BookCardState();
//
// }
//
// class BookCardState extends State<BookCard> {
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onCardClick,
//       child: Card(
//         child: Column(children: <Widget>[
//           Padding(padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//             child: Row(
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Expanded(
//                   flex: 4,
//                   child: VideoDescription(
//                     vandon: widget.book,
//                   ),
//                 ),
//                 const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
//                 widget.book.statusFilter == 1
//                     ?
//                 IconButton(
//                   icon: Icon(
//                     Icons.dangerous,
//                     size: 16.0,
//                     color: Colors.brown[900],
//                   ),
//                   onPressed: () {
//                     // Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailTrack(vandons[index])));
//                   },
//                 )
//                     :
//                 IconButton(
//                   icon: Icon(
//                     Icons.place_outlined,
//                     size: 16.0,
//                     color: Colors.brown[900],
//                   ),
//                   onPressed: () {
//                     Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailTrack(widget.book)));
//                   },
//                 ),
//                 const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
//                 IconButton(
//                   icon: Icon(
//                     Icons.chevron_right,
//                     size: 18.0,
//                     color: Colors.brown[900],
//                   ),
//                   onPressed: () {
//                     Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailPage(widget.book)));
//                   },
//                 ),
//                 // const Icon(
//                 //   Icons.pin_drop_outlined,
//                 //   size: 16.0,
//                 // ),
//               ],
//             ),
//           ),
//         ])
//       ),
//     );
//   }
//
// }

abstract class AbstractBookDetailsPageState<T extends StatefulWidget> extends State<T> {
}
abstract class AbstractSearchBookState<T extends StatefulWidget> extends State<T> {
  List<SerialModal> items = [];

  final subject =  PublishSubject<String>();

  bool isLoading = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  var client = http.Client();

  Future<void> getBooks(String input) async {
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    // print("Start Search");
    // String tokenExp = await storage.read(key: "exp");
    // int dt_now_in_second = DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;//1351441456 [to seconds]
    //
    // print("Check expỉred:${tokenExp} ?? ${dt_now_in_second}");

    // if ( dt_now_in_second >= int.parse(tokenExp) ){
    //   print("expỉed:${tokenExp}");
    //   print("expỉed:${tokenExp}  >= ${dt_now_in_second}");
    //   setState(() {});//memory leak
    //   BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    // }
    var bodyx = jsonEncode({
      "includeTotal":true,
      // "filter": {
      //   "warrantyStatus": "registered",
      //   "serviceGroupCode": null,
      //   "productGroupCode": null,
      //   "modelNo": null,
      //   "dealerId": null,
      //   "comissionStatus": null,
      //   "manufacturedDate": {
      //     "from": null,
      //     "to": null
      //   },
      //   "warrantyActiveDate": {
      //     "from": null,
      //     "to": null
      //   },
      //   "warrantyEndDate": {
      //     "from": null,
      //     "to": null
      //   },
      //   "returnedDate": {
      //     "from": null,
      //     "to": null
      //   }
      // },
      "select":"",
      "search":"${input}",
      "skip":0,
      "take":30,
      // "skip":_page,
      // "take":_limit,
      // "sort":{"serialNo":1}
      "sort":{"warrantyActiveDate":-1}
    });

    Map<String,String> headers = {
      'Content-Type':'application/json',
      'Authorization':'Bearer $yourApiTokenHere',
      'Tenant' :'pna'
    };
    print("Esearch: ${bodyx.toString()}");
    // print(yourApiTokenHere);
    final response = await http.post(
      Uri.parse("https://gtnexpress.vn/api/service-items/search"),
      headers: headers,
      body: bodyx,
    );
    print("WTFFFF MS ${response.body.toString()} = ASDASDS");
    if (response.statusCode == 200) {
      // _total = json.decode(response.body)['total'];
      // _posts = json.decode(response.body)['data'];
      print("WTFFFF MS ${json.decode(response.body)['data']}");
      List responseJson = json.decode(response.body)['data'];
      if (responseJson != null){
        responseJson.map((m) => items.add(SerialModal.fromJson(m))).toList();
      } else {
        return false;
      }
      // print("Ket Qua: "+items.length.toString());
    } else {
      print("End Search error aaaaaaaaaaaaaaa");
      throw ('error');
    }
    // http.Response response = await client.get(
    //   Uri.parse(
    //       'https://gtnexpress.vn/api/vdallapi?search=$input'),
    //   headers: {
    //     HttpHeaders.authorizationHeader: 'Bearer $yourApiTokenHere',
    //   },
    // );
    // if (response.statusCode == 200) {
    //   List responseJson = json.decode(response.body);
    //   responseJson.map((m) => items.add(Vandon.fromJson(m))).toList();
    //   // print("Ket Qua: "+items.length.toString());
    // } else {
    //   // print("End Search error");
    //   throw ('error');
    // }
  }


  void _textChanged(String text) {
    if(text.isEmpty) {
      setState((){isLoading = false;});
      _clearList();
      return;
    }

    //LENGTH
    if (text.length >4) {

      setState(() {
        isLoading = true;
      });
      _clearList();
      // print("Check $text");
      getBooks(text)
          .then((books) {
        setState(() {
          isLoading = false;
          if (items.isNotEmpty) {
            // items = books.body;
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Không tìm thấy")));
            // scaffoldKey.currentState.showSnackBar(const SnackBar(content: Text("Không tìm thấy")));
          }
        });
      });



    } else {
      setState((){isLoading = false;});
      _clearList();
      return;
    }



  }


  void _clearList() {
    setState(() {
      items.clear();
    });
  }


  @override
  void dispose() {
    subject.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    subject.stream.debounce(const Duration(milliseconds: 800)).listen(_textChanged);
  }

}

class SearchBookPage extends StatefulWidget {
  const SearchBookPage({Key key}) : super(key: key);


  @override
  _SearchBookState createState() => _SearchBookState();
}
class _SearchBookState extends AbstractSearchBookState<SearchBookPage> {

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Tìm kiếm"),
            backgroundColor: Colors.blue,
          ),
          body:Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Mã vận đơn,tên khách, điện thoại...',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (string) => (subject.add(string)),
                ),
                isLoading? const CircularProgressIndicator(): Container(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top:10.0),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      print("pagegeg,index: ${index}");
                      return  BookCard(
                        book: items[index],
                        // onCardClick: (){
                        //
                        // },
                        // onStarClick: (){
                        //   setState(() {
                        //
                        //   });
                        //
                        // },
                      );
                      //  return new BookCardMinimalistic(_items[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Tìm kiếm"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                hintText: 'Mã vận đơn,tên khách, điện thoại...',
                border: OutlineInputBorder(),
              ),
              onChanged: (string) => (subject.add(string)),
            ),
            isLoading? const CircularProgressIndicator(): Container(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top:10.0),
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  print("pagegeg,index: ${index}");
                  return  BookCard(
                    book: items[index],
                    // onCardClick: (){
                    //
                    // },
                    // onStarClick: (){
                    //   setState(() {
                    //
                    //   });
                    //
                    // },
                  );
                  //  return new BookCardMinimalistic(_items[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookCard extends StatefulWidget {

  const BookCard({
    this.book,
    @required this.onCardClick,
    @required this.onStarClick,
  });

  final SerialModal book;

  final VoidCallback onCardClick;
  final VoidCallback onStarClick;

  @override
  State<StatefulWidget> createState() => BookCardState();

}
class BookCardState extends State<BookCard> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // return new GestureDetector(
    //   onTap: widget.onCardClick,
    //   child: new Card(
    //       child: new Container(
    //         height: 200.0,
    //         child: new Padding(
    //             padding: new EdgeInsets.all(8.0),
    //             child: new Row(
    //               children: <Widget>[
    //                 // widget.book.id != null?
    //                 // new Hero(
    //                 //   child: new Image.network(widget.book.trackid),
    //                 //   tag: widget.book.id,
    //                 // ):
    //                 // new Container(),
    //                 new Expanded(
    //                   child: new Stack(
    //                     children: <Widget>[
    //                       new Align(
    //                         child: new Padding(
    //                           child: new Text(widget.book.trackid + "    " + widget.book.senderPhone, maxLines: 10),
    //                           padding: new EdgeInsets.all(8.0),
    //                         ),
    //                         alignment: Alignment.center,
    //                       ),
    //                       new Align(
    //                         child: new IconButton(
    //                           // icon: widget.book.starred? new Icon(Icons.star): new Icon(Icons.star_border),
    //                           icon: Icon(Icons.star_border),
    //                           color: Colors.black,
    //                           onPressed: widget.onStarClick,
    //                         ),
    //                         alignment: Alignment.topRight,
    //                       ),
    //
    //                     ],
    //                   ),
    //                 ),
    //
    //               ],
    //             )
    //         ),
    //       )
    //   ),
    // );

    return GestureDetector(
      onTap: widget.onCardClick,
      child: Column(children: <Widget>[
        Padding(
          // padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: VideoDescriptionX(
                  vandon: widget.book,
                ),
              ),
              // const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
              // widget.book.commissionPaid == 1
              //     ?
              // IconButton(
              //   icon: Icon(
              //     Icons.dangerous,
              //     size: 16.0,
              //     color: Colors.brown[900],
              //   ),
              //   onPressed: () {
              //     // Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailTrack(vandons[index])));
              //   },
              // )
              //     :
              // IconButton(
              //   icon: Icon(
              //     Icons.place_outlined,
              //     size: 16.0,
              //     color: Colors.brown[900],
              //   ),
              //   onPressed: () {
              //     // Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailTrack(widget.book)));
              //   },
              // ),
              // const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
              // IconButton(
              //   icon: Icon(
              //     Icons.chevron_right,
              //     size: 18.0,
              //     color: Colors.brown[900],
              //   ),
              //   onPressed: () {
              //     // Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailPage(widget.book)));
              //   },
              // ),
              // const Icon(
              //   Icons.pin_drop_outlined,
              //   size: 16.0,
              // ),
            ],
          ),
        ),
      ]),
    );

  }

}

class BookCardTN extends StatefulWidget {

  const BookCardTN({
    this.book,
    @required this.onCardClick,
    @required this.onStarClick,
  });

  final SerialModal book;

  final VoidCallback onCardClick;
  final VoidCallback onStarClick;

  @override
  State<StatefulWidget> createState() => BookCardTNState();

}
class BookCardTNState extends State<BookCardTN> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // return new GestureDetector(
    //   onTap: widget.onCardClick,
    //   child: new Card(
    //       child: new Container(
    //         height: 200.0,
    //         child: new Padding(
    //             padding: new EdgeInsets.all(8.0),
    //             child: new Row(
    //               children: <Widget>[
    //                 // widget.book.id != null?
    //                 // new Hero(
    //                 //   child: new Image.network(widget.book.trackid),
    //                 //   tag: widget.book.id,
    //                 // ):
    //                 // new Container(),
    //                 new Expanded(
    //                   child: new Stack(
    //                     children: <Widget>[
    //                       new Align(
    //                         child: new Padding(
    //                           child: new Text(widget.book.trackid + "    " + widget.book.senderPhone, maxLines: 10),
    //                           padding: new EdgeInsets.all(8.0),
    //                         ),
    //                         alignment: Alignment.center,
    //                       ),
    //                       new Align(
    //                         child: new IconButton(
    //                           // icon: widget.book.starred? new Icon(Icons.star): new Icon(Icons.star_border),
    //                           icon: Icon(Icons.star_border),
    //                           color: Colors.black,
    //                           onPressed: widget.onStarClick,
    //                         ),
    //                         alignment: Alignment.topRight,
    //                       ),
    //
    //                     ],
    //                   ),
    //                 ),
    //
    //               ],
    //             )
    //         ),
    //       )
    //   ),
    // );

    return GestureDetector(
      onTap: widget.onCardClick,
      child: Column(children: <Widget>[
        Padding(
          // padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
          padding: EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: VideoDescriptionXTN(
                  vandon: widget.book,
                ),
              ),
              // const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
              // widget.book.commissionPaid == 1
              //     ?
              // IconButton(
              //   icon: Icon(
              //     Icons.dangerous,
              //     size: 16.0,
              //     color: Colors.brown[900],
              //   ),
              //   onPressed: () {
              //     // Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailTrack(vandons[index])));
              //   },
              // )
              //     :
              // IconButton(
              //   icon: Icon(
              //     Icons.place_outlined,
              //     size: 16.0,
              //     color: Colors.brown[900],
              //   ),
              //   onPressed: () {
              //     // Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailTrack(widget.book)));
              //   },
              // ),
              // const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
              // IconButton(
              //   icon: Icon(
              //     Icons.chevron_right,
              //     size: 18.0,
              //     color: Colors.brown[900],
              //   ),
              //   onPressed: () {
              //     // Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailPage(widget.book)));
              //   },
              // ),
              // const Icon(
              //   Icons.pin_drop_outlined,
              //   size: 16.0,
              // ),
            ],
          ),
        ),
      ]),
    );

  }

}


class Profile {
  int id;
  String name;
  String email;
  int age;
  String nganhang;
  String stk;
  String address;
  String username;
  String phone;
  String tinh;
  String quan;

  Profile({this.id = 0, this.name, this.email, this.age, this.tinh,this.quan, this.phone, this.username, this.address, this.stk, this.nganhang});

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
        id: map["id"],
        name: map["name"],
        email: map["email"],
        phone: map["phone"],
        username: map["username"],
        age: map["age"],
        address: map["address"],
        stk: map["stk"],
        nganhang: map["nganhang"],
        quan: map["quan"],
        tinh: map["tinh"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email, "age": age,"tinh": tinh,"quan": quan,"phone": phone,"username": username,"address": address, "stk": stk, "nganhang": nganhang};
  }

  @override
  String toString() {
    return 'Profile{id: $id, name: $name, email: $email, age: $age, tinh: $tinh,quan: $quan, phone: $phone, address: $address, stk: $stk, nganhang: $nganhang, username: $username}';
  }
}

List<Profile> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Profile>.from(data.map((item) => Profile.fromJson(item)));
}

String profileToJson(Profile data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key key}) : super(key: key);
//
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   BuildContext context;
//   ApiService apiService;
//
//   @override
//   void initState() {
//     super.initState();
//     apiService = ApiService();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     this.context = context;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tài khoản'),
//         // actions: <Widget>[
//         //   IconButton(
//         //     icon: const Icon(Icons.add_alert),
//         //     tooltip: 'Show Snackbar',
//         //     onPressed: () {
//         //       ScaffoldMessenger.of(context).showSnackBar(
//         //           const SnackBar(content: Text('This is a snackbar')));
//         //     },
//         //   ),
//         //   IconButton(
//         //     icon: const Icon(Icons.navigate_next),
//         //     tooltip: 'Go to the next page',
//         //     onPressed: () {
//         //       Navigator.push(context, MaterialPageRoute<void>(
//         //         builder: (BuildContext context) {
//         //           return Scaffold(
//         //             appBar: AppBar(
//         //               title: const Text('Next page'),
//         //             ),
//         //             body: const Center(
//         //               child: Text(
//         //                 'This is the next page',
//         //                 style: TextStyle(fontSize: 24),
//         //               ),
//         //             ),
//         //           );
//         //         },
//         //       ));
//         //     },
//         //   ),
//         // ],
//       ),
//       body: FutureBuilder(
//         future: apiService.getProfiles(),
//         builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                   "Something wrong with message: ${snapshot.error.toString()}"),
//             );
//           } else if (snapshot.connectionState == ConnectionState.done) {
//             List<Profile> profiles = snapshot.data;
//             return _buildListView(profiles);
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//
//     // return SafeArea(
//     //   child: FutureBuilder(
//     //     future: apiService.getProfiles(),
//     //     builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
//     //       if (snapshot.hasError) {
//     //         return Center(
//     //           child: Text(
//     //               "Something wrong with message: ${snapshot.error.toString()}"),
//     //         );
//     //       } else if (snapshot.connectionState == ConnectionState.done) {
//     //         List<Profile> profiles = snapshot.data;
//     //         return _buildListView(profiles);
//     //       } else {
//     //         return Center(
//     //           child: CircularProgressIndicator(),
//     //         );
//     //       }
//     //     },
//     //   ),
//     // );
//   }
//
//   Widget _buildListView(List<Profile> profiles) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//       child: ListView.builder(
//         itemBuilder: (context, index) {
//           Profile profile = profiles[index];
//           return Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       "Họ và tên: ${profile.name}",
//                       // style: Theme.of(context).textTheme.title,
//                     ),
//                     Text(
//                       "Điện thoại: ${profile.phone}",
//                       // style: Theme.of(context).textTheme.title,
//                     ),
//                     Text("Email: ${profile.email}"),
//                     Text(
//                       "Địa chỉ: ${profile.address}",
//                       // style: Theme.of(context).textTheme.title,
//                     ),
//                     Text(
//                       "Ngân Hàng: ${profile.nganhang}",
//                       // style: Theme.of(context).textTheme.title,
//                     ),
//                     Text(
//                       "Số Tài khoản: ${profile.stk}",
//                       // style: Theme.of(context).textTheme.title,
//                     ),
//                     // Text(
//                     //   "Số Tài khoản: ${profile.tinh}",
//                     //   // style: Theme.of(context).textTheme.title,
//                     // ),
//
//                     // Text(profile.age.toString()),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: const <Widget>[
//                         // FlatButton(
//                         //   onPressed: () {
//                         //     showDialog(
//                         //         context: context,
//                         //         builder: (context) {
//                         //           return AlertDialog(
//                         //             title: Text("Warning"),
//                         //             content: Text(
//                         //                 "Are you sure want to delete data profile ${profile.name}?"),
//                         //             actions: <Widget>[
//                         //               FlatButton(
//                         //                 child: Text("Yes"),
//                         //                 onPressed: () {
//                         //                   Navigator.pop(context);
//                         //                   apiService
//                         //                       .deleteProfile(profile.id)
//                         //                       .then((isSuccess) {
//                         //                           if (isSuccess) {
//                         //                             setState(() {});
//                         //                             Scaffold.of(this.context)
//                         //                                 .showSnackBar(SnackBar(
//                         //                                 content: Text(
//                         //                                     "Delete data success")));
//                         //                           } else {
//                         //                             Scaffold.of(this.context)
//                         //                                 .showSnackBar(SnackBar(
//                         //                                 content: Text(
//                         //                                     "Delete data failed")));
//                         //                           }
//                         //                           // ScaffoldMessenger.of(context).showSnackBar(
//                         //                           //   SnackBar(
//                         //                           //     content: Text(
//                         //                           //       'Unable to favorite',
//                         //                           //     ),
//                         //                           //   ),
//                         //                           // );
//                         //                   });
//                         //                 },
//                         //               ),
//                         //               FlatButton(
//                         //                 child: Text("No"),
//                         //                 onPressed: () {
//                         //                   Navigator.pop(context);
//                         //                 },
//                         //               )
//                         //             ],
//                         //           );
//                         //         });
//                         //   },
//                         //   child: Text(
//                         //     "Delete",
//                         //     style: TextStyle(color: Colors.red),
//                         //   ),
//                         // ),
//
//                         // FlatButton(
//                         //   onPressed: () {
//                         //     Navigator.push(context,
//                         //         MaterialPageRoute(builder: (context) {
//                         //       return FormAddScreen(profile: profile);
//                         //       // return MyHomePageZA();
//                         //     }));
//                         //   },
//                         //   child: Text(
//                         //     "Sửa thông tin",
//                         //     style: TextStyle(color: Colors.blue),
//                         //   ),
//                         // ),
//
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//         itemCount: profiles.length,
//       ),
//     );
//   }
// }
//
// class FormAddScreen extends StatefulWidget {
//   Profile profile;
//   FormAddScreen({Key key, this.profile}) : super(key: key);
//
//   @override
//   _FormAddScreenState createState() => _FormAddScreenState();
// }
//
// class _FormAddScreenState extends State<FormAddScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
//   bool _isLoading = false;
//   final ApiService _apiService = ApiService();
//   String tinhtinhtinh = "";
//   // String quanselected = "Vui long chon";
//   QuanModel selectedQuan;
//
//
//   bool _isFieldNameValid;
//   bool _isFieldEmailValid;
//   bool _isFieldTinhValid;
//   bool _isFieldQuanValid;
//   bool _isFieldAgeValid;
//
//   final TextEditingController _controllerName = TextEditingController();
//   final TextEditingController _controllerEmail = TextEditingController();
//   final TextEditingController _controllerAge = TextEditingController();
//   final TextEditingController _controllerTinh = TextEditingController();
//   final TextEditingController _controllerQuan = TextEditingController();
//
//   final TextEditingController _controllerUsername = TextEditingController();
//   final TextEditingController _controllerPhone = TextEditingController();
//   final TextEditingController _controllerAddress = TextEditingController();
//   final TextEditingController _controllerBank = TextEditingController();
//   final TextEditingController _controllerBankno = TextEditingController();
//
//   @override
//   void initState() {
//     if (widget.profile != null) {
//       _isFieldNameValid = true;
//       _controllerName.text = widget.profile.name;
//       _isFieldEmailValid = true;
//       _isFieldTinhValid = true;
//       _isFieldQuanValid = true;
//       _controllerEmail.text = widget.profile.email;
//       _isFieldAgeValid = true;
//       _controllerAge.text = widget.profile.age.toString();
//       _controllerTinh.text = widget.profile.name;
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.teal[100],
//       key: _scaffoldState,
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: Colors.white),
//         title: Text(
//           widget.profile == null ? "Tạo tài khoản" : "Cập nhật",
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: ConstrainedBox(
//           constraints:
//               BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
//           child: Stack(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     _buildTextFieldName(),
//                     _buildTextFieldEmail(),
//                     _buildTextFieldAge(),
//                     _buildTinh(),
//                     _buildQuan(),
//                     // _buildTextFieldName(),
//                     // _buildTextFieldEmail(),
//                     // _buildTextFieldAge(),
//                     // _buildTinh(),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: ElevatedButton(
//                         child: Text(
//                           widget.profile == null
//                               ? "Đăng ký".toUpperCase()
//                               : "Cập nhật".toUpperCase(),
//                           style: const TextStyle(
//                             color: Colors.white,
//                           ),
//                         ),
//                         onPressed: () {
//                           if (_isFieldNameValid == null ||
//                               _isFieldEmailValid == null ||
//                               _isFieldAgeValid == null ||
//                               _isFieldTinhValid == null ||
//                               _isFieldQuanValid == null ||
//                               !_isFieldNameValid ||
//                               !_isFieldEmailValid ||
//                               !_isFieldTinhValid ||
//                               !_isFieldQuanValid ||
//                               !_isFieldAgeValid
//                             ) {
//                             _scaffoldState.currentState.showSnackBar(
//                               const SnackBar(
//                                 content: Text("Vui lòng điền vào tất cả các trường",),
//                                 // content: Text("Please fill all field",textAlign: TextAlign.center),
//                                 // backgroundColor: Colors.deepOrange,
//                                 // duration: Duration(seconds: 6),
//                                 // behavior: SnackBarBehavior.floating,
//                               ),
//                             );
//                             return;
//                           }
//                           setState(() => _isLoading = true);
//                           String name = _controllerName.text.toString();
//                           String email = _controllerEmail.text.toString();
//                           // String password = _controllerPassword.text.toString();
//                           int age = int.parse(_controllerAge.text.toString());
//                           String tinh = _controllerTinh.text.toString();
//                           String quan = _controllerQuan.text.toString();
//                           Profile profile = Profile(
//                             name: name,
//                             email: email,
//                             age: 18,
//                             tinh: tinh,
//                             // quan: quan,
//                           );
//                           if (widget.profile == null) {
//                             _apiService.createProfile(profile).then((String isSuccess) {
//                               setState(() => _isLoading = false);
//                               if (isSuccess != "") {
//                                 if (isSuccess == "success"){
//                                   _scaffoldState.currentState.showSnackBar(const SnackBar(
//                                     content: Text("Thanh Cong",textAlign: TextAlign.center,),
//                                   ));
//                                   Navigator.pop(_scaffoldState.currentState.context);
//                                 } else {
//                                   _scaffoldState.currentState.showSnackBar( SnackBar(
//                                     backgroundColor: Colors.deepOrange,
//                                     content: Text(isSuccess.toString(),textAlign: TextAlign.center,),
//                                   ));
//                                 }
//                               }
//                               else {
//                                 _scaffoldState.currentState.showSnackBar(const SnackBar(
//                                   content: Text("Khong thanh cong",textAlign: TextAlign.center,),
//                                 ));
//                               }
//                             });
//                           } else {
//                             profile.id = widget.profile.id;
//                             _apiService
//                                 .updateProfile(profile)
//                                 .then((isSuccess) {
//                               setState(() => _isLoading = false);
//                               if (isSuccess) {
//                                 Navigator.pop(
//                                     _scaffoldState.currentState.context);
//                               } else {
//                                 _scaffoldState.currentState
//                                     .showSnackBar(const SnackBar(
//                                   content: Text("Cập nhật thất bại"),
//                                 ));
//                               }
//                             });
//                           }
//                         },
//                         // child: Colors.teal[800],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               _isLoading
//                   ? Stack(
//                       children: const <Widget>[
//                         Opacity(
//                           opacity: 0.3,
//                           child: ModalBarrier(
//                             dismissible: false,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       ],
//                     )
//                   : Container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextFieldName() {
//     return Flexible(
//       child: Padding(
//         padding: const EdgeInsets.all(6),
//         child: TextField(
//           controller: _controllerName,
//           keyboardType: TextInputType.text,
//           decoration: InputDecoration(
//             labelText: "Họ và tên",
//             border: OutlineInputBorder(),
//             errorText: _isFieldNameValid == null || _isFieldNameValid
//                 ? null
//                 : "Full name is required",
//           ),
//           onChanged: (value) {
//             bool isFieldValid = value.trim().isNotEmpty;
//             if (isFieldValid != _isFieldNameValid) {
//               setState(() => _isFieldNameValid = isFieldValid);
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextFieldPhone() {
//     return Flexible(
//       child: Padding(
//         padding: const EdgeInsets.only(right: 2),
//         child: TextField(
//           controller: _controllerEmail,
//           keyboardType: TextInputType.emailAddress,
//           decoration: InputDecoration(
//             labelText: "Điện thoại",
//             errorText: _isFieldEmailValid == null || _isFieldEmailValid
//                 ? null
//                 : "Điện thoại is required",
//           ),
//           onChanged: (value) {
//             bool isFieldValid = value.trim().isNotEmpty;
//             if (isFieldValid != _isFieldEmailValid) {
//               setState(() => _isFieldEmailValid = isFieldValid);
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextFieldEmail() {
//     return Flexible(
//       child: Padding(
//         // padding: const EdgeInsets.only(right: 2),
//         padding: const EdgeInsets.all(6),
//         child: TextField(
//           controller: _controllerEmail,
//           keyboardType: TextInputType.emailAddress,
//           decoration: InputDecoration(
//             labelText: "Email",
//               border: OutlineInputBorder(),
//             errorText: _isFieldEmailValid == null || _isFieldEmailValid
//                 ? null
//                 : "Email is required",
//           ),
//           onChanged: (value) {
//             bool isFieldValid = value.trim().isNotEmpty;
//             if (isFieldValid != _isFieldEmailValid) {
//               setState(() => _isFieldEmailValid = isFieldValid);
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextFieldAge() {
//     return Flexible(
//       child: Padding(
//         // padding: const EdgeInsets.only(right: 2),
//         padding: const EdgeInsets.all(6),
//         child: TextField(
//           controller: _controllerAge,
//           keyboardType: TextInputType.number,
//           decoration: InputDecoration(
//             labelText: "Số tài khoản",
//             border: OutlineInputBorder(),
//             errorText: _isFieldAgeValid == null || _isFieldAgeValid
//                 ? null
//                 : "STK is required",
//           ),
//           onChanged: (value) {
//             bool isFieldValid = value.trim().isNotEmpty;
//             if (isFieldValid != _isFieldAgeValid) {
//               setState(() => _isFieldAgeValid = isFieldValid);
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTinh() {
//     return Flexible(
//       child: Padding(
//         padding: const EdgeInsets.only(right: 2),
//         child: DropdownSearch<TinhModel>(
//           items: const [
//             // TinhModel(name: "Vui long chon", id: 0),
//             // TinhModel(name: "Vui long chon 2", id: 99999)
//           ],
//           maxHeight: 500,
//           onFind: (String filter) => getData(filter),
//           dropdownSearchDecoration: const InputDecoration(
//             labelText: "Chọn Tỉnh/ TP",
//             border: OutlineInputBorder(),
//             contentPadding: EdgeInsets.fromLTRB(6, 6, 0, 0),
//           ),
//           autoValidateMode: AutovalidateMode.onUserInteraction,
//           validator: (u) => u == null ? "Tỉnh/ TP is required " : null,
//           onChanged: (TinhModel) {
//             _controllerTinh.text = TinhModel.id.toString();
//             tinhtinhtinh = TinhModel.id.toString();
//             // setState(() => _isFieldTinhValid = true);
//             setState(() {
//               _isFieldTinhValid = true;
//               _isFieldQuanValid = false;
//               selectedQuan = QuanModel(name: "Vui long chon quan", id: 0);
//             });
//           },
//           showSearchBox: true,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildQuan() {
//     return Flexible(
//       child: Padding(
//         padding: const EdgeInsets.only(right: 2),
//         child: DropdownSearch<QuanModel>(
//           selectedItem: selectedQuan,
//           // items: const [
//           //   // TinhModel(name: "Vui long chon", id: 0),
//           //   // TinhModel(name: "Vui long chon 2", id: 99999)
//           // ],
//           maxHeight: 500,
//           onFind: (String filter) => getDataPhuong(filter,tinhtinhtinh),
//           dropdownSearchDecoration: const InputDecoration(
//             labelText: "Chọn Quan",
//             border: OutlineInputBorder(),
//             contentPadding: EdgeInsets.fromLTRB(6, 6, 0, 0),
//           ),
//           autoValidateMode: AutovalidateMode.onUserInteraction,
//           validator: (u) => u == null ? "Quan is required " : null,
//           onChanged: (QuanModel) {
//             _controllerQuan.text = QuanModel.id.toString();
//             setState(() => _isFieldQuanValid = true);
//           },
//           showSearchBox: true,
//         ),
//       ),
//     );
//   }
//
//   //TINH THANH PHO
//   // Future<List<TinhModel>> getData(filter) async {
//   //   var response = await Dio().get(
//   //     "https://gtnexpress.vn/api/get_tinh_thanh",
//   //     queryParameters: {"filter": filter},
//   //   );
//   //
//   //   final data = response.data;
//   //   if (data != null) {
//   //     return TinhModel.fromJsonList(data);
//   //   }
//   //
//   //   return [];
//   // }
//   Future<List<TinhModel>> getData(filter) async {
//     var response = await Dio().get(
//       "https://gtnexpress.vn/api/get_quan",
//       queryParameters: {"filter": filter},
//     );
//
//     final data = response.data;
//     if (data != null) {
//       return TinhModel.fromJsonList(data);
//     }
//
//     return [];
//   }
//
//   Future<List<QuanModel>> getDataPhuong(filter,tinhtinhtinh) async {
//     var response = await Dio().get(
//       "https://gtnexpress.vn/api/get_phuong?id_quan=${tinhtinhtinh}",
//       queryParameters: {"filter": filter},
//     );
//
//     final data = response.data;
//     if (data != null) {
//       return QuanModel.fromJsonList(data);
//     }
//
//     return [];
//   }
// }

class ApiService {
  final String baseUrl = "https://gtnexpress.vn";
  var client = http.Client();

  Future<List<AccountModel>> getProfiles() async {
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    String username = await storage.read(key: "appusername");

    var bodyx = jsonEncode({"filter":{"userName":username}});
    Map<String,String> headers = {'Content-Type':'application/json','Authorization': 'Bearer ${yourApiTokenHere}','Tenant' :'pna'};
    final response = await http.post( Uri.parse("https://gtnexpress.vn/api/profile"),headers: headers,body: bodyx,);
    if (response.statusCode == 200) {
      return accountFromJson(response.body);
    } else {
      return null;
    }

  }

  Future<String> createAccount(Profile data) async {

    final body = jsonEncode({
      "username":data.username,
      "fullName":data.name,
      "email":data.email,
      "phoneNo":data.phone,
      "city":data.tinh,
      // "address":data.address + ' ' + data.stk,
      "address":data.address,
      "organizationId":data.quan,
      "password":data.nganhang,
      "confirmPwd":data.nganhang,
      "roles":"null",
      "active":"true",
    });
    Map<String,String> headers = {'Content-Type':'application/json'};
    print(body.toString());
    try{
      final response = await client.post(
          Uri.parse('https://gtnexpress.vn/api/users'),
          headers: headers,
          body: body
      );
      final int statusCode = response.statusCode;
      print("statusCode: ${statusCode}");
      final String stringBody = response.body;
      print("convert body string: ${stringBody}");
      var jsonBody = json.decode(stringBody);
      print("convert body json: ${jsonBody}");
      if (statusCode == 200) {
        return "success";
      } else if (statusCode == 400){
        return jsonBody['message'].toString();
      } else { // 401 and orther
        //"error": "You are not authorized!"
        return 'Vui lòng liên hệ chúng tôi để được hỗ trợ';
      }
    } on Exception catch (exception) {
      // only executed if error is of type Exception
      print("Exception error: ${exception.toString()}");
      return "Exception error ${exception.toString()}";
    } catch (e) {
      print("catch error: ${e.toString()}");
      return "Please check your internet ${e.toString()}";
    }

    // final response = await client.post(
    //   "$baseUrl/api/profile",
    //   headers: {"content-type": "application/json"},
    //   body: profileToJson(data),
    // );
    // if (response.statusCode == 201) {
    //   return true;
    // } else {
    //   print("Create faild");
    //   return false;
    // }
  }

  Future<String> updateAccount(Profile data) async {

    String yourApiTokenHere = await storage.read(key: "storagetoken");

    Map<String,String> headers = {
      'Content-Type':'application/json',
      'Authorization':'Bearer $yourApiTokenHere',
      'Tenant' :'pna'
    };
    final body = jsonEncode({
      "id":"appid",
      "username":data.username,//
      "fullName":data.name,//
      "email":data.email,
      "phoneNo":data.phone,
      "city":data.tinh,
      "address":data.address,
      // "organizationId":null,
      "organizationId":data.quan,
      "pwd":data.nganhang,//
      // "confirmPwd":data.nganhang,
      "active":"true",
      "roles":"",
    });
    // final body = jsonEncode({
    //   "username":data.username,
    //   "fullName":data.name,
    //   "email":data.email,
    //   "phoneNo":data.phone,
    //   "city":data.tinh,
    //   // "address":data.address + ' ' + data.stk,
    //   "address":data.address,
    //   "organizationId":data.quan,
    //   "password":data.nganhang,
    //   "confirmPwd":data.nganhang,
    //   "roles":"null",
    //   "active":"true",
    // });

    print("statusCode: ${body.toString()}");
    try{
      final response = await client.post(
          Uri.parse('https://gtnexpress.vn/api/profile/1'),
          headers: headers,
          body: body
      );
      final int statusCode = response.statusCode;
      print("statusCode: ${statusCode}");
      final String stringBody = response.body;
      print("convert body string: ${stringBody}");
      var jsonBody = json.decode(stringBody);
      print("convert body json: ${jsonBody}");
      if (statusCode == 200 && jsonBody != null ) { //|| json == null
        // if (jsonBody['id']){
        //   return "success";
        // }
        return "success";
      } else if (statusCode == 400 && jsonBody != null ){
        return jsonBody['message'].toString();
      } else { // 401 and orther
        //"error": "You are not authorized!"
        return 'Vui lòng liên hệ GTN Express để được hỗ trợ';
      }

    } on Exception catch (exception) {
      // only executed if error is of type Exception
      print("Exception error: ${exception}");
      return "Exception error ${exception.toString()}";
    } catch (e) {
      print("catch error: ${e}");
      return "Please check your internet ${e}";
      throw Exception("catch error: ${e}");
    }

    // final response = await client.post(
    //   "$baseUrl/api/profile",
    //   headers: {"content-type": "application/json"},
    //   body: profileToJson(data),
    // );
    // if (response.statusCode == 201) {
    //   return true;
    // } else {
    //   print("Create faild");
    //   return false;
    // }
  }

  //http://localhost:4001/service-item/get/by-model-serial?serialNo=TH01AC210580903017
  Future<List<String>> checkSerial(String serialNo) async {
    String serial = serialNo;

    String yourApiTokenHere = await storage.read(key: "storagetoken");
    Map<String,String> headers = {
      'Content-Type':'application/json',
      'Authorization':'Bearer $yourApiTokenHere',
      'Tenant' :'pna'
    };
    print('https://gtnexpress.vn/api/qrstring?serialNo=$serial');
    final response = await client.get(
      Uri.parse('https://gtnexpress.vn/api/qrstring?serialNo=$serial'),
      headers: headers,
    ).timeout(Duration(seconds: 5));
    // print("statusCode: ${response.toString()}");
    final int statusCode = response.statusCode;
    print("statusCode: ${statusCode}");
    final String stringBody = response.body;
    print("convert body string: ${stringBody}");
    var jsonBody = json.decode(stringBody);
    print("convert body json: ${jsonBody}");
    if (statusCode == 200 && jsonBody != null ) { //|| json == null
      print(jsonBody['modelNo']);
      print(jsonBody['warrantyActiveDate']);
      String modalname = jsonBody['modelNo'];
      String VDID = jsonBody['vdid'];

      var formatter =  DateFormat('dd/MM/y');
      // DateTime nxk = DateTime.parse(jsonBody['manufacturedDate']).toLocal();

      if(modalname != '' && jsonBody['warrantyActiveDate'] == null ){
        //VD,nguoi pt,trang thai
        return [
          modalname,'Chưa kích hoạt',
          jsonBody['owner'] != null ? jsonBody['owner'].toString() : 'NA',
          jsonBody['statusvd'] != null ? jsonBody['statusvd'].toString() : 'NA',
          jsonBody['manufacturedDate']!=null?formatter.format( DateTime.parse(jsonBody['manufacturedDate']).toLocal() ).toString():"NA",
          jsonBody['vdid']
        ];
      } else if (modalname != '' && jsonBody['warrantyActiveDate'] != null){
        String StartDate = '';
        String EndDate = '';
        String MODAL = '';
        String NXK = '';
        String THBH = '';
        String TKH = '';
        String SDT = '';
        String DC = '';
        String QUAN = '';
        String TINH = '';
        String OWNER = '';
        String STATUSVD = '';
        // String VDID = '';
        try{
          // DateTime startDate = DateTime.parse(jsonBody['warrantyActiveDate']).toLocal();
          // DateTime endDate = DateTime.parse(jsonBody['warrantyEndDate']).toLocal();
          // // var formatter =  DateFormat('dd/MM/y');
          //
          StartDate = formatter.format(DateTime.parse(jsonBody['warrantyActiveDate']).toLocal())??"NA";
          EndDate = formatter.format(DateTime.parse(jsonBody['warrantyActiveDate']).toLocal())??"NW";
          //
          // //http://localhost:4001/service-item/acd868ea-f4b3-4895-b85b-3702a132284b
          //
          // DateTime nxk = DateTime.parse(jsonBody['manufacturedDate']).toLocal();
          // NXK = formatter.format(nxk).toString();
          NXK = jsonBody['manufacturedDate']!=null?formatter.format( DateTime.parse(jsonBody['manufacturedDate']).toLocal() ).toString():"None";


          THBH = '${StartDate.toString()} - ${EndDate.toString()}';
          // THBH = '${jsonBody['startDate']!=null?formatter.format( DateTime.parse(jsonBody['startDate']).toLocal() ).toString():"None"} - ${jsonBody['warrantyEndDate']!=null?formatter.format( DateTime.parse(jsonBody['warrantyEndDate']).toLocal() ).toString():"None"}';

          TKH = jsonBody['contactName'] != null ? jsonBody['contactName'].toString() : 'NA';
          SDT = jsonBody['contactPhoneNo'] != null ? jsonBody['contactPhoneNo'].toString() : 'NA';
          DC = jsonBody['contactAddress'] != null ? jsonBody['contactAddress'].toString() : 'NA';
          QUAN = jsonBody['contactDistrict'] != null ? jsonBody['contactDistrict'].toString() : 'NA';
          TINH = jsonBody['contactCity'] != null ? jsonBody['contactCity'].toString() : '';// '79'
          MODAL = jsonBody['modelNo'] != null ? jsonBody['modelNo'].toString() : 'NA';
          OWNER = jsonBody['owner'] != null ? jsonBody['owner'].toString() : 'NA';
          STATUSVD = jsonBody['statusvd'] != null ? jsonBody['statusvd'].toString() : 'NA';
          VDID = jsonBody['vdid'] != null ? jsonBody['vdid'].toString() : '0';
        } catch  (e) {
          print("Can not convert: ${e}");
        }
        return [modalname,'Chưa kích hoạt',OWNER, STATUSVD,EndDate,NXK,THBH,TKH,SDT,DC,QUAN,TINH,MODAL,VDID];
      }
      return ["found response ${stringBody}"];
    }
    return ["Không tìm thấy"];
  }

  Future<String> createProfile(Profile data) async {
    // DateTime _now = DateTime.now();//localtimezone
    // print('timestamp: ${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}');
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    Map<String,String> headers = {
      'Content-Type':'application/json',
      'Authorization':'$yourApiTokenHere',
      'Tenant' :'pna'
    };

    // String serial = data.name;
    // String tinh = data.tinh;
    // String contactName = data.email;
    final body = jsonEncode({
      "serialNo":data.email,
      "contactName":data.name,
      "contactPhoneNo":data.phone,
      "contactAddress":data.address,
      "contactDistrict":data.username,
      "contactCity":data.tinh,
    });
    try{
      final response = await client.post("$baseUrl/api/profile",
        headers: {"content-type": "application/json"},
        body: profileToJson(data),
      );
      if (response.statusCode == 201) {
        return "true";
      } else {
        print("Create faild");
        return "false";
      }
    } on Exception catch (exception) {
      return "Exception error ${exception.toString()}";
    } catch (e) {
      print("catch error: ${e}");
      throw Exception("catch error: ${e}");
    }
  }

  Future<List<String>> createHanhtrinh(Profile data) async {
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    final response = await client.post(
      "https://gtnexpress.vn/api/hanhtrinh",
      headers: {"content-type": "application/json",'Authorization':'Bearer $yourApiTokenHere'},
      body: profileToJson(data),
    );

    final String stringBody = response.body;
    var jsonBody = json.decode(stringBody);
    print("convert body string: ${jsonBody.toString()}");
    String messageerror = jsonBody['message'].toString()??"server error";
    if (response.statusCode == 200) {
      return ["${jsonBody['message'].toString()??''}${jsonBody['code'].toString()??''}","${jsonBody['message'].toString()??''}${jsonBody['code'].toString()??''}"];
    } else {
      return ["","${jsonBody['message'].toString()??''}${jsonBody['code'].toString()??''}"];
    }
  }

  Future<bool> updateHanhtrinh(Profile data) async {
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    final response = await client.post(
      "https://gtnexpress.vn/api/hanhtrinh/${data.id}",
      headers: {"content-type": "application/json",'Authorization':'Bearer $yourApiTokenHere'},
      body: profileToJson(data),
    );
    print(data.toString());
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Future<bool> deleteProfile(int id) async {
  //   String yourApiTokenHere = await storage.read(key: "storagetoken");
  //   // print("This is PROFILE: $yourApiTokenHere ### 'https://gtnexpress.vn/api/profile/$id'");
  //   http.Response response = await client.put(
  //     Uri.parse('https://gtnexpress.vn/api/profile/$id'),
  //     headers: {
  //       HttpHeaders.authorizationHeader: 'Bearer $yourApiTokenHere',
  //     },
  //   );
  //
  //   // final response = await client.delete(
  //   //   "$baseUrl/api/profile/$id",
  //   //   headers: {"content-type": "application/json"},
  //   // );
  //   if (response.statusCode == 201) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  Future<String> changepassAccount(profile) async {
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    var bodyx = jsonEncode({
      "currentPwd": profile.username,
      "pwd": profile.name,
      "confirmPwd": profile.nganhang
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${yourApiTokenHere}',
      'Tenant': 'pna'
    };
    final response = await http.post(
      Uri.parse("https://gtnexpress.vn/api/changepass"),
      headers: headers, body: bodyx,);
    print(response.body.toString());
    if (response.statusCode == 200) {
      // {"success":true}
      // globals["password"] = profile.name;
      return "success";
    } else {
      return json.decode(response.body)['message'].toString() ?? "mật khẩu cũ không chính xác";
    }
  }

  Future<bool> deleteAccount(String username) async {
    String password ="12345678@";
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    Map<String,String> headers = {'Content-Type':'application/json','Authorization': 'Bearer ${yourApiTokenHere}','Tenant' :'pna'};
    final response = await http.post( Uri.parse("https://gtnexpress.vn/api/delete_account"),headers: headers);
    if (response.statusCode == 200) {
      // {"success":true}
      // globals["password"] = "AkinoDisable@";
      return true;
    }
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

}

class MyHomePageZA extends StatefulWidget {
  const MyHomePageZA({Key key}) : super(key: key);

  @override
  _MyHomePageZA createState() => _MyHomePageZA();
}

class _MyHomePageZA extends State<MyHomePageZA> {
  final _formKey = GlobalKey<FormState>();
  // final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();
  // final _multiKey = GlobalKey<DropdownSearchState<String>>();
  // final _userEditTextController = TextEditingController(text: 'Mrs');
  String tinhtinhtinh="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DropdownSearch Demo")),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            // padding: EdgeInsets.all(4),
            children: <Widget>[
              ///merge online and offline data in the same list and set custom max Height
              DropdownSearch<TinhModel>(
                items: const [
                  // TinhModel(name: "Vui long chon", id: 0),
                  // TinhModel(name: "Vui long chon 2", id: 99999)
                ],
                maxHeight: 300,
                onFind: (String filter) => getDataQuan(filter),
                dropdownSearchDecoration: const InputDecoration(
                  labelText: "Chọn tỉnh",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                // onChanged: print,
                onChanged: (value) {
                  // print;
                  // print(filter);
                  print(value.id);
                  print(value.name);
                  // bool isFieldValid = value.trim().isNotEmpty;
                  if (true) {
                    setState(() => tinhtinhtinh = value.id.toString());
                    print(tinhtinhtinh);
                  }
                },
                showSearchBox: true,
              ),
              const Divider(),
              ///merge online and offline data in the same list and set custom max Height
              DropdownSearch<QuanModel>(
                items: const [
                  // TinhModel(name: "Vui long chon", id: 0),
                  // TinhModel(name: "Vui long chon 2", id: 99999)
                ],
                maxHeight: 300,
                onFind: (String filter) => getDataPhuong(filter,tinhtinhtinh),
                dropdownSearchDecoration: const InputDecoration(
                  labelText: "Chọn quan",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: print,
                showSearchBox: true,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<TinhModel>> getData(filter) async {
    var response = await Dio().get(
      "https://gtnexpress.vn/api/get_tinh_thanh",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    if (data != null) {
      return TinhModel.fromJsonList(data);
    }

    return [];
  }
  Future<List<TinhModel>> getDataQuan(filter) async {
    var response = await Dio().get(
      "https://gtnexpress.vn/api/get_quan",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    if (data != null) {
      return TinhModel.fromJsonList(data);
    }

    return [];
  }
  Future<List<QuanModel>> getDataPhuong(filter,tinhtinhtinh) async {
    var response = await Dio().get(
      "https://gtnexpress.vn/api/get_phuong?id_quan=${tinhtinhtinh}",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    if (data != null) {
      return QuanModel.fromJsonList(data);
    }

    return [];
  }
}

class TinhModel {
  final int id;
  // final DateTime createdAt;
  final String name;
  // final String avatar;

  // TinhModel({ this.id, this.createdAt,  this.name, this.avatar});
  TinhModel({this.id, this.name});

  factory TinhModel.fromJson(Map<String, dynamic> json) {
    return TinhModel(
      id: json["id"],
      // createdAt:json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      name: json["name"],
      // avatar: json["avatar"],
    );
  }

  static List<TinhModel> fromJsonList(List list) {
    return list.map((item) => TinhModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    // return this.createdAt.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(TinhModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}

class QuanModel {
  final int id;
  // final DateTime createdAt;
  final String name;
  // final String avatar;

  // TinhModel({ this.id, this.createdAt,  this.name, this.avatar});
  QuanModel({this.id, this.name});

  factory QuanModel.fromJson(Map<String, dynamic> json) {
    return QuanModel(
      id: json["id"],
      // createdAt:json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      name: json["name"],
      // avatar: json["avatar"],
    );
  }

  static List<QuanModel> fromJsonList(List list) {
    return list.map((item) => QuanModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    // return this.createdAt.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(QuanModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}


class ProvinceModel {
  final String id;
  final String text;

  ProvinceModel({
    String this.id,
    String this.text
  });

  factory ProvinceModel.fromJson(Map<String, dynamic> json) {
    return ProvinceModel(
        id: json["id"],
        text: json["text"]
    );
  }

  static List<ProvinceModel> fromJsonList(List list) {
    return list.map((item) => ProvinceModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.text}';
  }

  ///this method will prevent the override of toString

  ///custom comparing function to check if two users are equal
  bool isEqual(ProvinceModel model) {
    return this.id == model.id;
  }

  @override
  String toString() => text;
}

//
// class HomeTinh extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<HomeTinh> {
//   final _formKey = GlobalKey<FormState>();
//   final _openDropDownProgKey = GlobalKey<DropdownSearchState<String>>();
//   final _multiKey = GlobalKey<DropdownSearchState<String>>();
//   final _userEditTextController = TextEditingController(text: 'Mrs');
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("DropdownSearch Demo")),
//       body: Padding(
//         padding: const EdgeInsets.all(25),
//         child: Form(
//           key: _formKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: ListView(
//             padding: EdgeInsets.all(4),
//             children: <Widget>[
//               ///Menu Mode with no searchBox MultiSelection
//               DropdownSearch<String>.multiSelection(
//                 key: _multiKey,
//                 validator: (List<String> v) {
//                   return v == null || v.isEmpty ? "required field" : null;
//                 },
//                 dropdownBuilder: (context, selectedItems) {
//                   Widget item(String i) => Container(
//                     padding: EdgeInsets.only(
//                         left: 6, bottom: 3, top: 3, right: 0),
//                     margin: EdgeInsets.symmetric(horizontal: 2),
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Theme.of(context).primaryColorLight),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Text(
//                           i,
//                           textAlign: TextAlign.center,
//                           style: Theme.of(context).textTheme.subtitle2,
//                         ),
//                         MaterialButton(
//                           height: 20,
//                           shape: const CircleBorder(),
//                           focusColor: Colors.red[200],
//                           hoverColor: Colors.red[200],
//                           padding: EdgeInsets.all(0),
//                           minWidth: 34,
//                           onPressed: () {
//                             _multiKey.currentState?.removeItem(i);
//                           },
//                           child: Icon(
//                             Icons.close_outlined,
//                             size: 20,
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                   return Wrap(
//                     children: selectedItems.map((e) => item(e)).toList(),
//                   );
//                 },
//                 popupCustomMultiSelectionWidget: (context, list) {
//                   return Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.all(8),
//                         child: OutlinedButton(
//                           onPressed: () {
//                             // How should I unselect all items in the list?
//                             _multiKey.currentState?.closeDropDownSearch();
//                           },
//                           child: const Text('Cancel'),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(8),
//                         child: OutlinedButton(
//                           onPressed: () {
//                             // How should I select all items in the list?
//                             _multiKey.currentState?.popupSelectAllItems();
//                           },
//                           child: const Text('All'),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(8),
//                         child: OutlinedButton(
//                           onPressed: () {
//                             // How should I unselect all items in the list?
//                             _multiKey.currentState?.popupDeselectAllItems();
//                           },
//                           child: const Text('None'),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//                 dropdownSearchDecoration: InputDecoration(
//                   hintText: "Select a country",
//                   labelText: "Menu mode multiSelection*",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 mode: Mode.MENU,
//                 showSelectedItems: true,
//                 items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
//                 showClearButton: true,
//                 onChanged: print,
//                 popupSelectionWidget: (cnt, String item, bool isSelected) {
//                   return isSelected
//                       ? Icon(
//                     Icons.check_circle,
//                     color: Colors.green[500],
//                   )
//                       : Container();
//                 },
//                 popupItemDisabled: (String s) => s.startsWith('I'),
//                 clearButtonSplashRadius: 20,
//                 selectedItems: ["Tunisia"],
//               ),
//               Divider(),
//
//               ///Menu Mode with no searchBox
//               DropdownSearch<String>(
//                 validator: (v) => v == null ? "required field" : null,
//                 dropdownSearchDecoration: InputDecoration(
//                   hintText: "Select a country",
//                   labelText: "Menu mode *",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 mode: Mode.MENU,
//                 showSelectedItems: true,
//                 items: ["Brazil", "Italia (Disabled)", "Tunisia", 'Canada'],
//                 showClearButton: true,
//                 onChanged: print,
//                 popupItemDisabled: (String s) => s?.startsWith('I') ?? false,
//                 clearButtonSplashRadius: 20,
//                 selectedItem: "Tunisia",
//                 onBeforeChange: (a, b) {
//                   if (b == null) {
//                     AlertDialog alert = AlertDialog(
//                       title: Text("Are you sure..."),
//                       content: Text("...you want to clear the selection"),
//                       actions: [
//                         TextButton(
//                           child: Text("OK"),
//                           onPressed: () {
//                             Navigator.of(context).pop(true);
//                           },
//                         ),
//                         TextButton(
//                           child: Text("NOT OK"),
//                           onPressed: () {
//                             Navigator.of(context).pop(false);
//                           },
//                         ),
//                       ],
//                     );
//
//                     return showDialog<bool>(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return alert;
//                         });
//                   }
//
//                   return Future.value(true);
//                 },
//               ),
//               Divider(),
//
//               ///Menu Mode with no searchBox
//               DropdownSearch<String>(
//                 validator: (v) => v == null ? "required field" : null,
//                 dropdownSearchDecoration: InputDecoration(
//                   hintText: "Select a country",
//                   labelText: "Menu mode with helper *",
//                   helperText: 'positionCallback example usage',
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 mode: Mode.MENU,
//                 showSelectedItems: true,
//                 items: ["Brazil", "Italia", "Tunisia", 'Canada'],
//                 onChanged: print,
//                 selectedItem: "Tunisia",
//                 positionCallback: (popupButtonObject, overlay) {
//                   final decorationBox = _findBorderBox(popupButtonObject);
//
//                   double translateOffset = 0;
//                   if (decorationBox != null) {
//                     translateOffset = decorationBox.size.height -
//                         popupButtonObject.size.height;
//                   }
//
//                   // Get the render object of the overlay used in `Navigator` / `MaterialApp`, i.e. screen size reference
//                   final RenderBox overlay = Overlay.of(context)
//                       .context
//                       .findRenderObject() as RenderBox;
//                   // Calculate the show-up area for the dropdown using button's size & position based on the `overlay` used as the coordinate space.
//                   return RelativeRect.fromSize(
//                     Rect.fromPoints(
//                       popupButtonObject
//                           .localToGlobal(
//                           popupButtonObject.size.bottomLeft(Offset.zero),
//                           ancestor: overlay)
//                           .translate(0, translateOffset),
//                       popupButtonObject.localToGlobal(
//                           popupButtonObject.size.bottomRight(Offset.zero),
//                           ancestor: overlay),
//                     ),
//                     Size(overlay.size.width, overlay.size.height),
//                   );
//                 },
//               ),
//               Divider(),
//
//               ///Menu Mode with overriden icon and dropdown buttons
//               Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: DropdownSearch<String>(
//                       validator: (v) => v == null ? "required field" : null,
//                       mode: Mode.MENU,
//                       dropdownSearchDecoration: InputDecoration(
//                         hintText: "Select a country",
//                         labelText: "Menu mode *",
//                         filled: true,
//                         border: UnderlineInputBorder(
//                           borderSide: BorderSide(color: Color(0xFF01689A)),
//                         ),
//                       ),
//                       showAsSuffixIcons: true,
//                       clearButtonBuilder: (_) => Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: const Icon(
//                           Icons.clear,
//                           size: 24,
//                           color: Colors.black,
//                         ),
//                       ),
//                       dropdownButtonBuilder: (_) => Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: const Icon(
//                           Icons.arrow_drop_down,
//                           size: 24,
//                           color: Colors.black,
//                         ),
//                       ),
//                       showSelectedItems: true,
//                       items: [
//                         "Brazil",
//                         "Italia (Disabled)",
//                         "Tunisia",
//                         'Canada'
//                       ],
//                       showClearButton: true,
//                       onChanged: print,
//                       popupItemDisabled: (String s) =>
//                       s?.startsWith('I') ?? true,
//                       selectedItem: "Tunisia",
//                     ),
//                   ),
//                   Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           filled: true,
//                           labelText: "Menu mode *",
//                           border: UnderlineInputBorder(
//                             borderSide: BorderSide(color: Color(0xFF01689A)),
//                           ),
//                         ),
//                       ))
//                 ],
//               ),
//               Divider(),
//
//
//               ///custom itemBuilder and dropDownBuilder
//               DropdownSearch<UserModel>(
//                 showSelectedItems: true,
//                 compareFn: (i, s) => i?.isEqual(s) ?? false,
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "Person",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 onFind: (String filter) => getData(filter),
//                 onChanged: (data) {
//                   print(data);
//                 },
//                 dropdownBuilder: _customDropDownExample,
//                 popupItemBuilder: _customPopupItemBuilderExample2,
//               ),
//               Divider(),
//
//               ///BottomSheet Mode with no searchBox
//               DropdownSearch<String>(
//                 mode: Mode.BOTTOM_SHEET,
//                 items: [
//                   "Brazil",
//                   "Italia",
//                   "Tunisia",
//                   'Canada',
//                   'Zraoua',
//                   'France',
//                   'Belgique'
//                 ],
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "Custom BottomShet mode",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: print,
//                 selectedItem: "Brazil",
//                 showSearchBox: true,
//                 searchFieldProps: TextFieldProps(
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(),
//                     contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
//                     labelText: "Search a country1",
//                   ),
//                 ),
//                 popupTitle: Container(
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColorDark,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'Country',
//                       style: TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//                 popupShape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   ),
//                 ),
//               ),
//               Divider(),
//
//               ///show favorites on top list
//               DropdownSearch<UserModel>.multiSelection(
//                 showSelectedItems: true,
//                 showSearchBox: true,
//                 compareFn: (i, s) => i?.isEqual(s) ?? false,
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "Person with favorite option",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 onFind: (filter) => getData(filter),
//                 onChanged: (data) {
//                   print(data);
//                 },
//                 // dropdownBuilder: _customDropDownExample,
//                 popupItemBuilder: _customPopupItemBuilderExample2,
//                 showFavoriteItems: true,
//                 favoriteItemsAlignment: MainAxisAlignment.start,
//                 favoriteItems: (items) {
//                   return items.where((e) => e.name.contains("Mrs")).toList();
//                 },
//                 favoriteItemBuilder: (context, item, isSelected) {
//                   return Container(
//                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.grey[100]),
//                     child: Row(
//                       children: [
//                         Text(
//                           "${item.name}",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.indigo),
//                         ),
//                         Padding(padding: EdgeInsets.only(left: 8)),
//                         isSelected
//                             ? Icon(Icons.check_box_outlined)
//                             : Container(),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               Divider(),
//
//               ///merge online and offline data in the same list and set custom max Height
//               DropdownSearch<UserModel>(
//                 items: [
//                   UserModel(name: "Offline name1", id: "999"),
//                   UserModel(name: "Offline name2", id: "0101")
//                 ],
//                 maxHeight: 300,
//                 onFind: (String filter) => getData(filter),
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "choose a user",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: print,
//                 showSearchBox: true,
//               ),
//               Divider(),
//
//               ///open dropdown programmatically
//               DropdownSearch<String>(
//                 items: ["no action", "confirm in the next dropdown"],
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "open another dropdown programmatically",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 onChanged: (v) {
//                   if (v == "confirm in the next dropdown") {
//                     _openDropDownProgKey.currentState?.openDropDownSearch();
//                   }
//                 },
//               ),
//               Padding(padding: EdgeInsets.all(4)),
//               DropdownSearch<String>(
//                 validator: (value) => value == null ? "empty" : null,
//                 key: _openDropDownProgKey,
//                 items: ["Yes", "No"],
//                 dropdownSearchDecoration: InputDecoration(
//                   labelText: "confirm",
//                   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
//                   border: OutlineInputBorder(),
//                 ),
//                 showSelectedItems: true,
//                 dropdownButtonSplashRadius: 20,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   ElevatedButton(
//                       onPressed: () {
//                         _openDropDownProgKey.currentState?.openDropDownSearch();
//                       },
//                       child: Text("Open dropdownSearch")),
//                   ElevatedButton(
//                       onPressed: () {
//                         _openDropDownProgKey.currentState
//                             ?.changeSelectedItem("No");
//                       },
//                       child: Text("set to 'NO'")),
//                   Material(
//                     child: ElevatedButton(
//                         onPressed: () {
//                           _openDropDownProgKey.currentState
//                               ?.changeSelectedItem("Yes");
//                         },
//                         child: Text("set to 'YES'")),
//                   ),
//                   ElevatedButton(
//                       onPressed: () {
//                         _openDropDownProgKey.currentState
//                             ?.changeSelectedItem('Blabla');
//                       },
//                       child: Text("set to 'Blabla'")),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _customDropDownExampleMultiSelection(
//       BuildContext context, List<UserModel> selectedItems) {
//     if (selectedItems.isEmpty) {
//       return ListTile(
//         contentPadding: EdgeInsets.all(0),
//         leading: CircleAvatar(),
//         title: Text("No item selected"),
//       );
//     }
//
//     return Wrap(
//       children: selectedItems.map((e) {
//         return Padding(
//           padding: const EdgeInsets.all(4.0),
//           child: Container(
//             child: ListTile(
//               contentPadding: EdgeInsets.all(0),
//               leading: CircleAvatar(
//                 // this does not work - throws 404 error
//                 // backgroundImage: NetworkImage(item.avatar ?? ''),
//               ),
//               title: Text(e?.name ?? ''),
//               subtitle: Text(
//                 e?.createdAt.toString() ?? '',
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   RenderBox _findBorderBox(RenderBox box) {
//     RenderBox borderBox;
//
//     box.visitChildren((child) {
//       if (child is RenderCustomPaint) {
//         borderBox = child;
//       }
//
//       final box = _findBorderBox(child as RenderBox);
//       if (box != null) {
//         borderBox = box;
//       }
//     });
//
//     return borderBox;
//   }
//
//   Widget _customDropDownExample(BuildContext context, UserModel item) {
//     if (item == null) {
//       return Container();
//     }
//
//     return Container(
//       child: (item.avatar == null)
//           ? ListTile(
//         contentPadding: EdgeInsets.all(0),
//         leading: CircleAvatar(),
//         title: Text("No item selected"),
//       )
//           : ListTile(
//         contentPadding: EdgeInsets.all(0),
//         leading: CircleAvatar(
//           // this does not work - throws 404 error
//           // backgroundImage: NetworkImage(item.avatar ?? ''),
//         ),
//         title: Text(item.name),
//         subtitle: Text(
//           item.createdAt.toString(),
//         ),
//       ),
//     );
//   }
//
//   Widget _customPopupItemBuilderExample(
//       BuildContext context, UserModel item, bool isSelected) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       decoration: !isSelected
//           ? null
//           : BoxDecoration(
//         border: Border.all(color: Theme.of(context).primaryColor),
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.white,
//       ),
//       child: ListTile(
//         selected: isSelected,
//         title: Text(item?.name ?? ''),
//         subtitle: Text(item?.createdAt?.toString() ?? ''),
//         leading: CircleAvatar(
//           // this does not work - throws 404 error
//           // backgroundImage: NetworkImage(item.avatar ?? ''),
//         ),
//       ),
//     );
//   }
//
//   Widget _customPopupItemBuilderExample2(
//       BuildContext context, UserModel item, bool isSelected) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 8),
//       decoration: !isSelected
//           ? null
//           : BoxDecoration(
//         border: Border.all(color: Theme.of(context).primaryColor),
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.white,
//       ),
//       child: ListTile(
//         selected: isSelected,
//         title: Text(item?.name ?? ''),
//         subtitle: Text(item?.createdAt?.toString() ?? ''),
//         leading: CircleAvatar(
//           // this does not work - throws 404 error
//           // backgroundImage: NetworkImage(item.avatar ?? ''),
//         ),
//       ),
//     );
//   }
//
//   Future<List<UserModel>> getData(filter) async {
//     var response = await Dio().get(
//       "https://5d85ccfb1e61af001471bf60.mockapi.io/user",
//       queryParameters: {"filter": filter},
//     );
//
//     final data = response.data;
//     if (data != null) {
//       return UserModel.fromJsonList(data);
//     }
//
//     return [];
//   }
// }

class UserModel {
  final String id;
  final DateTime createdAt;
  final String name;
  final String avatar;

  UserModel({ this.id, this.createdAt,  this.name, this.avatar});
  // TinhModel({this.id, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      createdAt:
      json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      name: json["name"],
      avatar: json["avatar"],
    );
  }

  static List<UserModel> fromJsonList(List list) {
    return list.map((item) => UserModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#${this.id} ${this.name}';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    return this.createdAt?.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(UserModel model) {
    return this.id == model?.id;
  }

  @override
  String toString() => name;
}


class MyHomePageCity extends StatefulWidget {
  @override
  _MyHomePageStateCT createState() => _MyHomePageStateCT();
}

class _MyHomePageStateCT extends State<MyHomePageCity> {
  @override
  void initState() {
    _getStateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic DropDownList REST API'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 100, top: 100),
            child: Text(
              'KDTechs',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          //======================================================== State

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myState,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Select Phuong'),
                        onChanged: (String newValue) {
                          setState(() {
                            _myState = newValue;
                            _getCitiesList(_myState);
                            print(_myState);
                          });
                        },
                        items: statesList?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                          );
                        })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //======================================================== City

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton<String>(
                        value: _myCity,
                        iconSize: 30,
                        icon: (null),
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                        hint: Text('Select Quan'),
                        onChanged: (String newValue) {
                          setState(() {
                            _myCity = newValue;
                            print(_myCity);
                          });
                        },
                        items: citiesList?.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                          );
                        })?.toList() ??
                            [],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //=============================================================================== Api Calling here

//CALLING STATE API HERE
// Get State information by API
  List statesList;
  String _myState;
  String stateInfoUrl = 'https://gtnexpress.vn/api/get_quan';
  Future<String> _getStateList() async {
    await http.post(stateInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
    }).then((response) {
      var data = json.decode(response.body);

     print(data);
      setState(() {
        // statesList = data['state'];
        statesList = data;
      });
    });
  }

  // Get State information by API
  List citiesList;
  String _myCity;

  String cityInfoUrl = 'https://gtnexpress.vn/api/get_phuong';
  Future<String> _getCitiesList(_myState) async {
    await http.post(cityInfoUrl, headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      "api_key": '25d55ad283aa400af464c76d713c07ad',
      "state_id": _myState,
    }).then((response) {
      var data = json.decode(response.body);

      print(data);
      setState(() {
        // citiesList = data['cities'];
        citiesList = data;
      });
    });
  }
}












class FormRegister extends StatefulWidget {
  AccountModel profile;
  FormRegister({Key key, this.profile}) : super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  final GlobalKey<ScaffoldState> _scaffoldStateX = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  QuanModel selectedQuan;
  String tinhtinhtinh="";

  bool _isFieldUsernameValid;
  bool _isFieldBankValid;//pass
  bool _isFieldNameValid;
  bool _isFieldPhoneValid;
  bool _isFieldEmailValid;
  bool _isFieldAddressValid;
  // bool _isFieldBanknoValid;
  bool _isFieldTinhValid;
  bool _isFieldQuanValid;

  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  // final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerTinh = TextEditingController();
  final TextEditingController _controllerQuan = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerBank = TextEditingController();
  // final TextEditingController _controllerBankno = TextEditingController();
  final List<ProvinceModel> cities = [
    ProvinceModel(id: "01", text: "Hà Nội"),
    ProvinceModel(id: "02", text: "Hà Giang"),
    ProvinceModel(id: "04", text: "Cao Bằng"),
    ProvinceModel(id: "06", text: "Bắc Kạn"),
    ProvinceModel(id: "08", text: "Tuyên Quang"),
    ProvinceModel(id: "10", text: "Lào Cai"),
    ProvinceModel(id: "11", text: "Điện Biên"),
    ProvinceModel(id: "12", text: "Lai Châu"),
    ProvinceModel(id: "14", text: "Sơn La"),
    ProvinceModel(id: "15", text: "Yên Bái"),
    ProvinceModel(id: "17", text: "Hoà Bình"),
    ProvinceModel(id: "19", text: "Thái Nguyên"),
    ProvinceModel(id: "20", text: "Lạng Sơn"),
    ProvinceModel(id: "22", text: "Quảng Ninh"),
    ProvinceModel(id: "24", text: "Bắc Giang"),
    ProvinceModel(id: "25", text: "Phú Thọ"),
    ProvinceModel(id: "26", text: "Vĩnh Phúc"),
    ProvinceModel(id: "27", text: "Bắc Ninh"),
    ProvinceModel(id: "30", text: "Hải Dương"),
    ProvinceModel(id: "31", text: "Hải Phòng"),
    ProvinceModel(id: "33", text: "Hưng Yên"),
    ProvinceModel(id: "34", text: "Thái Bình"),
    ProvinceModel(id: "35", text: "Hà Nam"),
    ProvinceModel(id: "36", text: "Nam Định"),
    ProvinceModel(id: "37", text: "Ninh Bình"),
    ProvinceModel(id: "38", text: "Thanh Hóa"),
    ProvinceModel(id: "40", text: "Nghệ An"),
    ProvinceModel(id: "42", text: "Hà Tĩnh"),
    ProvinceModel(id: "44", text: "Quảng Bình"),
    ProvinceModel(id: "45", text: "Quảng Trị"),
    ProvinceModel(id: "46", text: "Thừa Thiên Huế"),
    ProvinceModel(id: "48", text: "Đà Nẵng"),
    ProvinceModel(id: "49", text: "Quảng Nam"),
    ProvinceModel(id: "51", text: "Quảng Ngãi"),
    ProvinceModel(id: "52", text: "Bình Định"),
    ProvinceModel(id: "54", text: "Phú Yên"),
    ProvinceModel(id: "56", text: "Khánh Hòa"),
    ProvinceModel(id: "58", text: "Ninh Thuận"),
    ProvinceModel(id: "60", text: "Bình Thuận"),
    ProvinceModel(id: "62", text: "Kon Tum"),
    ProvinceModel(id: "64", text: "Gia Lai"),
    ProvinceModel(id: "66", text: "Đắk Lắk"),
    ProvinceModel(id: "67", text: "Đắk Nông"),
    ProvinceModel(id: "68", text: "Lâm Đồng"),
    ProvinceModel(id: "70", text: "Bình Phước"),
    ProvinceModel(id: "72", text: "Tây Ninh"),
    ProvinceModel(id: "74", text: "Bình Dương"),
    ProvinceModel(id: "75", text: "Đồng Nai"),
    ProvinceModel(id: "77", text: "Bà Rịa - Vũng Tàu"),
    ProvinceModel(id: "79", text: "Hồ Chí Minh"),
    ProvinceModel(id: "80", text: "Long An"),
    ProvinceModel(id: "82", text: "Tiền Giang"),
    ProvinceModel(id: "83", text: "Bến Tre"),
    ProvinceModel(id: "84", text: "Trà Vinh"),
    ProvinceModel(id: "86", text: "Vĩnh Long"),
    ProvinceModel(id: "87", text: "Đồng Tháp"),
    ProvinceModel(id: "89", text: "An Giang"),
    ProvinceModel(id: "91", text: "Kiên Giang"),
    ProvinceModel(id: "92", text: "Cần Thơ"),
    ProvinceModel(id: "93", text: "Hậu Giang"),
    ProvinceModel(id: "94", text: "Sóc Trăng"),
    ProvinceModel(id: "95", text: "Bạc Liêu"),
    ProvinceModel(id: "96", text: "Cà Mau"),
  ];

  int _radioSelected = 1;
  String _radioVal ="khach";

  void _processData() {
    // Process your data and upload to server
    if (widget.profile != null) {
      _isFieldNameValid = true;
      _isFieldUsernameValid = true;
      _isFieldPhoneValid = true;
      _isFieldEmailValid = true;
      _isFieldTinhValid = true;
      _isFieldAddressValid = true;

      _controllerUsername.text = widget.profile.userName;
      _controllerName.text = widget.profile.fullName;
      _controllerPhone.text = widget.profile.phoneNo;
      _controllerEmail.text = widget.profile.email;
      _controllerTinh.text = widget.profile.city;
      _controllerAddress.text = widget.profile.address;
    }
  }

  @override
  void initState() {
    if (widget.profile != null) {
      _isFieldNameValid = true;
      _isFieldUsernameValid = true;
      _isFieldPhoneValid = true;
      _isFieldEmailValid = true;
      _isFieldTinhValid = true;
      _isFieldAddressValid = true;

      _controllerUsername.text = widget.profile.userName;
      _controllerName.text = widget.profile.fullName;
      _controllerPhone.text = widget.profile.phoneNo;
      _controllerEmail.text = widget.profile.email;
      _controllerTinh.text = widget.profile.city;
      _controllerAddress.text = widget.profile.address;
    }
    super.initState();
  }

  _showDialog(String result) async {
    // flutter defined function
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return  CupertinoAlertDialog(
          title: Text("Serial: ${result}"),
          actions: [
            CupertinoDialogAction(onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop('${result}');
            }, child: Text("OK")),
            CupertinoDialogAction(onPressed: () async {
              setState(() {
                result = null;
              });
              // await controller?.resumeCamera();
              Navigator.of(context, rootNavigator: true).pop(false);
            }, child: Text("Quét lại")),
          ],
          content: Text(""),
        );
      },
    );
  }

  void showAlertx() {
    // AlertDialog(
    //   title: Text('TH01AC21058asd'),
    //   actions: [
    //     TextButton(
    //       // onPressed: (_) => Navigator.pop(context, true), // passing true
    //       // onPressed: () => Navigator.of(context).pop(result),
    //       // onPressed: () async {
    //       //   // await controller?.pauseCamera();
    //       //   // Navigator.of(context).pop("TH02TV210120");
    //       // },
    //       onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
    //       child: const Text('OK True'),
    //     ),
    //     TextButton(
    //       // onPressed: () => Navigator.pop(context, false),
    //       onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
    //
    //       // onPressed: () async {
    //       //   await controller?.resumeCamera();
    //       //   result = null;
    //       // },
    //       child: const Text('Quét lại pop false',style: TextStyle(color: Colors.red)),
    //     ),
    //   ],
    // );
    showDialog(context: context,builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20.0)), //this right here
        child:SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const[
                      Text(
                        'Cập nhật tài khoản thành công!',
                        style: TextStyle(fontSize: 16,color:  const Color(0xFF1BC0C5),),
                        softWrap: true,
                        maxLines: 20,
                      ),
                    ],
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: const Color(0xFF1BC0C5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20.0)), //this right here
        child: Container(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Cập nhật tài khoản thành công!'),
                ),
                SizedBox(
                  width: 270.0,
                  child: RaisedButton(
                    onPressed: () {
                      // setState(() {
                      //   widget.profile.fullName = profile.name;
                      //   widget.profile.phoneNo = profile.phone;
                      //   widget.profile.address = profile.address;
                      //   widget.profile.city = profile.tinh;
                      //   _controllerName.text = profile.name;//widget.profile.fullName;
                      //   _controllerPhone.text = profile.phone;
                      //   _controllerAddress.text = profile.address;
                      //   _controllerTinh.text= profile.tinh;
                      // });
                      Navigator.pop(context, false);
                      // Navigator.pop(_scaffoldStateX.currentState.context,true);
                      // setState(() {});
                      // _controllerSerial.clear();
                      // _controllerSerial.text=null;
                      // _controllerName.clear();
                      // _controllerPhone.clear();
                      // _controllerAddress.clear();
                      // _controllerDistrict.clear();
                      // _controllerDistrict.text=null;
                      // _controllerTinh.clear();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(0xFF1BC0C5),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.profile == null ? "Tạo tài khoản" : "Cập nhật tài khoản",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      key: _scaffoldStateX,
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.only(top: 15.0),),
                      if(widget.profile != null) ...[
                        // _buildTextFieldUsername(),
                        _buildTextFieldName(),
                        _buildTextFieldPhone(),
                        _buildTextFieldEmail(),
                        _buildTextFieldAddress(),
                        _buildTinh(),
                        _buildQuan(),
                      ]
                      else ...[
                        _buildTextFieldUsername(),
                        _buildTextFieldPassword(),
                        // _buildTextFieldName(),
                        // _buildTextFieldPhone(),
                        _buildTextFieldEmail(),
                        // _buildTextFieldAddress(),
                        // _buildTinh(),
                        // _buildQuan(),
                        _buildRadio(),
                      ],
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                          child: Text(
                            widget.profile == null
                                ? "Đăng ký".toUpperCase()
                                : "Cập nhật".toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (widget.profile != null){
                              setState(() {
                                _isFieldUsernameValid = _isFieldBankValid = _isFieldEmailValid = true;
                              });
                            }
                            if (_isFieldUsernameValid == null ||
                                // _isFieldNameValid == null ||
                                _isFieldBankValid == null ||
                                _isFieldEmailValid == null ||
                                // _isFieldAddressValid == null ||
                                // _isFieldPhoneValid == null ||
                                // _isFieldTinhValid == null ||
                                // _isFieldQuanValid == null ||

                                !_isFieldUsernameValid ||
                                // !_isFieldNameValid ||
                                !_isFieldBankValid ||
                                !_isFieldEmailValid
                                // !_isFieldAddressValid ||
                                // !_isFieldPhoneValid ||
                                // !_isFieldTinhValid ||
                                // !_isFieldQuanValid
                            ) {
                              _scaffoldStateX.currentState.showSnackBar(
                                const SnackBar(
                                  content: Text("Vui lòng điền tất cả thông tin",),
                                  // content: Text("Please fill all field",textAlign: TextAlign.center),
                                  backgroundColor: Colors.deepOrange,
                                  // duration: Duration(seconds: 6),
                                  // behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }
                            setState(() => _isLoading = true);
                            if (widget.profile == null) {
                              Profile profile = Profile(
                                  username: _controllerUsername.text.toString(),
                                  // name: _controllerName.text.toString(),
                                  name: "GTNE",
                                  email: _controllerEmail.text.toString(),
                                  // phone: _controllerPhone.text.toString(),
                                  phone: $_radioVal,
                                  // address: _controllerAddress.text.toString(),
                                  address: "5a Chien thang",
                                  nganhang: _controllerBank.text.toString(),//pass
                                  tinh: "608",quan:"23293",
                                  // tinh: _controllerTinh.text.toString(),
                                  // quan: _controllerQuan.text.toString()
                              );
                              _apiService.createAccount(profile).then((String isSuccess) {
                                setState(() => _isLoading = false);
                                if (isSuccess == "success"){
                                  // _scaffoldState.currentState.showSnackBar(const SnackBar(
                                  //   content: Text("Đăng ký tài khoản thành công!",textAlign: TextAlign.center,),
                                  // ));
                                  Navigator.pop(_scaffoldStateX.currentState.context);
                                  showDialog(context: context,builder: (BuildContext context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(20.0)), //this right here
                                      child: Container(
                                        height: 170,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.center,
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: 'Đăng ký tài khoản thành công!'),
                                              ),
                                              SizedBox(
                                                width: 70.0,
                                                child: RaisedButton(
                                                  onPressed: () {Navigator.pop(context);},
                                                  child: Text(
                                                    "OK",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  color: const Color(0xFF1BC0C5),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                } else {
                                  _scaffoldStateX.currentState.showSnackBar( SnackBar(
                                    backgroundColor: Colors.deepOrange,
                                    content: Text(isSuccess.toString(),textAlign: TextAlign.center,),
                                  ));
                                }
                              });
                            }
                            else {
                              Profile profile = Profile(
                                  username: _controllerUsername.text.toString(),
                                  name: _controllerName.text.toString(),
                                  email: _controllerEmail.text.toString(),
                                  phone: _controllerPhone.text.toString(),
                                  address: _controllerAddress.text.toString(),
                                  nganhang: _controllerBank.text.toString(),//pass
                                  tinh: _controllerTinh.text.toString(),
                                  quan: _controllerQuan.text.toString()
                              );
                              // _isFieldUsernameValid = _isFieldBankValid = _isFieldEmailValid = true;
                              _apiService.updateAccount(profile).then((isSuccess) {
                                setState(() => _isLoading = false);
                                if (isSuccess == "success"){
                                  // _scaffoldState.currentState.showSnackBar(const SnackBar(content: Text("Cập nhật thành công"),));
                                  Navigator.of(context).pop(true);
                                  // setState(() {
                                  //   widget.profile.fullName = profile.name;
                                  //   widget.profile.phoneNo = profile.phone;
                                  //   widget.profile.address = profile.address;
                                  //   widget.profile.city = profile.tinh;
                                  //   _controllerName.text = profile.name;//widget.profile.fullName;
                                  //   _controllerPhone.text = profile.phone;
                                  //   _controllerAddress.text = profile.address;
                                  //   _controllerTinh.text= profile.tinh;
                                  // });
                                  showAlertx();
                                  // _showDialog("textxxxx");
                                }
                                else {
                                  _scaffoldStateX.currentState.showSnackBar(const SnackBar(content: Text("Cập nhật thất bại"),
                                  ));
                                }
                              });
                            }
                          },
                          // child: Colors.teal[800],
                        ),
                      ),
                      _isLoading
                          ? CircularProgressIndicator(): Container(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );

    // return Scaffold(
    //   // backgroundColor: Colors.teal[100],
    //   key: _scaffoldState,
    //   appBar: AppBar(
    //     iconTheme: const IconThemeData(color: Colors.white),
    //     title: Text(
    //       widget.profile == null ? "Tạo tài khoản" : "Cập nhật",
    //       style: const TextStyle(color: Colors.white),
    //     ),
    //   ),
    //   body: SingleChildScrollView(
    //     child: ConstrainedBox(
    //       constraints:
    //       BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
    //       child: Stack(
    //         children: <Widget>[
    //           Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: <Widget>[
    //                 _buildTextFieldUsername(),
    //                 _buildTextFieldPassword(),
    //                 _buildTextFieldName(),
    //                 _buildTextFieldPhone(),
    //                 _buildTextFieldEmail(),
    //                 _buildTextFieldAddress(),
    //                 _buildTinh(),
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 8.0),
    //                   child: ElevatedButton(
    //                     child: Text(
    //                       widget.profile == null
    //                           ? "Đăng ký".toUpperCase()
    //                           : "Cập nhật".toUpperCase(),
    //                       style: const TextStyle(
    //                         color: Colors.white,
    //                       ),
    //                     ),
    //                     onPressed: () {
    //                       if (widget.profile != null){
    //                         setState(() {
    //                           _isFieldUsernameValid = _isFieldBankValid = _isFieldEmailValid = true;
    //                         });
    //                       }
    //                       if (_isFieldUsernameValid == null ||
    //                           _isFieldNameValid == null ||
    //                           _isFieldBankValid == null ||
    //                           _isFieldEmailValid == null ||
    //                           _isFieldAddressValid == null ||
    //                           _isFieldPhoneValid == null ||
    //                           _isFieldTinhValid == null ||
    //
    //                           !_isFieldUsernameValid ||
    //                           !_isFieldNameValid ||
    //                           !_isFieldBankValid ||
    //                           !_isFieldEmailValid ||
    //                           !_isFieldAddressValid ||
    //                           !_isFieldPhoneValid ||
    //                           !_isFieldTinhValid
    //                       ) {
    //                         _scaffoldState.currentState.showSnackBar(
    //                           const SnackBar(
    //                             content: Text("Vui lòng điền tất cả thông tin",),
    //                             // content: Text("Please fill all field",textAlign: TextAlign.center),
    //                             backgroundColor: Colors.deepOrange,
    //                             // duration: Duration(seconds: 6),
    //                             // behavior: SnackBarBehavior.floating,
    //                           ),
    //                         );
    //                         return;
    //                       }
    //                       setState(() => _isLoading = true);
    //                       Profile profile = Profile(
    //                         username: _controllerUsername.text.toString(),
    //                         name: _controllerName.text.toString(),
    //                         email: _controllerEmail.text.toString(),
    //                         phone: _controllerPhone.text.toString(),
    //                         address: _controllerAddress.text.toString(),
    //                         nganhang: _controllerBank.text.toString(),//pass
    //                         tinh: _controllerTinh.text.toString(),
    //                       );
    //                       if (widget.profile == null) {
    //                         _apiService.createAccount(profile).then((String isSuccess) {
    //                           setState(() => _isLoading = false);
    //                           if (isSuccess == "success"){
    //                             // _scaffoldState.currentState.showSnackBar(const SnackBar(
    //                             //   content: Text("Đăng ký tài khoản thành công!",textAlign: TextAlign.center,),
    //                             // ));
    //                             Navigator.pop(_scaffoldState.currentState.context);
    //                             showDialog(context: context,builder: (BuildContext context) {
    //                               return Dialog(
    //                                 shape: RoundedRectangleBorder(
    //                                     borderRadius:
    //                                     BorderRadius.circular(20.0)), //this right here
    //                                 child: Container(
    //                                   height: 200,
    //                                   child: Padding(
    //                                     padding: const EdgeInsets.all(12.0),
    //                                     child: Column(
    //                                       mainAxisAlignment: MainAxisAlignment.center,
    //                                       crossAxisAlignment: CrossAxisAlignment.start,
    //                                       children: [
    //                                         TextField(
    //                                           decoration: InputDecoration(
    //                                               border: InputBorder.none,
    //                                               hintText: 'Đăng ký tài khoản thành công!'),
    //                                         ),
    //                                         SizedBox(
    //                                           width: 70.0,
    //                                           child: RaisedButton(
    //                                             onPressed: () {Navigator.pop(context);},
    //                                             child: Text(
    //                                               "OK",
    //                                               style: TextStyle(color: Colors.white),
    //                                             ),
    //                                             color: const Color(0xFF1BC0C5),
    //                                           ),
    //                                         )
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                               );
    //                             });
    //                           } else {
    //                             _scaffoldState.currentState.showSnackBar( SnackBar(
    //                               backgroundColor: Colors.deepOrange,
    //                               content: Text(isSuccess.toString(),textAlign: TextAlign.center,),
    //                             ));
    //                           }
    //                         });
    //                       } else {
    //                         // _isFieldUsernameValid = _isFieldBankValid = _isFieldEmailValid = true;
    //                         _apiService.updateAccount(profile).then((isSuccess) {
    //                           setState(() => _isLoading = false);
    //                           if (isSuccess == "success"){
    //                             // Navigator.pop(_scaffoldState.currentState.context);
    //                             // _scaffoldState.currentState.showSnackBar(const SnackBar(content: Text("Cập nhật thành công"),));
    //                             setState(() {});
    //                             Navigator.pop(_scaffoldState.currentState.context);
    //                             showDialog(context: context,builder: (BuildContext context) {
    //                               return Dialog(
    //                                 shape: RoundedRectangleBorder(
    //                                     borderRadius:
    //                                     BorderRadius.circular(20.0)), //this right here
    //                                 child: Container(
    //                                   height: 200,
    //                                   child: Padding(
    //                                     padding: const EdgeInsets.all(12.0),
    //                                     child: Column(
    //                                       mainAxisAlignment: MainAxisAlignment.center,
    //                                       crossAxisAlignment: CrossAxisAlignment.center,
    //                                       children: [
    //                                         TextField(
    //                                           decoration: InputDecoration(
    //                                               border: InputBorder.none,
    //                                               hintText: 'Cập nhật tài khoản thành công!'),
    //                                         ),
    //                                         SizedBox(
    //                                           width: 270.0,
    //                                           child: RaisedButton(
    //                                             onPressed: () {
    //                                               Navigator.pop(context, false);
    //                                               // setState(() {});
    //                                               // _controllerSerial.clear();
    //                                               // _controllerSerial.text=null;
    //                                               // _controllerName.clear();
    //                                               // _controllerPhone.clear();
    //                                               // _controllerAddress.clear();
    //                                               // _controllerDistrict.clear();
    //                                               // _controllerDistrict.text=null;
    //                                               // _controllerTinh.clear();
    //                                             },
    //                                             child: Text(
    //                                               "OK",
    //                                               style: TextStyle(color: Colors.white),
    //                                             ),
    //                                             color: const Color(0xFF1BC0C5),
    //                                           ),
    //                                         )
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ),
    //                               );
    //                             });
    //                           } else {
    //                             _scaffoldState.currentState.showSnackBar(const SnackBar(content: Text("Cập nhật thất bại"),
    //                             ));
    //                           }
    //                         });
    //                       }
    //                     },
    //                     // child: Colors.teal[800],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           _isLoading
    //               ? Stack(
    //             children: const <Widget>[
    //               Opacity(
    //                 opacity: 0.3,
    //                 child: ModalBarrier(
    //                   dismissible: false,
    //                   color: Colors.grey,
    //                 ),
    //               ),
    //               Center(
    //                 child: CircularProgressIndicator(),
    //               ),
    //             ],
    //           )
    //               : Container(),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget _buildRadio() {
    return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text(
                      'Tài khoản:'
                    style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Spacer(),
                  Text('Khách hàng'),
                  Radio(
                    value: 1,
                    groupValue: _radioSelected,
                    activeColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {
                        _radioSelected = value;
                        _radioVal = 'khach';
                      });
                    },
                  ),
                  Text('Shipper'),
                  Radio(
                    value: 2,
                    groupValue: _radioSelected,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      setState(() {
                        _radioSelected = value;
                        _radioVal = 'ship';
                      });
                    },
                  )
                ],
              );
  }

  Widget _buildTextFieldUsername() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: TextField(
        controller: _controllerUsername,
        readOnly: (widget.profile != null) ? true : false,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Tên đăng nhập",
          border: OutlineInputBorder(),
          errorText: _isFieldUsernameValid == null || _isFieldUsernameValid
              ? null
              : "Vui lòng nhập tên đăng nhập",
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldUsernameValid) {
            setState(() => _isFieldUsernameValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildTextFieldPassword() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: TextField(
        controller: _controllerBank,
        keyboardType: TextInputType.text,
        obscureText:true,
        readOnly: (widget.profile != null) ? true : false,
        decoration: InputDecoration(
          labelText: "Mật khẩu",
          border: OutlineInputBorder(),
          errorText: _isFieldBankValid == null || _isFieldBankValid
              ? null
              : "Vui lòng nhập mật khẩu",
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldBankValid) {
            setState(() => _isFieldBankValid = isFieldValid);
          }
        },
      ),
    );
  }

  // Widget _buildTextFieldFullname() {
  //   return Padding(
  //     padding: const EdgeInsets.all(6),
  //     child: TextField(
  //       controller: _controllerName,
  //       keyboardType: TextInputType.text,
  //       decoration: InputDecoration(
  //         labelText: "Họ và tên",
  //         border: OutlineInputBorder(),
  //         errorText: _isFieldNameValid == null || _isFieldNameValid
  //             ? null
  //             : "Full name is required",
  //       ),
  //       onChanged: (value) {
  //         bool isFieldValid = value.trim().isNotEmpty;
  //         if (isFieldValid != _isFieldNameValid) {
  //           setState(() => _isFieldNameValid = isFieldValid);
  //         }
  //       },
  //     ),
  //   );
  // }

  Widget _buildTextFieldName() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: TextField(
        controller: _controllerName,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Họ và tên",
          border: OutlineInputBorder(),
          errorText: _isFieldNameValid == null || _isFieldNameValid
              ? null
              : "Vui lòng nhập họ và tên",
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldNameValid) {
            setState(() => _isFieldNameValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildTextFieldPhone() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: TextField(
        controller: _controllerPhone,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Điện thoại",
          border: OutlineInputBorder(),
          errorText: _isFieldPhoneValid == null || _isFieldPhoneValid
              ? null
              : "Vui lòng nhập điện thoại",
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldPhoneValid) {
            setState(() => _isFieldPhoneValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildTextFieldEmail() {
    return Flexible(
      child: Padding(
        // padding: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.all(6),
        child: TextField(
          controller: _controllerEmail,
          readOnly: (widget.profile != null) ? true : false,//neu email = '' khong the edit
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: "Email",
            border: OutlineInputBorder(),
            errorText: _isFieldEmailValid == null || _isFieldEmailValid
                ? null
                : "Vui lòng nhập Email",
          ),
          onChanged: (value) {
            bool isFieldValid = value.trim().isNotEmpty;
            if (isFieldValid != _isFieldEmailValid) {
              setState(() => _isFieldEmailValid = isFieldValid);
            }
          },
        ),
      ),
    );
  }

  Widget _buildTextFieldAddress() {
    return Flexible(
      child: Padding(
        // padding: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.all(6),
        child: TextField(
          controller: _controllerAddress,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Địa chỉ, quận/huyện",
            border: OutlineInputBorder(),
            errorText: _isFieldAddressValid == null || _isFieldAddressValid
                ? null
                : "Vui lòng nhập địa chỉ",
          ),
          onChanged: (value) {
            bool isFieldValid = value.trim().isNotEmpty;
            if (isFieldValid != _isFieldAddressValid) {
              setState(() => _isFieldAddressValid = isFieldValid);
            }
          },
        ),
      ),
    );
  }


  Widget _buildTinh() {
    return Flexible(
      child: Padding(
        // padding: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.all(6),
        child: DropdownSearch<TinhModel>(
          items: const [
            // TinhModel(name: "Vui long chon", id: 0),
            // TinhModel(name: "Vui long chon 2", id: 99999)
          ],
          maxHeight: 500,
          onFind: (String filter) => getDataQuan(filter),
          dropdownSearchDecoration: const InputDecoration(
            labelText: "Chọn Thành phố/ Huyện",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(6, 6, 0, 0),
          ),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (u) => u == null ? "Phải chọn Thành phố/ Huyện " : null,
          onChanged: (TinhModel) {
            _controllerTinh.text = TinhModel.id.toString();
            tinhtinhtinh = TinhModel.id.toString();
            // setState(() => _isFieldTinhValid = true);
            setState(() {
              _isFieldTinhValid = true;
              _isFieldQuanValid = false;
              selectedQuan = QuanModel(name: "Chọn Phường/ Xã", id: 0);
            });
          },
          showSearchBox: true,
        ),
      ),
    );
  }

  Widget _buildQuan() {
    return Flexible(
      child: Padding(
        // padding: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.all(6),
        child: DropdownSearch<QuanModel>(
          selectedItem: selectedQuan,
          // items: const [
          //   // TinhModel(name: "Vui long chon", id: 0),
          //   // TinhModel(name: "Vui long chon 2", id: 99999)
          // ],
          maxHeight: 500,
          onFind: (String filter) => getDataPhuong(filter,tinhtinhtinh),
          dropdownSearchDecoration: const InputDecoration(
            labelText: "Chọn Phường/ Xã",
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(6, 6, 0, 0),
          ),
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (u) => u == null ? "Phường/ Xã" : null,
          onChanged: (QuanModel) {
            _controllerQuan.text = QuanModel.id.toString();
            setState(() => _isFieldQuanValid = true);
          },
          showSearchBox: true,
        ),
      ),
    );
  }

  Future<List<ProvinceModel>> getDataX(filter) async {
    List<ProvinceModel> searchcities = cities.where((e) =>
    (e.text.toLowerCase().contains(filter.toLowerCase()))).toList();
    return searchcities;
  }

  // Future<List<TinhModel>> getData(filter) async {
  //   var response = await Dio().get(
  //     "https://gtnexpress.vn/api/get_tinh_thanh",
  //     queryParameters: {"filter": filter},
  //   );
  //
  //   final data = response.data;
  //   if (data != null) {
  //     return TinhModel.fromJsonList(data);
  //   }
  //
  //   return [];
  // }
  Future<List<TinhModel>> getDataQuan(filter) async {
    var response = await Dio().get(
      "https://gtnexpress.vn/api/get_quan",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    if (data != null) {
      return TinhModel.fromJsonList(data);
    }

    return [];
  }
  Future<List<QuanModel>> getDataPhuong(filter,tinhtinhtinh) async {
    var response = await Dio().get(
      "https://gtnexpress.vn/api/get_phuong?id_quan=${tinhtinhtinh}",
      queryParameters: {"filter": filter},
    );

    final data = response.data;
    if (data != null) {
      return QuanModel.fromJsonList(data);
    }

    return [];
  }

}


class FormPassScreen extends StatefulWidget {
  // AccountModel profile;
  FormPassScreen({Key key}) : super(key: key);

  @override
  _FormPassScreenState createState() => _FormPassScreenState();
}
class _FormPassScreenState extends State<FormPassScreen> {
  final GlobalKey<ScaffoldState> _scaffoldStateX = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  bool _isFieldUsernameValid;
  bool _isFieldBankValid;//pass
  bool _isFieldNameValid;

  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerBank = TextEditingController();

  @override
  void initState() {
    // if (widget.profile != null) {
    //   _isFieldNameValid = true;
    // }
    super.initState();
  }

  _showDialog(String result) async {
    // flutter defined function
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return  CupertinoAlertDialog(
          title: Text("Serial: ${result}"),
          actions: [
            CupertinoDialogAction(onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop('${result}');
            }, child: Text("OK")),
            CupertinoDialogAction(onPressed: () async {
              setState(() {
                result = null;
              });
              // await controller?.resumeCamera();
              Navigator.of(context, rootNavigator: true).pop(false);
            }, child: Text("Quét lại")),
          ],
          content: Text(""),
        );
      },
    );
  }

  void showAlertx() {
    // AlertDialog(
    //   title: Text('TH01AC21058asd'),
    //   actions: [
    //     TextButton(
    //       // onPressed: (_) => Navigator.pop(context, true), // passing true
    //       // onPressed: () => Navigator.of(context).pop(result),
    //       // onPressed: () async {
    //       //   // await controller?.pauseCamera();
    //       //   // Navigator.of(context).pop("TH02TV210120");
    //       // },
    //       onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
    //       child: const Text('OK True'),
    //     ),
    //     TextButton(
    //       // onPressed: () => Navigator.pop(context, false),
    //       onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
    //
    //       // onPressed: () async {
    //       //   await controller?.resumeCamera();
    //       //   result = null;
    //       // },
    //       child: const Text('Quét lại pop false',style: TextStyle(color: Colors.red)),
    //     ),
    //   ],
    // );
    showDialog(context: context,builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(20.0)), //this right here
        child: Container(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Cập nhật tài khoản thành công!'),
                ),
                SizedBox(
                  width: 270.0,
                  child: RaisedButton(
                    onPressed: () {
                      // setState(() {
                      //   widget.profile.fullName = profile.name;
                      //   widget.profile.phoneNo = profile.phone;
                      //   widget.profile.address = profile.address;
                      //   widget.profile.city = profile.tinh;
                      //   _controllerName.text = profile.name;//widget.profile.fullName;
                      //   _controllerPhone.text = profile.phone;
                      //   _controllerAddress.text = profile.address;
                      //   _controllerTinh.text= profile.tinh;
                      // });
                      Navigator.pop(context, false);
                      // Navigator.pop(_scaffoldStateX.currentState.context,true);
                      // setState(() {});
                      // _controllerSerial.clear();
                      // _controllerSerial.text=null;
                      // _controllerName.clear();
                      // _controllerPhone.clear();
                      // _controllerAddress.clear();
                      // _controllerDistrict.clear();
                      // _controllerDistrict.text=null;
                      // _controllerTinh.clear();
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(0xFF1BC0C5),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Đổi mật khẩu",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      key: _scaffoldStateX,
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Padding(padding: const EdgeInsets.only(top: 15.0),),
                      _buildTextFieldUsername(),
                      _buildTextFieldPassword(),
                      _buildTextFieldName(),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ElevatedButton(
                          child: Text(
                            "Đổi mật khẩu",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            if (_isFieldUsernameValid == null ||
                                _isFieldNameValid == null ||
                                _isFieldBankValid == null ||
                                !_isFieldUsernameValid ||
                                !_isFieldNameValid ||
                                !_isFieldBankValid
                            ) {
                              _scaffoldStateX.currentState.showSnackBar(
                                const SnackBar(
                                  content: Text("Vui lòng nhập thông tin",),
                                  // content: Text("Please fill all field",textAlign: TextAlign.center),
                                  backgroundColor: Colors.deepOrange,
                                ),
                              );
                              return;
                            }
                            if (_controllerName.text != _controllerBank.text){
                              _scaffoldStateX.currentState.showSnackBar(
                                const SnackBar(
                                  content: Text("Mật khẩu không khớp",),
                                  // content: Text("Please fill all field",textAlign: TextAlign.center),
                                  backgroundColor: Colors.deepOrange,
                                ),
                              );
                              return;
                            }
                            setState(() => _isLoading = true);
                            Profile profile = Profile(
                                username: _controllerUsername.text.toString(),
                                name: _controllerName.text.toString(),
                                nganhang: _controllerBank.text.toString()
                            );
                            _apiService.changepassAccount(profile).then((isSuccess) {
                              setState(() => _isLoading = false);
                              if (isSuccess == "success"){
                                // globals["password"] = _controllerName.text.toString();
                                Navigator.pop(_scaffoldStateX.currentState.context);
                                showDialog(context: context,builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20.0)), //this right here
                                    child:SingleChildScrollView(
                                      child: Container(
                                        // height: MediaQuery.of(context).size.height * 0.6,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(height: 12,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: const[
                                                  Text(
                                                    'Đổi mật khẩu thành công!',
                                                    style: TextStyle(fontSize: 16,color:  const Color(0xFF1BC0C5),),
                                                    softWrap: true,
                                                    maxLines: 20,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 12,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  RaisedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "OK",
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                    color: const Color(0xFF1BC0C5),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                });
                              } else {
                                _scaffoldStateX.currentState.showSnackBar( SnackBar(
                                  backgroundColor: Colors.deepOrange,
                                  content: Text(isSuccess.toString(),textAlign: TextAlign.center,),
                                ));
                              }
                            });
                          },
                          // child: Colors.teal[800],
                        ),
                      ),
                      _isLoading ? CircularProgressIndicator(): Container(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextFieldUsername() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: TextField(
        controller: _controllerUsername,
        keyboardType: TextInputType.text,
        obscureText:true,
        decoration: InputDecoration(
          labelText: "Mật khẩu hiện tại",
          border: OutlineInputBorder(),
          errorText: _isFieldUsernameValid == null || _isFieldUsernameValid
              ? null
              : "Nhập mật khẩu hiện tại",
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldUsernameValid) {
            setState(() => _isFieldUsernameValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildTextFieldPassword() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: TextField(
        controller: _controllerBank,
        keyboardType: TextInputType.text,
        obscureText:true,
        decoration: InputDecoration(
          labelText: "Mật khẩu mới",
          border: OutlineInputBorder(),
          errorText: _isFieldBankValid == null || _isFieldBankValid
              ? null
              : "Vui lòng nhập mật khẩu mới",
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldBankValid) {
            setState(() => _isFieldBankValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildTextFieldName() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: TextField(
        controller: _controllerName,
        keyboardType: TextInputType.text,
        obscureText:true,
        decoration: InputDecoration(
          labelText: "Xác nhận mật khẩu",
          border: OutlineInputBorder(),
          errorText: _isFieldNameValid == null || _isFieldNameValid
              ? null
              : "Vui lòng nhập mật khẩu mới",
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldNameValid) {
            setState(() => _isFieldNameValid = isFieldValid);
          }
        },
      ),
    );
  }
}


class AccountModel {
  // List<String> roles;
  String roles;
  String userName;
  String fullName;
  String address;
  String city;
  String email;
  String phoneNo;
  dynamic organizationId;
  String active;
  String id;

  AccountModel({
    this.roles,
    this.userName,
    this.fullName,
    this.address,
    this.city,
    this.email,
    this.phoneNo,
    this.organizationId,
    this.active,
    this.id,
  });

  factory AccountModel.fromRawJson(String str) => AccountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
    // roles: List<String>.from(json["roles"].map((x) => x)),
    roles: json["roles"],
    userName: json["username"],
    fullName: json["name"],
    address: json["address"],
    city: json["quan"],//cap1-quan
    email: json["email"],
    phoneNo: json["phone"],
    organizationId: json["phuong"],//cap2-phuong
    active: json["active"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    // "roles": List<dynamic>.from(roles.map((x) => x)),
    "roles": roles,
    "userName": userName,
    "fullName": fullName,
    "address": address,
    "city": city,
    "email": email,
    "phoneNo": phoneNo,
    "organizationId": organizationId,
    "active": active,
    "id": id,
  };
}
List<AccountModel> accountFromJson(String jsonData) {
  // final data = json.decode(jsonData)['data'];
  final data = json.decode(jsonData);
  return List<AccountModel>.from(data.map((item) => AccountModel.fromJson(item)));
}


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  BuildContext context;
  ApiService apiService;
  TextEditingController _controllerBank = TextEditingController();
  bool _isFieldBankValid;

  // for TextEditingController dispose:
  // @override
  // void dispose() {
  //   /* Discards any resources used by the object. After this is called,
  //   the object is not in a usable state and should be discarded
  //   (calls to addListener will throw after the object is disposed) */
  //   _controllerBank.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    _controllerBank.text = "";
    apiService = ApiService();
  }

  final List<ProvinceModel> cities = [
    ProvinceModel(id: "01", text: "Hà Nội"),
    ProvinceModel(id: "02", text: "Hà Giang"),
    ProvinceModel(id: "04", text: "Cao Bằng"),
    ProvinceModel(id: "06", text: "Bắc Kạn"),
    ProvinceModel(id: "08", text: "Tuyên Quang"),
    ProvinceModel(id: "10", text: "Lào Cai"),
    ProvinceModel(id: "11", text: "Điện Biên"),
    ProvinceModel(id: "12", text: "Lai Châu"),
    ProvinceModel(id: "14", text: "Sơn La"),
    ProvinceModel(id: "15", text: "Yên Bái"),
    ProvinceModel(id: "17", text: "Hoà Bình"),
    ProvinceModel(id: "19", text: "Thái Nguyên"),
    ProvinceModel(id: "20", text: "Lạng Sơn"),
    ProvinceModel(id: "22", text: "Quảng Ninh"),
    ProvinceModel(id: "24", text: "Bắc Giang"),
    ProvinceModel(id: "25", text: "Phú Thọ"),
    ProvinceModel(id: "26", text: "Vĩnh Phúc"),
    ProvinceModel(id: "27", text: "Bắc Ninh"),
    ProvinceModel(id: "30", text: "Hải Dương"),
    ProvinceModel(id: "31", text: "Hải Phòng"),
    ProvinceModel(id: "33", text: "Hưng Yên"),
    ProvinceModel(id: "34", text: "Thái Bình"),
    ProvinceModel(id: "35", text: "Hà Nam"),
    ProvinceModel(id: "36", text: "Nam Định"),
    ProvinceModel(id: "37", text: "Ninh Bình"),
    ProvinceModel(id: "38", text: "Thanh Hóa"),
    ProvinceModel(id: "40", text: "Nghệ An"),
    ProvinceModel(id: "42", text: "Hà Tĩnh"),
    ProvinceModel(id: "44", text: "Quảng Bình"),
    ProvinceModel(id: "45", text: "Quảng Trị"),
    ProvinceModel(id: "46", text: "Thừa Thiên Huế"),
    ProvinceModel(id: "48", text: "Đà Nẵng"),
    ProvinceModel(id: "49", text: "Quảng Nam"),
    ProvinceModel(id: "51", text: "Quảng Ngãi"),
    ProvinceModel(id: "52", text: "Bình Định"),
    ProvinceModel(id: "54", text: "Phú Yên"),
    ProvinceModel(id: "56", text: "Khánh Hòa"),
    ProvinceModel(id: "58", text: "Ninh Thuận"),
    ProvinceModel(id: "60", text: "Bình Thuận"),
    ProvinceModel(id: "62", text: "Kon Tum"),
    ProvinceModel(id: "64", text: "Gia Lai"),
    ProvinceModel(id: "66", text: "Đắk Lắk"),
    ProvinceModel(id: "67", text: "Đắk Nông"),
    ProvinceModel(id: "68", text: "Lâm Đồng"),
    ProvinceModel(id: "70", text: "Bình Phước"),
    ProvinceModel(id: "72", text: "Tây Ninh"),
    ProvinceModel(id: "74", text: "Bình Dương"),
    ProvinceModel(id: "75", text: "Đồng Nai"),
    ProvinceModel(id: "77", text: "Bà Rịa - Vũng Tàu"),
    ProvinceModel(id: "79", text: "Hồ Chí Minh"),
    ProvinceModel(id: "80", text: "Long An"),
    ProvinceModel(id: "82", text: "Tiền Giang"),
    ProvinceModel(id: "83", text: "Bến Tre"),
    ProvinceModel(id: "84", text: "Trà Vinh"),
    ProvinceModel(id: "86", text: "Vĩnh Long"),
    ProvinceModel(id: "87", text: "Đồng Tháp"),
    ProvinceModel(id: "89", text: "An Giang"),
    ProvinceModel(id: "91", text: "Kiên Giang"),
    ProvinceModel(id: "92", text: "Cần Thơ"),
    ProvinceModel(id: "93", text: "Hậu Giang"),
    ProvinceModel(id: "94", text: "Sóc Trăng"),
    ProvinceModel(id: "95", text: "Bạc Liêu"),
    ProvinceModel(id: "96", text: "Cà Mau"),
  ];


  final _scaffoldKeyPopup = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      key: _scaffoldKeyPopup,
      appBar: AppBar(
        title: const Text('Tài khoản'),
      ),
      body: FutureBuilder(
        future: apiService.getProfiles(),
        builder: (BuildContext context, AsyncSnapshot<List<AccountModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<AccountModel> profiles = snapshot.data;
            return _buildListView(profiles);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );

    // return SafeArea(
    //   child: FutureBuilder(
    //     future: apiService.getProfiles(),
    //     builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
    //       if (snapshot.hasError) {
    //         return Center(
    //           child: Text(
    //               "Something wrong with message: ${snapshot.error.toString()}"),
    //         );
    //       } else if (snapshot.connectionState == ConnectionState.done) {
    //         List<Profile> profiles = snapshot.data;
    //         return _buildListView(profiles);
    //       } else {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //   ),
    // );
  }

  Widget _buildListView(List<AccountModel> profiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          AccountModel profile = profiles[index];
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Tên đăng nhập: ${profile.userName??""}',
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                            maxLines: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Họ và tên: ${profile.fullName??""}',
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                            maxLines: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Điện thoại: ${profile.phoneNo??""}',
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                            maxLines: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Email: ${profile.email??""}',
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                            maxLines: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Địa chỉ: ${profile.address??""}',
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                            maxLines: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            // "Tỉnh thành: ${(profile.city !=null && profile.city != '') ? cities.firstWhere((city) => city.id == profile.city): ''}",
                            "${profile.organizationId}, ${profile.city}, Tỉnh Kon Tum",
                            style: TextStyle(fontSize: 16),
                            softWrap: true,
                            maxLines: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0,),
                  // Text(
                  //   "Tên đăng nhập: ${profile.userName}",
                  //   // style: Theme.of(context).textTheme.title,
                  // ),

                  // Text("Tỉnh thành: ${(profile.city !=null && profile.city != '') ? cities.firstWhere((city) => city.id == profile.city): ''}"),


                  // Text(profile.age.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.grey[100],
                          onPrimary: Colors.red,
                          shadowColor: Colors.blueGrey,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: Size(30, 35),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0)), //this right here
                                  child:SingleChildScrollView(
                                    child: Container(
                                      // height: MediaQuery.of(context).size.height * 0.6,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // SizedBox(
                                            //   width: 150.0,
                                            //   child: RaisedButton(
                                            //     onPressed: () {},
                                            //     child: Text(
                                            //       "WARNING",
                                            //       style: TextStyle(color: Colors.white),
                                            //     ),
                                            //     color: const Color(0xFFE10653),
                                            //   ),
                                            // ),
                                            // TextField(
                                            //   decoration: InputDecoration(
                                            //       border: InputBorder.none,
                                            //       hintText: 'What do you want?'),
                                            // ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const[
                                                Text(
                                                  'CẢNH BÁO',
                                                  style: TextStyle(fontSize: 16,color: Color(0xFFE10653),),
                                                  softWrap: true,
                                                  maxLines: 20,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              children: const[
                                                Expanded(
                                                  child: Text(
                                                    '- Xóa tài khoản của bạn là vĩnh viễn và không thể hoàn tác.',
                                                    style: TextStyle(fontSize: 16),
                                                    softWrap: true,
                                                    maxLines: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              children: const[
                                                Expanded(
                                                  child: Text(
                                                    '- Xóa tài khoản sẽ ngăn bạn truy cập "GTNExpress" bao gồm website & App.',
                                                    style: TextStyle(fontSize: 16),
                                                    softWrap: true,
                                                    maxLines: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              children: const[
                                                Expanded(
                                                  child: Text(
                                                    '- Bạn không thể tạo tài khoản mới bằng cùng một địa chỉ email.',
                                                    style: TextStyle(fontSize: 16),
                                                    softWrap: true,
                                                    maxLines: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              children: const[
                                                Expanded(
                                                  child: Text(
                                                    '- Dữ liệu của bạn sẽ bị xóa trong vòng 30 ngày.',
                                                    style: TextStyle(fontSize: 16),
                                                    softWrap: true,
                                                    maxLines: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 12,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 200.0,
                                                  height: 35.0,
                                                  child: TextField(
                                                    controller: _controllerBank,
                                                    keyboardType: TextInputType.text,
                                                    obscureText:true,
                                                    decoration: InputDecoration(
                                                      labelText: "Mật khẩu",
                                                      border: OutlineInputBorder(),
                                                      errorText: _isFieldBankValid == null || _isFieldBankValid
                                                          ? null
                                                          : "Vui lòng nhập mật khẩu",
                                                    ),
                                                    onChanged: (value) {
                                                      bool isFieldValid = value.trim().isNotEmpty;
                                                      if (isFieldValid != _isFieldBankValid) {
                                                        setState(() => _isFieldBankValid = isFieldValid);
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 12,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                RaisedButton(
                                                  onPressed: () {
                                                    if(globals["password"]==_controllerBank.text) {
                                                      apiService.deleteAccount(
                                                          profile.userName).then((
                                                          isSuccess) {
                                                        if (isSuccess) {
                                                          Navigator.pop(context);
                                                          _scaffoldKeyPopup.currentState.showSnackBar(
                                                          // Scaffold.of(this.context).showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      "Xóa tài khoản thành công"))
                                                          );
                                                          showDialog(
                                                              context: context,
                                                              builder: (
                                                                  BuildContext context) {
                                                                return Dialog(
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          20.0)),
                                                                  //this right here
                                                                  child: Container(
                                                                    height: 200,
                                                                    child: Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          12.0),
                                                                      child: Column(
                                                                        mainAxisAlignment: MainAxisAlignment
                                                                            .center,
                                                                        crossAxisAlignment: CrossAxisAlignment
                                                                            .start,
                                                                        children: [
                                                                          TextField(
                                                                            decoration: InputDecoration(
                                                                                border: InputBorder
                                                                                    .none,
                                                                                hintText: 'Xóa tài khoản thành công'),
                                                                          ),
                                                                          SizedBox(
                                                                            width: 320.0,
                                                                            child: RaisedButton(
                                                                              onPressed: () {
                                                                                Navigator
                                                                                    .pop(
                                                                                    context);
                                                                              },
                                                                              child: Text(
                                                                                "OK",
                                                                                style: TextStyle(
                                                                                    color: Colors
                                                                                        .white),
                                                                              ),
                                                                              color: const Color(
                                                                                  0xFF1BC0C5),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              });
                                                          // BlocProvider.of<
                                                          //     AuthenticationBloc>(
                                                          //     context).add(
                                                          //     LoggedOut());
                                                          BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                                                        } else {
                                                          //Scaffold.of(this.context).showSnackBar(
                                                          _scaffoldKeyPopup.currentState.showSnackBar(
                                                              SnackBar(
                                                                  content: Text(
                                                                      "Xóa tài khoản không thành công")));
                                                        }
                                                      });
                                                    } else {
                                                      Scaffold.of(
                                                          this.context)
                                                          .showSnackBar(
                                                          SnackBar(
                                                              content: Text(
                                                                  "Mật khẩu không đúng")));
                                                    }
                                                  },
                                                  child: Text(
                                                    "Xóa tài khoản",
                                                    style: TextStyle(color: Colors.black),
                                                  ),
                                                  color: const Color(0xFFEEEEEF),
                                                ),
                                                SizedBox(width:24,),
                                                RaisedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Hủy bỏ",
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  color: const Color(0xFF1BC0C5),
                                                ),
                                              ],
                                            ),


                                            // SizedBox(
                                            //   width: 150.0,
                                            //   child: RaisedButton(
                                            //     onPressed: () {},
                                            //     child: Text(
                                            //       "Cancel",
                                            //       style: TextStyle(color: Colors.white),
                                            //     ),
                                            //     color: const Color(0xFF1BC0C5),
                                            //   ),
                                            // )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });

                          // showDialog(
                          //     context: context,
                          //     builder: (context) {
                          //       return AlertDialog(
                          //         title: Text("Alert"),
                          //         content: Text("Are you sure want to delete data profile ${profile.userName}?"),
                          //         actions: <Widget>[
                          //           FlatButton(
                          //             child: Text("Yes Delete account"),
                          //             onPressed: () {
                          //               Navigator.pop(context);
                          //               apiService
                          //                   .deleteAccount(profile.userName)
                          //                   .then((isSuccess) {
                          //                       if (isSuccess) {
                          //                         setState(() {});
                          //                         Scaffold.of(this.context)
                          //                             .showSnackBar(SnackBar(
                          //                             content: Text(
                          //                                 "Delete data success")));
                          //                       } else {
                          //                         Scaffold.of(this.context)
                          //                             .showSnackBar(SnackBar(
                          //                             content: Text(
                          //                                 "Delete data failed")));
                          //                       }
                          //                       // ScaffoldMessenger.of(context).showSnackBar(
                          //                       //   SnackBar(
                          //                       //     content: Text(
                          //                       //       'Unable to favorite',
                          //                       //     ),
                          //                       //   ),
                          //                       // );
                          //               });
                          //             },
                          //           ),
                          //           FlatButton(
                          //             child: Text("No"),
                          //             onPressed: () {
                          //               Navigator.pop(context);
                          //             },
                          //           )
                          //         ],
                          //       );
                          // });
                        },
                        child: Text(
                          "Xóa tài khoản",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigoAccent[100],
                          onPrimary: Colors.red,
                          shadowColor: Colors.grey,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: Size(30, 35),
                        ),
                        onPressed: () async {
                          final datapass = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormRegister(profile: profile,),));
                          if (datapass == true) {
                            setState(() {});
                          }
                        },
                        child: Text(
                          "Cập nhật",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          onPrimary: Colors.white,
                          shadowColor: Colors.greenAccent,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: Size(30, 35),
                        ),
                        onPressed: () async {
                          final databack = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormPassScreen(),));
                          if (databack == true) {
                            setState(() {});
                          }
                        },
                        child: Text(
                          "Đổi mật khẩu",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: profiles.length,
      ),
    );
  }

}




class Debounce {
  Duration delay;
  Timer _timer;

  Debounce(
      this.delay,
      );

  call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(delay, callback);
  }

  dispose() {
    _timer?.cancel();
  }
}



class TrackQRScreen extends StatefulWidget {
  String barcode;
  Profile profile;

  TrackQRScreen({Key key, this.profile,this.barcode}) : super(key: key);

  @override
  _TrackQRScreenState createState() => _TrackQRScreenState();
}

class _TrackQRScreenState extends State<TrackQRScreen> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keynw = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _keyow = GlobalKey<FormFieldState>();
  ProvinceModel selecteditem;
  StatusModel selecteditemstatus;
  StatusModel selecteditemstatusowner;
  final ApiService _apiService = ApiService();

  String _isFieldSerialValidSearch = "MVĐ không hợp lệ";
  List<String> _isFieldSerialValidSearchReturn = [''];
  List<String> listbarcode = [];
  List<String> textbarcode = [];

  bool _isFieldSerialValid;
  bool _isFieldNameValid;
  bool _isFieldPhoneValid;
  bool _isFieldAddressValid;
  bool _isFieldDistrictValid;
  bool _isFieldTinhValid;
  bool _isFieldStatusValid;
  bool _isFieldOwnerValid;
  bool onPresseddisable;

  String tinh_res = "";
  String globalroles = globals["roles"];//${globals["username"]??""}

  final TextEditingController _controllerSerial = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerDistrict = TextEditingController();
  final TextEditingController _controllerTinh = TextEditingController();
  final TextEditingController _controllerOwner = TextEditingController();
  final TextEditingController _controllerStatus = TextEditingController();

  //1mới tạo,2đi nhận,3hủy,4đã nhận,13lưu kho,5đang giao,6chogiaolai,7đã giao,8cho tra,9đã trả,10chocod,11dacod,12hoantat,13lưu kho
  final List<ProvinceModel> cities = [
    ProvinceModel(id: "01", text: "Mới tạo"),
    ProvinceModel(id: "02", text: "Đi nhận"),
    // ProvinceModel(id: "03", text: "Hủy"),
    ProvinceModel(id: "04", text: "Đã nhận"),
    ProvinceModel(id: "05", text: "Đang giao"),
    ProvinceModel(id: "06", text: "Chờ xử lý"),
    ProvinceModel(id: "07", text: "Đã giao"),
    ProvinceModel(id: "08", text: "Chờ trả"),
    ProvinceModel(id: "09", text: "Đã trả hàng"),
    ProvinceModel(id: "10", text: "Chờ t/t"),
    ProvinceModel(id: "11", text: "Đã t/t"),
    // ProvinceModel(id: "12", text: "Hoàn tất"),
    ProvinceModel(id: "13", text: "Lưu kho"),
    // ProvinceModel(id: "14", text: "Đã chấp nhận"),
    // ProvinceModel(id: "15", text: "Cập nhật t/t"),
    // ProvinceModel(id: "16", text: "Đang bàn giao"),
  ];

  final Debounce _debounce = Debounce(Duration(milliseconds: 500));

  //Start image
  final HttpUploadService _httpUploadService = HttpUploadService();
  CameraDescription _cameraDescription;
  List<String> _images = [];
  String text="";
  // int _vdid=0;
  // @override
  // void initState() {
  //   super.initState();
  //   availableCameras().then((cameras) {
  //     final camera = cameras
  //         .where((camera) => camera.lensDirection == CameraLensDirection.back)
  //         .toList()
  //         .first;
  //     setState(() {
  //       _cameraDescription = camera;
  //       print(camera);
  //     });
  //   }).catchError((err) {
  //     print("err xxxxx ");
  //     print(err);
  //   });
  // }



  void get_grant_camera() async {
    var status = await Permission.camera.status;
    if(!status.isGranted){
      status = await Permission.camera.request();
      print("ask permission");
      print(status.isGranted);
      print("ask permission complete");
    }
    print("Do not have permission");
  }

  @override
  void dispose() {
    _debounce?.dispose;
    super.dispose();
    _controllerSerial.dispose();
    _controllerName.dispose();//#Nguoi PT
    _controllerPhone.dispose();//#Trang thai hien tai
    _controllerAddress.dispose();//#Ghi chu
    _controllerDistrict.dispose();
    _controllerTinh.dispose();//trangthai
    _controllerOwner.dispose();//trangthai
    _controllerStatus.dispose();//trangthai
  }

  @override
  void initState() {
    // if (widget.barcode != null) {
    //   _controllerSerial.text = widget.barcode;
    //   print("this is will showwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
    // }
    // if (widget.profile != null) {
    //   _isFieldNameValid = true;
    //   // _isFieldNameValidSearch = "so serial";
    //   _controllerName.text = widget.profile.name;
    //   // _isFieldEmailValid = true;
    //   _isFieldTinhValid = true;
    //   // _controllerEmail.text = widget.profile.email;
    //   // _isFieldAgeValid = true;
    //   // _controllerAge.text = widget.profile.age.toString();
    //   _controllerTinh.text = widget.profile.name;
    // }
    super.initState();
    get_grant_camera();
    _controllerDistrict.text= "";
    availableCameras().then((cameras) {
      final camera = cameras
          .where((camera) => camera.lensDirection == CameraLensDirection.back)
          .toList()
          .first;
      setState(() {
        _cameraDescription = camera;
        print(camera);
      });
    }).catchError((err) {
      print("err xxxxx2222 ");
      print(err);
    });
  }

  void _showDialog(String result) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        // return AlertDialog(
        //   // title: new Text("Alert Dialog title ${result}"),
        //   content: new Text("${result}"),
        //   actions: <Widget>[
        //     // usually buttons at the bottom of the dialog
        //     new FlatButton(
        //       child: new Text("Close"),
        //       onPressed: () {
        //         Navigator.of(context).pop();
        //       },
        //     ),
        //   ],
        // );
        return AlertDialog(
          title: Text('${result}'),
          actions: [
            // TextButton(
            //   onPressed: () async {
            //     Navigator.of(context).pop();
            //     // final qrCode = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => QRViewExample(),));
            //   },
            //   child: Text('Quet ma'),
            // ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK',style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal[100],
      key: _scaffoldState,
      // appBar: AppBar(
      //   iconTheme: const IconThemeData(color: Colors.white),
      //   title: Text(
      //     widget.profile == null ? "Kích hoạt bảo hành" : "Cập nhật bảo hành",
      //     style: const TextStyle(color: Colors.white),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildTextFieldSerial(),
            if (textbarcode.length>0) Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45)
              ),
              margin: const EdgeInsets.only(top:15,left:30,right:30,bottom:15),
              child: _buildListQrResult(),
            ),
            // _buildTextFieldName(),
            // _buildTextFieldPhone(),
            // _buildTinh(),
            // _buildTextFieldDistrict(),
            _buildOwner(),
            _buildTinhNetwork(),
            _buildTextFieldAddress(),
            _buildCamera(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                  ),
                  child:  Text(
                    " Chụp ảnh $text",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    final String imagePath =
                    await Navigator.of(context)
                        .push(MaterialPageRoute(
                        builder: (_) => TakePhoto(
                          camera: _cameraDescription,
                        )));
                    print('imagepath: $imagePath');
                    if (imagePath != null) {
                      setState(() {
                        _images = [];//xoa bo multi
                        _images.add(imagePath);
                      });
                    }
                  },
                ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
                    ),
                    child:  Text(
                      " CLEAR ".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _controllerSerial.clear();
                        _controllerSerial.text=null;
                        _controllerName.clear();
                        _controllerPhone.clear();
                        _controllerAddress.clear();
                        _controllerDistrict.clear();
                        _controllerDistrict.text=null;
                        _controllerTinh.clear();
                        selecteditem = null;
                        selecteditemstatus = null;
                        selecteditemstatusowner = null;
                        _key.currentState?.reset();
                        // bool isSelected=false;
                        _isFieldSerialValidSearch = "";
                        _isFieldSerialValidSearchReturn = [''];
                        //false all below
                        _isFieldSerialValid=_isFieldNameValid=_isFieldPhoneValid=_isFieldAddressValid=_isFieldDistrictValid=_isFieldTinhValid=_isFieldOwnerValid=_isFieldStatusValid = null;
                        //Reset image//_keyow;_keynw;.currentState?.reset();
                        _images = [];
                        textbarcode = [];
                        text = "";
                        _keynw.currentState?.reset();
                        _keyow.currentState?.reset();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    child:  Text(
                      widget.profile == null
                          ? "cập nhật ".toUpperCase()
                          : "Cập nhật".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      // print(_controllerSerial.text.toString());
                      //     print(_controllerName.text.toString());
                      // print(_controllerPhone.text.toString());
                      //     print(_controllerAddress.text.toString());
                      // print(_controllerDistrict.text.toString());
                      //     print(_controllerTinh.text.toString());
                      // print(_controllerOwner.text.toString());
                      //     print(_controllerStatus.text.toString());
                      if (
                          _isFieldStatusValid == null ||
                          !_isFieldStatusValid
                      ) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text(
                                "Vui lòng nhập đầy đủ thông tin",
                                textAlign: TextAlign.center
                            ),
                            // content: Text("Please fill all field",textAlign: TextAlign.center),
                            backgroundColor: Colors.deepOrange,
                            duration: Duration(seconds: 6),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String serial = _controllerSerial.text.toString()??"";
                      String name = _controllerName.text.toString();
                      String phone = _controllerPhone.text.toString();
                      String address = _controllerAddress.text.toString();
                      String quan = _controllerDistrict.text.toString();
                      String tinh = _controllerTinh.text.toString();
                      String owner = (_controllerOwner.text.toString()!="")?_controllerOwner.text.toString():globals["id"];
                      String status = _controllerStatus.text.toString();
                      // print("Check tinh here:::: ${_controllerTinh.text.toString()}::::::");
                      // Vandon profile = Vandon(
                      //   trackid: serial,
                      //   receiverName: name,
                      //   receiverPhone: phone,
                      //   senderDateCreate: address,
                      //   status: tinh,
                      // );
                      //Start upload image
                      if (_images.length > 0) {
                        setState(() {
                          text = " - uploading...";
                        });
                        // final showSecondDialog = await serverResult();
                        final responseDataHttp = await _httpUploadService
                            .uploadPhotos(_images);
                        if (responseDataHttp != null) {
                          setState(() {
                            text = " - upload success";
                            if(responseDataHttp != "error"){
                              quan = responseDataHttp;
                            } else {
                              quan = "";
                            }//image name
                          });
                          if (!mounted) return;
                          // await _showDialog(responseDataHttp);
                        } else {
                          quan = "";
                        }
                      }
                      Profile profile = Profile(
                        email:  ( textbarcode.length > 0) ? textbarcode.join(",") : serial,
                        name: owner,//owner
                        phone: status,//status
                        address: address,//note
                        username: quan,//image
                        tinh: tinh,//ko sai
                      );
                      print(profile.toString());
                      _apiService.createHanhtrinh(profile).then((List<String> isSuccess) {
                        setState(() => _isLoading = false);
                        print("isSuccessisSuccessisSuccessisSuccess ${isSuccess.toString()}");
                        if (isSuccess[0] != "") {
                            showDialog(barrierDismissible: true,context: context,builder: (BuildContext context)
                            {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20.0)),
                                  //this right here
                                  child:SingleChildScrollView(
                                    child: Container(
                                      // height: MediaQuery
                                      //     .of(context)
                                      //     .size
                                      //     .height * 0.4,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceEvenly,
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 8,),
                                            Text(
                                              "Kết quả: ",
                                              style: TextStyle(
                                                  color: Colors.deepPurple,fontSize: 16),
                                            ),
                                            SizedBox(height: 12,),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${isSuccess[0]}',
                                                    style: TextStyle(
                                                        fontSize: 14),
                                                    softWrap: true,
                                                    maxLines: 40,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 12,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                SizedBox(width: 24,),
                                                RaisedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _controllerSerial.clear();
                                                      _controllerSerial.text=null;
                                                      _controllerName.clear();
                                                      _controllerPhone.clear();
                                                      _controllerAddress.clear();
                                                      _controllerDistrict.clear();
                                                      _controllerDistrict.text=null;
                                                      _controllerTinh.clear();
                                                      _controllerOwner.clear();
                                                      _controllerStatus.clear();
                                                      selecteditem = null;
                                                      selecteditemstatus = null;
                                                      selecteditemstatusowner = null;
                                                      _key.currentState?.reset();
                                                      // bool isSelected=false;
                                                      _isFieldSerialValidSearch = "";
                                                      _isFieldSerialValidSearchReturn = [''];
                                                      //false all below
                                                      _isFieldSerialValid=_isFieldNameValid=_isFieldPhoneValid=_isFieldAddressValid=_isFieldDistrictValid=_isFieldTinhValid=_isFieldOwnerValid =_isFieldStatusValid = null;
                                                      //Reset image//_keyow;_keynw;.currentState?.reset();
                                                      _images = [];
                                                      textbarcode = [];
                                                      text = "";
                                                      _keynw.currentState?.reset();
                                                      _keyow.currentState?.reset();

                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "cập nhật tiếp",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  color: const Color(0xFF1BC0C5),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              );
                            });
                        }
                        else {
                          _scaffoldState.currentState.showSnackBar( SnackBar(
                            content: Text("Không thành công ${isSuccess[1].toString()}",textAlign: TextAlign.center,),
                          ));
                        }
                      });
                      // child: Colors.teal[800],
                    },
                  ),
                ),
              ],
            ),
            _isLoading ?  CircularProgressIndicator() : Container(),
          ],
        ),
      ),

    );
  }

  Widget _buildCamera(){
    return Column(
      children: [
        // Text('Send least two pictures', style: TextStyle(fontSize: 17.0)),
        // Padding(
        //   padding: const EdgeInsets.all(5.0),
        //   child: ElevatedButton(
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey),
        //     ),
        //     child:  Text(
        //       " Chụp ảnh $text",
        //       style: const TextStyle(
        //         color: Colors.white,
        //       ),
        //     ),
        //     onPressed: () async {
        //       final String imagePath =
        //       await Navigator.of(context)
        //           .push(MaterialPageRoute(
        //           builder: (_) => TakePhoto(
        //             camera: _cameraDescription,
        //           )));
        //       print('imagepath: $imagePath');
        //       if (imagePath != null) {
        //         setState(() {
        //           _images = [];//xoa bo multi
        //           _images.add(imagePath);
        //         });
        //       }
        //     },
        //   ),
        // ),
        // SizedBox(
        //   height: 10,
        // ),
        (_images.length >= 1) ? CardPicture(imagePath: _images[0]) : Text(""),
      ],
    );
  }

  Widget _buildListQrResult(){
    return ListView.builder(
        shrinkWrap: true,
        itemCount: textbarcode.length,
        itemBuilder: (context, index) {
          final item = textbarcode[index];
          return ListTile(
            title: Text("$item"),
            // subtitle: Text("Subtitle $index"),
            // leading: const Icon(Icons.qr_code),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    size: 20.0,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    if(textbarcode.length == 1){
                      setState(() {
                        _controllerSerial.text = "";
                        textbarcode.removeAt(index);
                      });
                    } else {
                      setState(() {
                        textbarcode.removeAt(index);
                      });
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$item đã xoá')));
                  },
                ),
              ],
            ),
          );
        }
    );
  }

  Widget _buildTextFieldSerial() {
    return Padding(
      // padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      padding: const EdgeInsets.only(top:26,left: 10,right: 10,bottom: 10),
      // padding: const EdgeInsets.all(16),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _controllerSerial,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    // final qrCode = await Navigator.pushNamed(context, "/qrScanner");
                    final qrCode = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => QRViewActive(),));
                    if (qrCode != 'null' && qrCode != null && qrCode.length>0){
                      setState(() {
                        // _isFieldSerialValidSearch = "Số máy không tồn tại!!";
                        // _isFieldSerialValidSearchReturn = ["Modal:","",""];
                        _isFieldSerialValid = true;
                        _controllerSerial.text = qrCode[4];
                        textbarcode = qrCode[5];
                        // Navigator.of(context).pop([textespro,"","",textxk,result.code]);
                        _isFieldSerialValidSearchReturn = [qrCode[0], "Chưa kích hoạt",qrCode[5].join(","),qrCode[3]];
                      });
                    }
                  },
                  icon: Icon(Icons.document_scanner_sharp),
                  // icon: Icon(Icons.calendar_view_week),
                ),
                labelText: "Mã vận đơn",
                border: OutlineInputBorder(),
                errorText: _isFieldSerialValid == null || _isFieldSerialValid ? null : _isFieldSerialValidSearch.toString(),
              ),
              onChanged: (value) {
                print('${DateTime.now()} Start Value is 1 $value');
                // _debounce((){
                //   print('${DateTime.now().second} Value is 1 $value');
                // });
                // _debounce((){
                //   print('${DateTime.now().second} Value is 2 $value');
                // });
                // // print('Value is: $value');
                // _debounce((){ print('First'); });
                // _debounce((){ print('Second'); });
                _debounce((){

                  print('${DateTime.now().second} END Third');

                  if (value.trim().isNotEmpty && value.trim().length < 12) {
                    print("<10 ");
                    setState(() => _isFieldSerialValidSearch = "MVĐ không hợp lệ");
                    setState(() => _isFieldSerialValid = false);
                    setState(() => _isFieldSerialValidSearchReturn = [''] );
                  }
                  if (value.trim().isNotEmpty && value.trim().length >= 13 ) {
                    print("check checkSerial ");
                    _apiService.checkSerial(value).then((List<String> isSuccess) {
                      print("input check================================${isSuccess}");
                      if (isSuccess.length == 1) { //not found
                        setState(() => _isFieldSerialValid = false);
                        setState(() => _isFieldSerialValidSearchReturn = isSuccess );
                      } else if (isSuccess.length >= 2) { //found
                          String tmpmvd = isSuccess[0].toString()+' - ' + isSuccess[3].toString() + ' - ' + isSuccess[2].toString();
                          if (!textbarcode.contains(tmpmvd)) {
                            setState(() {
                              textbarcode.add(tmpmvd);
                              _isFieldSerialValid = true;
                              _isFieldSerialValidSearch = "";
                              _isFieldSerialValidSearchReturn = isSuccess;
                              // _vdid = int.parse(isSuccess.last) ?? 0;
                            });
                          } else {
                            setState(() {
                              _isFieldSerialValidSearchReturn = ["Đã có trong danh sách"];
                            });
                          }
                          // setState(() => _isFieldSerialValid = true);
                          // setState(() => _isFieldSerialValidSearch = "" );
                          // setState(() => _isFieldSerialValidSearchReturn = isSuccess );
                          // setState(() => _vdid = int.parse(isSuccess.last) ?? 0);
                        // }
                      } else { //network error
                        setState(() {
                          _isFieldSerialValidSearch = "Mã vận đơn không tồn tại. No connection!";
                          _isFieldSerialValidSearchReturn = ["Mã vận đơn không tồn tại!!! No connection!"];
                          _isFieldSerialValid = false;
                        });
                      }
                    });
                    print("done checkSerial");
                  }

                });

              },
            ),
            if (_isFieldSerialValidSearchReturn.length==1) Container(//json => 400 Khong tim thay
              // padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  text:'${ _isFieldSerialValidSearchReturn[0].toString()}\n',
                  style: TextStyle(color: Colors.black, fontSize: 14,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]
      ),
    );
  }

  Widget _buildTextFieldAddress() {
    return Padding(
      // padding: const EdgeInsets.only(right: 2),
      padding: const EdgeInsets.all(10),
      child: TextField(
        // readOnly: (onPresseddisable!= null && onPresseddisable) ? true : false,
        controller: _controllerAddress,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: "Ghi chú",
          border: OutlineInputBorder(),
          // errorText: _isFieldAddressValid == null || _isFieldAddressValid
          //     ? null
          //     : "Cần nhập ghi chú",
        ),
        onChanged: (value) {
          bool isFieldValid = value.trim().isNotEmpty;
          if (isFieldValid != _isFieldAddressValid) {
            setState(() => _isFieldAddressValid = isFieldValid);
          }
        },
      ),
    );
  }

  Widget _buildOwner() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DropdownSearch<StatusModel>(
        key: _keyow,
        // items: const [
        //   // TinhModel(name: "Vui long chon", id: 0),
        //   // TinhModel("name": "nama", "id": "99999"),
        // ],
        // maxHeight: 700,
        // onFind: (String filter) => getDataX(filter),
        // items: cities,
        // onFind: (String filter) => getDataPhuong(filter,tinhtinhtinh),
        onFind: (String filter) => getDataPT(filter),
        dropdownSearchDecoration: const InputDecoration(
          labelText: "Chọn người phụ trách",
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(6, 6, 0, 0),
        ),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (u) => u == null ? "phải chọn người phụ trách" : null,
        onChanged:(StatusModel data) {
          _controllerOwner.text = data.id.toString();
          setState(() => _isFieldOwnerValid = true);
          setState(() {
            selecteditemstatusowner  = data;
            print(selecteditemstatusowner);
          });
        },
        showSearchBox: true,
        selectedItem: (globals["roles"]=="7") ? StatusModel(id: globals["id"],name: globals["username"]+' - '+globals["name"]) : null,
        enabled : true,
        // }
      ),
    );
  }

  Widget _buildTinhNetwork() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: DropdownSearch<StatusModel>(
        key: _keynw,
        // items: const [
        //   // TinhModel(name: "Vui long chon", id: 0),
        //   // TinhModel(name: "Vui long chon 2", id: 99999)
        // ],
        // maxHeight: 700,
        // onFind: (String filter) => getDataX(filter),
        // items: cities,
        // onFind: (String filter) => getDataPhuong(filter,tinhtinhtinh),
        onFind: (String filter) => getData(filter),
        dropdownSearchDecoration: const InputDecoration(
          labelText: "Chọn trạng thái",
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.fromLTRB(6, 6, 0, 0),
        ),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        // validator: (u) => u == null ? "phải chọn trạng thái" : null,
        onChanged:(StatusModel data) {
          _controllerStatus.text = data.id.toString();
          setState(() => _isFieldStatusValid = true);
          setState(() {
            selecteditemstatus = data;
          });
        },
        showSearchBox: true,
        selectedItem:  selecteditemstatus,
        enabled : true,
        // }
      ),
    );
  }

  Future<List<ProvinceModel>> getDataX(filter) async {
    List<ProvinceModel> searchcities = cities.where((e) =>
    (e.text.toLowerCase()
        .contains(filter.toLowerCase()))).toList();
    return searchcities;
  }

  // Future<List<TinhModel>> getData(filter) async {
  //   var response = await Dio().get(
  //     "https://gtnexpress.vn/api/get_tinh_thanh",
  //     queryParameters: {"filter": filter},
  //   );
  //
  //   final data = response.data;
  //   if (data != null) {
  //     return TinhModel.fromJsonList(data);
  //   }
  //
  //   return [];
  // }
  Future<List<StatusModel>> getData(filter) async {
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer ${yourApiTokenHere}";
    // response = await dio.post(url, data: data);
    var response = await dio.get(
      "https://gtnexpress.vn/api/get_status_add_track",
    );
    final data = response.data;
    if (data != null) {
      return StatusModel.fromJsonList(data);
    }
    return [];
  }
  Future<List<StatusModel>> getDataPT(filter) async {
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    Dio dio = new Dio();
    dio.options.headers["Authorization"] = "Bearer ${yourApiTokenHere}";
    // response = await dio.post(url, data: data);
    var response = await dio.get(
      "https://gtnexpress.vn/api/get_status_add_ship",
    );
    final data = response.data;
    if (data != null) {
      return StatusModel.fromJsonList(data);
    }
    return [];
  }

}
class StatusModel {
  final String id;
  // final DateTime createdAt;
  final String name;
  // final String avatar;

  // TinhModel({ this.id, this.createdAt,  this.name, this.avatar});
  StatusModel({this.id, this.name});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json["id"],
      // createdAt:json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
      name: json["name"],
      // avatar: json["avatar"],
    );
  }

  static List<StatusModel> fromJsonList(List list) {
    return list.map((item) => StatusModel.fromJson(item)).toList();
  }

  ///this method will prevent the override of toString
  String userAsString() {
    return '#$id $name';
  }

  ///this method will prevent the override of toString
  bool userFilterByCreationDate(String filter) {
    // return this.createdAt.toString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(StatusModel model) {
    return id == model.id;
  }

  @override
  String toString() => name;
}


class QRViewActive extends StatefulWidget {
  Profile profile;
  QRViewActive({Key key, this.profile}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewActiveState();
}

class _QRViewActiveState extends State<QRViewActive> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool cam_pause = false;
  bool cam_back_front = false;

  bool torchState = false;

  String textes="";
  String textespro="";
  String textxk="";
  List<String> textbarcode = [];

  final ValueNotifier<bool> _counter = ValueNotifier<bool>(false);

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  void initState() {
    // if(widget.profile==null){
    //   Navigator.of(context, rootNavigator: true).pop(false);
    // }
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  void showAlertx() {
    AlertDialog(
      title: Text('QR'),
      actions: [
        TextButton(
          // onPressed: (_) => Navigator.pop(context, true), // passing true
          // onPressed: () => Navigator.of(context).pop(result),
          onPressed: () async {
            await controller?.pauseCamera();
            // Navigator.of(context).pop("TH02TV210120");
          },
          child: const Text('OK'),
        ),
        TextButton(
          // onPressed: () => Navigator.pop(context, false),
          // onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
          onPressed: () async {
            await controller?.resumeCamera();
            result = null;
          },
          child: const Text('Quét lại',style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero, () => _showDialog());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quét mã'),
        actions: [
          ElevatedButton(
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              child: const Icon(Icons.cameraswitch_rounded)
          ),

          ElevatedButton(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              child: FutureBuilder(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  if(snapshot.data == null){
                    return Icon(Icons.flash_off, color: Colors.grey);
                  }
                  else if(snapshot.data){
                    return Icon(Icons.flash_on, color: Colors.white);
                  }
                  return Icon(Icons.flash_off, color: Colors.grey);
                  return Text('Flash: ${snapshot.data}');
                },
              )),

        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: _buildQrView(context)
          ),
          Expanded(
            flex: 2,
              child:ListView.builder(
                itemCount: textbarcode.length,
                  itemBuilder: (context, index) {
                  final item = textbarcode[index];
                  return ListTile(
                      title: Text("$item"),
                      // subtitle: Text("Subtitle $index"),
                      // leading: const Icon(Icons.account_circle),
                      trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 20.0,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                              // _onDeleteItemPressed(item);
                              setState(() {
                                textbarcode.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$item đã xoá')));
                          },
                        ),
                      ],
                    ),
                  );
                }
              ),
          ),
          Expanded(
            flex: 2,
            child:
            (result != null)
                ?
                  (textes=="chuakichhoat" && result != null)
                      ?
                  CupertinoAlertDialog(
                    // title: Text("MVĐ: ${result}"),
                    content: Text("${textespro}",style: TextStyle(fontSize: 16.0,color: Colors.green,fontWeight: FontWeight.bold,)),
                    actions: [
                      CupertinoDialogAction(onPressed: () async {
                        // Navigator.of(context).pop(result.code);
                        Navigator.of(context).pop([textbarcode.first??textespro,"","",textxk,(textbarcode.first).substring(0,13),textbarcode]);
                      },
                          child: Text("Sử dụng")
                      ),
                      CupertinoDialogAction(onPressed: () async {
                        setState(() {
                          result = null;
                          textes="";
                          textespro="";
                          // textbarcode = [];
                        });
                        await controller?.resumeCamera();
                      }, child: Text("Quét tiếp")),
                    ],
                  )
                      :
                  CupertinoAlertDialog(
                    content: Text("Mã: ${result.code} ${textes}",style: TextStyle(fontSize: 16.0,color: Colors.redAccent,fontWeight: FontWeight.bold,)),
                    // title: Text("MVĐ: ${result.code}",),
                    actions: [
                      (textbarcode.length>0)
                          ?
                          CupertinoDialogAction(onPressed: () async {
                            Navigator.of(context).pop([textbarcode.first??textespro,"","",textxk,(textbarcode.first).substring(0,13),textbarcode]);
                          },
                            child: Text("Sử dụng"),
                          )
                          :
                          CupertinoDialogAction(onPressed: () async {
                            setState(() {
                              result = null;
                            });
                            await controller?.resumeCamera();
                          },
                            child: Text("Mã sai"),
                          ),
                      CupertinoDialogAction(onPressed: () async {
                        //Tiep tuc quet
                        setState(() {
                          result = null;
                        });
                        await controller?.resumeCamera();
                      }, child: Text("Quét tiếp")),
                    ],
                  )
                :
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text("Chờ quét...")
                  (textbarcode.length > 0) ?
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pop([textbarcode.first,"","","","",textbarcode]);
                    },
                    child: Text(
                      "Sử dụng",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: const Color(0xFF1BC0C5),
                  )
                      :
                  Text("Chờ quét...")
                ]
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 380.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.red,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        //cutOutSize: scanArea
        cutOutHeight:160,
        cutOutWidth:160,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result.code != null) {
          controller?.pauseCamera();
          Future<String> checkresult = checkSerialActive(result.code);
          // String textes = '';
          print("kjkhkhkhkhkjh${checkresult}");
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Future<String> checkSerialActive(String serialNo) async {
    var client = http.Client();
    String serial = serialNo;

    String yourApiTokenHere = await storage.read(key: "storagetoken");
    Map<String,String> headers = {
      'Content-Type':'application/json',
      'Authorization':'Bearer $yourApiTokenHere',
      'Tenant' :'pna'
    };
    final response = await client.get(
      Uri.parse('https://gtnexpress.vn/api/qrstring?serialNo=$serial'),
      headers: headers,
    ).timeout(Duration(seconds: 5));
    final int statusCode = response.statusCode;
    var jsonBody = json.decode(response.body);
    print("checkSerialActive jsonBody: ${jsonBody}");
    if (statusCode == 200 && jsonBody != null ) { //|| json == null
      String modalname = jsonBody['modelNo'];
      if(modalname != null && modalname != '' ){
        textespro = jsonBody['modelNo'].toString()+' - '+jsonBody['statusvd'].toString() + ' - ' + jsonBody['owner'].toString();
        if (!textbarcode.contains(textespro)) {
          setState(() {
            textes = "chuakichhoat";
            textespro = jsonBody['modelNo'].toString() + ' - ' +
                jsonBody['statusvd'].toString() + ' - ' +
                jsonBody['owner'].toString();
            textbarcode.add(textespro);
            textxk = jsonBody['owner'] != null ? jsonBody['owner'].toString() : 'NA';
            // textxk += ' - Phụ trách: ';
          });
          return "chuakichhoat";
        } else {
          setState(() {
          textes ="${serialNo} đã quét";
          });
          return "dakichhoat";
        }
      }
      return "Mã $serial của người khác phụ trách";
    }
    if (statusCode == 400){
      print("khongtontai");
      setState(() {
        textes ="${serialNo} không có trên hệ thống";
      });
      return "${serialNo} không có trên hệ thống";
    }
    setState(() {
      textes="Mất kết nối";
      textespro="";
    });
    return "error server";
  }

  @override
  void dispose() {
    // controller?.dispose();
    // super.dispose();
    if (controller != null) {
      if (Platform.isIOS) controller.pauseCamera();
      // controller.dispose();
      controller?.dispose();
    }
    super.dispose();
  }
}

//
// class QRViewLook extends StatefulWidget {
//   Profile profile;
//   QRViewLook({Key key, this.profile}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _QRViewLookState();
// }
//
// class _QRViewLookState extends State<QRViewLook> {
//   Barcode result;
//   QRViewController controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   bool cam_pause = false;
//   bool cam_back_front = false;
//
//   bool torchState = false;
//
//   String textes="";
//   String textespro="";
//
//   final ValueNotifier<bool> _counter = ValueNotifier<bool>(false);
//
//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller.pauseCamera();
//     }
//     controller.resumeCamera();
//   }
//
//   void initState() {
//     // if(widget.profile==null){
//     //   Navigator.of(context, rootNavigator: true).pop(false);
//     // }
//     SystemChannels.textInput.invokeMethod('TextInput.hide');
//     super.initState();
//   }
//
//   void showAlertx() {
//     AlertDialog(
//       title: Text('TH01AC21058asd'),
//       actions: [
//         TextButton(
//           // onPressed: (_) => Navigator.pop(context, true), // passing true
//           // onPressed: () => Navigator.of(context).pop(result),
//           onPressed: () async {
//             await controller?.pauseCamera();
//             // Navigator.of(context).pop("TH02TV210120");
//           },
//           child: const Text('OK'),
//         ),
//         TextButton(
//           // onPressed: () => Navigator.pop(context, false),
//           // onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
//           onPressed: () async {
//             await controller?.resumeCamera();
//             result = null;
//           },
//           child: const Text('Quét lại',style: TextStyle(color: Colors.red)),
//         ),
//       ],
//     );
//   }
//
//   Future _showDialogx(String result) async {
//     return await CupertinoAlertDialog(
//       title: Text("Serial: ${result}"),
//       actions: [
//         CupertinoDialogAction(onPressed: () async {
//           // Navigator.pop(context, true);
//           if (controller != null) {
//             if (Platform.isIOS) controller.pauseCamera();
//             controller.dispose();
//           }
//           Navigator.of(context, rootNavigator: true).pop('${result}');
//         }, child: Text("OK")),
//         CupertinoDialogAction(onPressed: () async {
//           setState(() {
//             result = null;
//           });
//           await controller?.resumeCamera();
//           Navigator.of(context, rootNavigator: true).pop(false);
//         }, child: Text("Quét lại")),
//       ],
//       content: Text(""),
//     );
//   }
//   _showDialog(String result) async {
//     // flutter defined function
//     return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // return object of type Dialog
//
//
//         return  CupertinoAlertDialog(
//           title: Text("Serial: ${result}"),
//           actions: [
//             CupertinoDialogAction(onPressed: () async {
//               Navigator.of(context, rootNavigator: true).pop('${result}');
//             }, child: Text("OK")),
//             CupertinoDialogAction(onPressed: () async {
//               setState(() {
//                 result = null;
//               });
//               await controller?.resumeCamera();
//               Navigator.of(context, rootNavigator: true).pop(false);
//             }, child: Text("Quét lại")),
//           ],
//           content: Text(""),
//         );
//
//         // return AlertDialog(
//         //   title: Text('${result}'),
//         //   actions: [
//         //     TextButton(
//         //       // onPressed: (_) => Navigator.pop(context, true), // passing true
//         //       // onPressed: () => Navigator.of(context).pop(result),
//         //       onPressed: () async {
//         //         // await controller?.pauseCamera();
//         //         Navigator.of(context).pop(result);
//         //       },
//         //       child: Text('OK'),
//         //     ),
//         //     TextButton(
//         //       onPressed: () async {
//         //         result = null;
//         //         Navigator.of(context, rootNavigator: true).pop(false);
//         //         await controller?.resumeCamera();
//         //       },
//         //       child: const Text('Quét lại',style: TextStyle(color: Colors.red)),
//         //     ),
//         //   ],
//         // );
//       },
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     // Future.delayed(Duration.zero, () => _showDialog());
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Quét mã'),
//         actions: [
//           ElevatedButton(
//               onPressed: () async {
//                 await controller?.flipCamera();
//                 setState(() {});
//               },
//               child: const Icon(Icons.cameraswitch_rounded)
//           ),
//
//           ElevatedButton(
//               onPressed: () async {
//                 await controller?.toggleFlash();
//                 setState(() {});
//               },
//               child: FutureBuilder(
//                 future: controller?.getFlashStatus(),
//                 builder: (context, snapshot) {
//                   if(snapshot.data == null){
//                     return Icon(Icons.flash_off, color: Colors.grey);
//                   }
//                   else if(snapshot.data){
//                     return Icon(Icons.flash_on, color: Colors.white);
//                   }
//                   return Icon(Icons.flash_off, color: Colors.grey);
//                   return Text('Flash: ${snapshot.data}');
//                 },
//               )),
//
//         ],
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         children: <Widget>[
//           Expanded(
//               flex: 2,
//               child: _buildQrView(context)
//           ),
//
//           Expanded(
//             flex: 2,
//             child: (result != null)
//                 ?
//             (textes=="dakichhoat"||textes=="chuakichhoat")
//                 ?
//             CupertinoAlertDialog(
//               title: Text("Serial: ${result.code}"),
//               actions: [
//                 (textes=="dakichhoat") ?
//                 CupertinoDialogAction(onPressed: () async {
//                   Navigator.of(context).pop(result.code);
//                 },child: Text("Sử dụng"),
//                 ) : Text(''),
//                 CupertinoDialogAction(onPressed: () async {
//                   setState(() {
//                     result = null;
//                     textes="";
//                     textespro="";
//                   });
//                   await controller?.resumeCamera();
//                 }, child: Text("Quét lại")),
//               ],
//               content: Text("Model: ${textespro} \n${textes=="dakichhoat"?'Đã kích hoạt':'Chưa kích hoạt'}",style: TextStyle(fontSize: 16.0,color: (textes=="dakichhoat") ? Colors.green :  Colors.red,fontWeight: FontWeight.bold,)),
//             )
//                 :
//             CupertinoAlertDialog(
//               title: Text("Serial: ${result.code}",),
//               actions: [
//                 CupertinoDialogAction(onPressed: () async {
//                   setState(() {
//                     result = null;
//                     textes="";
//                     textespro="";
//                   });
//                   await controller?.resumeCamera();
//                 }, child: Text("Quét lại")),
//               ],
//               content: Text("${textes}",style: TextStyle(fontSize: 16.0,color: Colors.redAccent,fontWeight: FontWeight.bold,)),
//             )
//                 :
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("Không tìm thấy"),
//                   // ElevatedButton(
//                   //   onPressed: () async {
//                   //     // Navigator.of(context).pop("TH02TV210120900007");
//                   //     Future<String> checkresult = checkSerialActive("TH02TV210120900007");
//                   //     print(checkresult.toString());
//                   //     if(checkresult=="chuakichhoat"){
//                   //       print("Kich hoat ngay");
//                   //       setState(() {
//                   //         result = null;
//                   //         checkresult=null;
//                   //       });
//                   //       // await controller?.resumeCamera();
//                   //     }
//                   //     else if(checkresult=="dakichhoat"){
//                   //       print("Quét lại");
//                   //       setState(() {
//                   //         result = null;
//                   //         checkresult=null;
//                   //       });
//                   //     }
//                   //     else if(checkresult=="khongtontai"){
//                   //       print("khongtontai");
//                   //       print("Quét lại");
//                   //       setState(() {
//                   //       result = null;
//                   //       checkresult=null;
//                   //       });
//                   //     }
//                   //     else if(checkresult=="error"){
//                   //     print("Quét lại");
//                   //     setState(() {
//                   //     result = null;
//                   //     checkresult=null;
//                   //     });
//                   //     }
//                   //     // Navigator.of(context).pop(result.code);
//                   //   },
//                   //   child: const Text('Test x'),
//                   // ),
//                 ]
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//         MediaQuery.of(context).size.height < 400)
//         ? 250.0
//         : 380.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//         borderColor: Colors.red,
//         borderRadius: 10,
//         borderLength: 30,
//         borderWidth: 10,
//         //cutOutSize: scanArea
//         cutOutHeight:140,
//         cutOutWidth:360,
//       ),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//         if (result.code != null) {
//           controller?.pauseCamera();
//           Future<String> checkresult = checkSerialActive(result.code);
//           // String textes = '';
//           print("kjkhkhkhkhkjh${checkresult}");
//         }
//       });
//     });
//   }
//
//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }
//
//   Future<String> checkSerialActive(String serialNo) async {
//     var client = http.Client();
//     String serial = serialNo;
//
//     String yourApiTokenHere = await storage.read(key: "storagetoken");
//     Map<String,String> headers = {
//       'Content-Type':'application/json',
//       'Authorization':'Bearer $yourApiTokenHere',
//       'Tenant' :'pna'
//     };
//     print('https://gtnexpress.vn/api/qrstring?serialNo=$serial');
//     final response = await client.get(
//       Uri.parse('https://gtnexpress.vn/api/qrstring?serialNo=$serial'),
//       headers: headers,
//     ).timeout(Duration(seconds: 5));
//     final int statusCode = response.statusCode;
//     var jsonBody = json.decode(response.body);
//     print("checkSerialActive jsonBody: ${jsonBody}");
//     if (statusCode == 200 && jsonBody != null ) { //|| json == null
//       String modalname = jsonBody['modelNo'];
//       if(modalname != null && modalname != '' && jsonBody['warrantyActiveDate'] == null ){
//         // Chưa kích hoạt
//         print("chuakichhoat");
//         setState(() {
//           textes="chuakichhoat";
//           textespro = modalname;
//         });
//         return "chuakichhoat";
//       } else if (modalname != null && modalname != '' && jsonBody['warrantyActiveDate'] != null){
//         //da kích hoạt
//         print("dakichhoat");
//         setState(() {
//           textes="dakichhoat";
//           textespro = modalname;
//         });
//         return "dakichhoat";
//       }
//       print("!=200");
//       return "Erorr: statusCode != 200 ";
//     }
//     if (statusCode == 400){
//       print("khongtontai");
//       setState(() {
//         textes ="MVD không tồn tại";
//       });
//       return "khongtontai";
//     }
//     setState(() {
//       textes="Mất kết nối";
//       textespro="";
//     });
//     return "error";
//   }
//
//   @override
//   void dispose() {
//     // controller?.dispose();
//     // super.dispose();
//     if (controller != null) {
//       if (Platform.isIOS) controller.pauseCamera();
//       // controller.dispose();
//       controller?.dispose();
//     }
//     super.dispose();
//   }
// }

//https://github.com/geeksilva97/Medium/tree/master/app_upload
class TakePhoto extends StatefulWidget {
  final CameraDescription camera;

  TakePhoto({this.camera});

  @override
  _TakePhotoState createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
    CameraController _controller;
    Future<void> _initializeControllerFuture;

    List<CameraDescription> _availableCameras;
    // get available cameras
    Future<void> _getAvailableCameras() async{
      WidgetsFlutterBinding.ensureInitialized();
      var status = await Permission.camera.status;
      if (await Permission.camera.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        print("da duoc phep camera");
      }
      if (status.isDenied) {
        // We didn't ask for permission yet or the permission has been denied before but not permanently.
        print("camera deny");
        print(status.toString());
      }
      if(!status.isGranted){
        print("ask permission");
        status = await Permission.camera.request();
        print("ask permission");
      }
      print("do not have camera permision");
      _availableCameras = await availableCameras();
      // if (_availableCameras.length <= 2){
      //   _initCamera(_availableCameras.first);
      // } else {
      //   _initCamera(_availableCameras.last);
      // }
      _initCamera(_availableCameras.first);
    }
    // init camera
    Future<void> _initCamera(CameraDescription description) async {
      _controller = CameraController(description, ResolutionPreset.medium, enableAudio: false);
      try {
        _initializeControllerFuture = _controller.initialize();
        // to notify the widgets that camera has been initialized and now camera preview can be done
        setState(() {});
      }
      catch (e) {
        print(e);
      }
    }
    void _toggleCameraLens() {
      // if (_availableCameras.length <= 2) {
      //   return;
      // }
      // get current lens direction (front / rear)
      final lensDirection =  _controller.description.lensDirection;
      CameraDescription newDescription;
      if(lensDirection == CameraLensDirection.front){
        newDescription = _availableCameras.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
      }
      else{
        newDescription = _availableCameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
      }

      if(newDescription != null){
        _initCamera(newDescription);
      }
      else{
        print('Asked camera not available');
      }
    }

    @override
    void initState() {
    super.initState();
    _getAvailableCameras();
    // _controller = CameraController(
    //   // Get a specific camera from the list of available cameras.
    //   widget.camera as CameraDescription,
    //   // Define the resolution to use.
    //   ResolutionPreset.medium,
    // );
    // // Next, initialize the controller. This returns a Future.
    // _initializeControllerFuture = _controller.initialize();
  }

  Future<XFile> takePicture() async {
    if (_controller.value.isTakingPicture) {
      return null;
    }

    try {
      XFile file = await _controller.takePicture();
      return file;
    // } on CameraException catch (e) {
    } catch (e) {
      print("e loi o day ko lay duoc file");
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chụp ảnh'),
          actions: [
            IconButton(
              icon: const Icon(Icons.cameraswitch),
              tooltip: 'rotate',
                onPressed: () => _toggleCameraLens(),
            ),
          ],
        // FloatingActionButton(
        //   child: Icon(
        //       Icons.cameraswitch
        //   ),
        //   onPressed: () => _toggleCameraLens(),
        //   heroTag: null,
        // )
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final file = await takePicture();
      //     Navigator.of(context).pop(file != null ? file.path : null);
      //   },
      //   child: Icon(Icons.camera_alt),
      // ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () async {
          final file = await takePicture();
          Navigator.of(context).pop(file != null ? file.path : null);
        },
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       FloatingActionButton(
      //         child: Icon(
      //             Icons.camera_alt
      //         ),
      //         onPressed: () async {
      //           final file = await takePicture();
      //           Navigator.of(context).pop(file != null ? file.path : null);
      //         },
      //         heroTag: null,
      //       ),
      //     ]
      // ),

      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Container(
              // height: MediaQuery.of(context).size.height,
              child: CameraPreview(_controller),
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CardPicture extends StatelessWidget {
  CardPicture({this.onTap, this.imagePath});

  final Function() onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (imagePath != null) {
      return Card(
        child: Container(
          height: 300,
          padding: EdgeInsets.all(10.0),
          width: size.width * .70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
            image: DecorationImage(
                fit: BoxFit.cover, image: FileImage(File(imagePath as String))),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(3.0, 3.0),
                        blurRadius: 2.0,
                      )
                    ]
                ),
                // child: IconButton(onPressed: (){
                //   print('icon press');
                // }, icon: Icon(Icons.delete, color: Colors.white)),
              )
            ],
          ),
        ),
      );
    }

    return Card(
        elevation: 3,
        child: InkWell(
          onTap: this.onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
            width: size.width * .70,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Attach Picture',
                  style: TextStyle(fontSize: 17.0, color: Colors.grey[600]),
                ),
                Icon(
                  Icons.photo_camera,
                  color: Colors.indigo[400],
                )
              ],
            ),
          ),
        ));
  }
}

class CardBarcode extends StatelessWidget {
  CardBarcode({this.onTap, this.imagePath});

  final Function() onTap;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (imagePath != null) {
      return Card(
          elevation: 3,
          child: InkWell(
            onTap: this.onTap,
            child: Text(
              '${imagePath}',
              style: TextStyle(fontSize: 17.0, color: Colors.grey[600]),
            ),
            // child: Container(
            //   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
            //   width: size.width * .70,
            //   height: 100,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Attach Picture',
            //         style: TextStyle(fontSize: 17.0, color: Colors.grey[600]),
            //       ),
            //       Icon(
            //         Icons.photo_camera,
            //         color: Colors.indigo[400],
            //       )
            //     ],
            //   ),
            // ),
          ),
      );
    }

    return Card(
        elevation: 3,
        child: InkWell(
          onTap: this.onTap,
          child: Text(
            'No result',
            style: TextStyle(fontSize: 17.0, color: Colors.grey[600]),
          ),
          // child: Container(
          //   padding: EdgeInsets.symmetric(vertical: 18, horizontal: 25),
          //   width: size.width * .70,
          //   height: 100,
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Attach Picture',
          //         style: TextStyle(fontSize: 17.0, color: Colors.grey[600]),
          //       ),
          //       Icon(
          //         Icons.photo_camera,
          //         color: Colors.indigo[400],
          //       )
          //     ],
          //   ),
          // ),
        ));
  }
}

class HttpUploadService {
  Future<String> uploadPhotos(List<String> paths) async {
    print("paths: ${paths}");
    Uri uri = Uri.parse('https://gtnexpress.vn/uploadapp');
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    for(String path in paths){
      request.files.add(await http.MultipartFile.fromPath('files', path));
      print("fromPath paths ${path}");
    }
    http.StreamedResponse response = await request.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = utf8.decode(responseBytes);
    print('\n\n');
    print('RESPONSE WITH HTTP');
    print(responseString);
    var jsonBody = json.decode(responseString);
    print("convert body json: ${jsonBody}");
    if (response.statusCode == 200){
      if (jsonBody['messages'].toString() == "success") {
        return jsonBody['files'].toString();
      }
      return "error";
    } else {
      return "error";
    }
    // print('\n\n');
    // return responseString;
  }
}


// class DioUploadService {
//   Future<dynamic> uploadPhotos(List<String> paths) async {
//     String yourApiTokenHere = await storage.read(key: "storagetoken");
//     List<MultipartFile> files = [];
//     for(var p in paths) files.add(await MultipartFile.fromFile(p));
//     var formData = FormData.fromMap({
//       'files': files,
//       'contentType': MediaType('image', 'jpg')
//     });
//     print(files.toString());
//     print(formData.toString());
//     // Dio dio = new Dio();
//     // dio.options.headers["Authorization"] = "Bearer ${yourApiTokenHere}";
//     // response = await dio.post(url, data: data);
//     // var response = await dio.get(
//     //   "https://gtnexpress.vn/api/get_status_add_track",
//     // );
//     try {
//       var response = await Dio().post('https://gtnexpress.vn/uploadapp', data: formData);
//       print('\n\n');
//       print('RESPONSE WITH DIO');
//       print(response.data);
//       print('END RESPONSE WITH DIO');
//       print('\n\n');
//       return response.data;
//     } on DioError catch(error){
//       if(error.response.statusCode == 302){
//         // do your stuff here
//         print(error.response.toString());
//         return '302';
//       } else {
//         print(error.response.toString());
//         return '300';
//       }
//     }
//
//   }
//
// }
class DioUploadService {

  Future<dynamic> uploadPhotos(List<String> paths) async {
    print("dio paths");
    print(paths);
    List<MultipartFile> files = [];
    for(var p in paths) files.add(await MultipartFile.fromFile(p,filename:'upload.jpg'));
    print("dio files");
    print(files);
    // var formData = FormData.fromMap({
    //   'files': files
    // });
    var formData = FormData.fromMap({
      'name': 'wendux',
      'age': 25,
      'file': await MultipartFile.fromFile(paths[0],filename: 'upload.jpg')
    });

    var response = await Dio().post('https://gtnexpress.vn/uploadapp', data: formData);
    print('\n\n');
    print('RESPONSE WITH DIO');
    print(response.data);
    print('\n\n');
    return response.data;
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HttpUploadService _httpUploadService = HttpUploadService();
  final DioUploadService _dioUploadService = DioUploadService();
  CameraDescription _cameraDescription;
  List<String> _images = [];
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      final camera = cameras
          .where((camera) => camera.lensDirection == CameraLensDirection.back)
          .toList()
          .first;
      setState(() {
        _cameraDescription = camera;
        print(camera);
      });
    }).catchError((err) {
      print("err xxxxx111 ");
      print(err);
    });
  }

  Future<void> presentAlert(BuildContext context,
      {String title = '', String message = '', Function() ok}) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text('$title'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text('$message'),
                )
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'OK',
                  // style: greenText,
                ),
                onPressed: ok != null ? ok : Navigator.of(context).pop,
              ),
            ],
          );
        });
  }

  void presentLoader(BuildContext context,{
    String text = 'Aguarde...',
        bool barrierDismissible = false,
        bool willPop = true}) {
        showDialog(
            barrierDismissible: barrierDismissible,
            context: context,
            builder: (c) {
              return WillPopScope(
                onWillPop: () async {
                  return willPop;
                },
                child: AlertDialog(
                  content: Container(
                    child: Row(
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
  }

  void _showDialog(String result) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${result}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK',style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  String text="Upload";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Column(
              children: [
                Text('Send least two pictures', style: TextStyle(fontSize: 17.0)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  height: 400,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CardPicture(
                          onTap: () async {
                            final String imagePath =
                            await Navigator.of(context)
                                .push(MaterialPageRoute(
                                builder: (_) => TakePhoto(
                                  camera: _cameraDescription,
                                )));
                            print('imagepath: $imagePath');
                            if (imagePath != null) {
                              setState(() {
                                _images.add(imagePath);
                              });
                            }
                          },
                        ),
                        // CardPicture(),
                        // CardPicture(),
                      ] +
                          _images.map((String path) => CardPicture(
                            imagePath: path,
                          )).toList()),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.indigo,
                                  gradient: LinearGradient(colors: [
                                    Colors.indigo,
                                    Colors.indigo.shade800
                                  ]),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(3.0))),
                              child: RawMaterialButton(
                                padding: EdgeInsets.symmetric(vertical: 12.0),
                                onPressed: () async {
                                  setState(() {
                                    text = "Uploading.....";
                                  });
                                  // final showSecondDialog = await serverResult();
                                  final responseDataHttp = await _httpUploadService.uploadPhotos(_images);
                                  if (responseDataHttp!=null) {
                                    setState(() {
                                      text = "Upload success";
                                    });
                                    if (!mounted) return;
                                    // await _showDialog(responseDataHttp);
                                  }

                                  // var currentState = _scaffoldState.currentState;
                                  // try {
                                  //   showAlertDialog(_alertKey,context);
                                  //   var responseDataHttp = await _httpUploadService.uploadPhotos(_images);
                                  //   // Navigator.pop(context);
                                  //   // Navigator.of(context).pop();
                                  //   // Navigator.of(context, rootNavigator: true).pop(context);
                                  //   if (responseDataHttp != null) {
                                  //     if (_alertKey.currentContext != null) {
                                  //       Navigator.of(context).pop();
                                  //     }
                                  //   }
                                  // }catch(e){
                                  //   print(e);
                                  // }

                                  // show loader
                                  // presentLoader(context, text: 'Wait uploaad...');

                                  // calling with dio
                                  print(_images);
                                  // var responseDataDio = await _dioUploadService.uploadPhotos(_images);


                                  // print(_images);
                                  // var responseDataDio = await _dioUploadService.postImage(_images[0]);
                                  // calling with http
                                  // var responseDataHttp = await _httpUploadService.uploadPhotos(_images);

                                  // hide loader
                                  // Navigator.of(context).pop();
                                  // Navigator.pop(context);

                                  // _scaffoldState.currentState.showSnackBar( SnackBar(
                                  //   content: Text("Res ${responseDataDio.toString()}",textAlign: TextAlign.center,),
                                  // ));


                                  // showing alert dialogs
                                  // await presentAlert(context,
                                  //     title: 'Success Dio',
                                  //     message: responseDataDio.toString());

                                  // await presentAlert(context,title: 'Success HTTP',message: responseDataHttp);

                                  // await _showDialog(responseDataHttp);

                                  // await _scaffoldState.currentState.showSnackBar( SnackBar(
                                  //   content: Text("Res ${responseDataHttp.toString()}",textAlign: TextAlign.center,),
                                  // ));
                                },
                                child: Center(
                                    child: Text(
                                      '$text',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}






class Piegtnsg extends StatefulWidget {
  const Piegtnsg({Key key}) : super(key: key);

  @override
  _PiegtnsgState createState() => _PiegtnsgState();
}
// extends State<HotelHomeScreen> with TickerProviderStateMixin {
class _PiegtnsgState extends State<Piegtnsg> with TickerProviderStateMixin {

  int _selectedIndex = 0;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  var formatter =  DateFormat('dd/MM/yyyy');
  // var formatted = formatter.format(now);
  // dynamic listsearch = [
  //   "search-text",
  //   "com-all", "pay", "unpay",
  //   "start-xk","end-xk",
  //   "start-kh","end-kh",
  //   "start-hh","end-hh",
  // ];
  static List<PopularFilterListDataSG> accomodationListSG;

  // List<PopularFilterListData> popularFilterListData =
  //     PopularFilterListData.popularFList;

  List<PopularFilterListDataSG> accomodationListDataSG;

  // List<String> text;
  // Map<String, String> text = {"Tất cả":"all","Hoàn thành":null,"Chưa thanh toán":null,};
  dynamic text;
  // String comissionStatus = "all";

  String _total_unpay;
  String _total_pay;

  String count_tong_cuoc;
  String count_tong_thu_cod;
  String count_tong_tra_cod;
  String count_tong_cho_tra_cod;
  String count_tong_dang_giao_cod;
  // {"commissionPaidAmount":count_tong_cuoc},
  // {"commissionPriceAmount":count_tong_thu_cod},
  // {"count_tong_cuoc":totalfee},
  // {"count_tong_thu_cod":count_tong_thu_cod},
  // {"count_tong_tra_cod":count_tong_tra_cod},
  // {"count_tong_cho_tra_cod":count_tong_cho_tra_cod},
  // {"count_tong_dang_giao_cod":count_tong_dang_giao_cod},

  int _total = 0;
  // At the beginning, we fetch the first 20 posts
  int _page = 0;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  int _limit = 30;
  // There is next page or not
  bool _hasNextPage = true;
  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;
  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;
  // This holds the posts fetched from the server
  List _posts = [];
  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    _getunpay();
    if (mounted) {
      setState(() {
        _isFirstLoadRunning = true;
        _page = 0;
        _limit = 30;
        _total = 0;
        _hasNextPage = true;
      });
    }

    // final start = DateTime.utc(1969, 7, 20, 20, 18, 04);//var result = _contact?.email ?? ""
    final fromkh = globals["startdatekh"]?.toIso8601String();
    final tokh = globals["enddatekh"]?.toIso8601String();
    final fromxk = globals["startdatekh"]?.toIso8601String();
    final toxk = globals["enddatekh"]?.toIso8601String();
    final fromhh = globals["startdatehh"]?.toIso8601String();
    final tohh = globals["enddatehh"]?.toIso8601String();
    print("startisoDate _firstLoad");
    // print(startisoDate);// 1969-07-20T20:18:04.000Z
    // print(endisoDate);

    try {
      var bodyx = jsonEncode({
        "includeTotal":true,
        "filter":{
          "warrantyStatus":"registered",
          // "warrantyActivatedByDealer": true,//del => Danh Sách KHBH[+cuacskh] [true:Đại Lý KHBH]
          // ${dateFormat.format(start)}&end_date=${dateFormat.format(end)}",
          "comissionStatus":globals["comissionstatus"]?.toString(),
          "manufacturedDate": {
            "from": fromxk,
            "to": toxk,
          },
          "warrantyActiveDate": {
            "from": fromkh,
            "to": tokh,
          },
          "warrantyEndDate": {
            "from": fromhh,
            "to": tohh
          },
        },
        "select":"",
        "search":globals["searchproduct"]?.toString(),
        "skip":_page,
        "take":_limit,
        "status":[globals["comissionstatus"],globals["ship_chua_thanh_toan"],globals["ship_da_thanh_toan"]],
        "sort":{"warrantyActiveDate":-1},
        // "sort":{"serialNo":1}
      });
      // String tokenExp = await storage.read(key: "exp");
      // int dt_now_in_second = DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;//1351441456 [to seconds]
      // if ( dt_now_in_second >= int.parse(tokenExp) ){
      //   print("expỉed:${tokenExp}");
      //   print("expỉed:${tokenExp}  >= ${dt_now_in_second}");
      //   setState(() {});//memory leak
      //   BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
      // }
      String yourApiTokenHere = await storage.read(key: "storagetoken");
      Map<String,String> headers = {
        'Content-Type':'application/json',
        'Authorization':'Bearer $yourApiTokenHere',
        'Tenant' :'pna'
      };
      print("FirstLoad  THU NHAP check:====== ${bodyx.toString()}");
      final res = await http.post(
        Uri.parse("https://gtnexpress.vn/api/service-items/searchsg"),
        headers: headers,
        body: bodyx,
      );
      print(res.body.toString());
      print("FirstLoad  THU NHAP check:======");
      setState(() {
        _total = json.decode(res.body)['total']??0;
        _posts = json.decode(res.body)['data']??[];
        if (_total <= _limit) {
          _hasNextPage = false;
        }
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong::_firstLoad THU NHAP::: ${err}');
      }
    }
    if (mounted) {
      setState(() {
        _isFirstLoadRunning = false;
      });
    }
  }
  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    // final startisoDate=_selectedDateRange.start.toIso8601String();
    // final endisoDate=_selectedDateRange.end.toIso8601String();
    final fromkh = globals["startdatekh"]?.toIso8601String();
    final tokh = globals["enddatekh"]?.toIso8601String();
    final fromxk = globals["startdatekh"]?.toIso8601String();
    final toxk = globals["enddatekh"]?.toIso8601String();
    final fromhh = globals["startdatehh"]?.toIso8601String();
    final tohh = globals["enddatehh"]?.toIso8601String();
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 200) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 30;// Increase _page by 1
      _limit += 30;
      try {
        // final res = await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
        var body = jsonEncode({
          "includeTotal":true,
          "filter":{
            "warrantyStatus":"registered",
            // "warrantyActivatedByDealer": true,//del => Danh Sách KHBH[+cuacskh] [true:Đại Lý KHBH]
            // ${dateFormat.format(start)}&end_date=${dateFormat.format(end)}",
            "comissionStatus":globals["comissionstatus"]?.toString(),
            "manufacturedDate": {
              "from": fromxk,
              "to": toxk,
            },
            "warrantyActiveDate": {
              "from": fromkh,
              "to": tokh,
            },
            "warrantyEndDate": {
              "from": fromhh,
              "to": tohh,
            },
          },
          "select":"",
          "search":globals["searchproduct"]?.toString(),
          "skip":_page,
          "take":_limit,
          "sort":{"warrantyActiveDate":-1},
          "status":[globals["comissionstatus"],globals["ship_chua_thanh_toan"],globals["ship_da_thanh_toan"]],
          // "sort":{"serialNo":1}
        });
        String yourApiTokenHere = await storage.read(key: "storagetoken");
        Map<String,String> headers = {
          'Content-Type':'application/json',
          'Authorization':'Bearer $yourApiTokenHere',
          'Tenant' :'pna'
        };
        print(body.toString());
        final res = await http.post(
          Uri.parse("https://gtnexpress.vn/api/service-items/searchsg"),
          headers: headers,
          body: body,
        );
        print("===============Loadmore THU NHAP:total:${_total} skip:${_page.toString()} limit:${_limit.toString()}");
        // _total = json.decode(res.body)['total'];
        final List fetchedPosts = json.decode(res.body)['data'];
        // print("===============Loadmore:fetchedPosts len:${fetchedPosts.length}");
        if (fetchedPosts != null && fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
            if(_limit >= _total){
              _hasNextPage = false;
            }
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong! _loadMore  THU NHAP');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }
  // The controller for the ListView
  ScrollController _controller;

  List<Severity> dataList = []; // list of api data
  final storage = const FlutterSecureStorage();
  bool first_date_pick = true;
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract( Duration(days: 365)),
    end: DateTime.now(),
  );
  DateTimeRange _firstDateRange = DateTimeRange(
    start: DateTime.now().subtract( Duration(days: 365)),
    end: DateTime.now(),
  );

  void _getunpay() async {
    // final startisoDate = _selectedDateRange.start.toIso8601String();
    // final endisoDate = _selectedDateRange.end.toIso8601String();
    final fromkh = globals["startdatekh"]?.toIso8601String();
    final tokh = globals["enddatekh"]?.toIso8601String();
    final fromxk = globals["startdatekh"]?.toIso8601String();
    final toxk = globals["enddatekh"]?.toIso8601String();
    final fromhh = globals["startdatehh"]?.toIso8601String();
    final tohh = globals["enddatehh"]?.toIso8601String();
    try {
      var bodyx = jsonEncode({
        "includeTotal":true,
        "filter":{
          "warrantyStatus":"registered",
          "commissionPaid":false,
          "warrantyActivatedByDealer": true,//del => Danh Sách KHBH[+cuacskh] [true:Đại Lý KHBH]
          // ${dateFormat.format(start)}&end_date=${dateFormat.format(end)}",
          "comissionStatus":globals["comissionstatus"]?.toString(),
          "manufacturedDate": {
            "from": fromxk,
            "to": toxk,
          },
          "warrantyActiveDate": {
            "from": fromkh,
            "to": tokh,
          },
          "warrantyEndDate": {
            "from": fromhh,
            "to": tohh,
          },
        },
        "select":"",
        "search":globals["searchproduct"]?.toString(),
        "skip":0,
        "take":0,
        "status":[globals["comissionstatus"],globals["ship_chua_thanh_toan"],globals["ship_da_thanh_toan"]],
        "sort":{"serialNo":1}
      });
      // String tokenExp = await storage.read(key: "exp");
      // int dt_now_in_second = DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;//1351441456 [to seconds]
      // if ( dt_now_in_second >= int.parse(tokenExp) ){
      //   print("expỉed:${tokenExp}");
      //   print("expỉed:${tokenExp}  >= ${dt_now_in_second}");
      //   setState(() {});//memory leak
      //   BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
      // }
      String yourApiTokenHere = await storage.read(key: "storagetoken");
      // print(yourApiTokenHere);
      Map<String,String> headers = {
        'Content-Type':'application/json',
        'Authorization':'Bearer $yourApiTokenHere',
        'Tenant' :'pna'
      };
      final res = await http.post(
        Uri.parse("https://gtnexpress.vn/api/service-items/total-paymentsg"),
        headers: headers,
        body: bodyx,
      );
      print("TEST _getunpay paymentsg:: ${res.body.toString()}");
      // setState(() {
      //   print('Count tat ca'+json.decode(res.body)['total'].toString());
      //   print('Count tat ca'+json.decode(res.body)['data'].toString());
      //   // print(json.decode(res.body)['data']);
      //   _total = json.decode(res.body)['total'];
      //   _posts = json.decode(res.body)['data'];
      //   // List responseJson = json.decode(res.body)['data'];
      //   // responseJson.map((m) => _posts.add(SerialModal.fromJson(m))).toList();
      //   print('Count _post len: ${_posts.length.toString()}');
      // });
      if(res.statusCode == 401) {
        print("ReLogin 00000");
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
      }
      if(res.statusCode == 200) {
        print(res.body);
        final List fetchedPosts = json.decode(res.body);
        // print(fetchedPosts[0]['commissionPaidAmount'].toString());
        // print(fetchedPosts.length);
        if (mounted) {
          setState(() {
            if (fetchedPosts != null && fetchedPosts.length > 0) {
              // int.parse(strVal);
              _total_unpay = "${fetchedPosts[0]['commissionPaidAmount'] ?? 0}";// 333
              _total_pay = "${fetchedPosts[1]['commissionPriceAmount'] ?? 0}";// 444
              count_tong_cuoc = "${noSimbolInUSFormat.format(fetchedPosts[2]['count_tong_cuoc'] ?? 0)}";// thunhap
              count_tong_thu_cod = "${noSimbolInUSFormat.format(fetchedPosts[3]['count_tong_thu_cod'] ?? 0)}"; // dathanhtoan
              count_tong_tra_cod = "${noSimbolInUSFormat.format(fetchedPosts[4]['count_tong_tra_cod'] ?? 0)}"; // cho thanh toan
              count_tong_cho_tra_cod = "${noSimbolInUSFormat.format(fetchedPosts[5]['count_tong_cho_tra_cod'] ?? 0)}";
              count_tong_dang_giao_cod = "${noSimbolInUSFormat.format(fetchedPosts[6]['count_tong_dang_giao_cod'] ?? 0)}";//count total
              // _total_pay = fetchedPosts[0]['commissionPaidAmount'].toString(); //json.decode(res.body)['total'];
            } else {
              _total_unpay = '0';
              _total_pay = '0';
            }
          });
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong::::_getunpay: ${err}');
      }
    }
  }
  // void _getpay() async {
  //   // final startisoDate = _selectedDateRange.start.toLocal().toIso8601String();
  //   // final endisoDate = _selectedDateRange.end.toLocal().toIso8601String();
  //   final fromkh = globals["startdatekh"]?.toIso8601String();
  //   final tokh = globals["enddatekh"]?.toIso8601String();
  //   final fromxk = globals["startdatekh"]?.toIso8601String();
  //   final toxk = globals["enddatekh"]?.toIso8601String();
  //   final fromhh = globals["startdatehh"]?.toIso8601String();
  //   final tohh = globals["enddatehh"]?.toIso8601String();
  //   try {
  //     var bodyx = jsonEncode({
  //       "includeTotal":true,
  //       "filter":{
  //         "warrantyStatus":"registered",
  //         "commissionPaid":true,
  //         "warrantyActivatedByDealer": true,//del => Danh Sách KHBH[+cuacskh] [true:Đại Lý KHBH]
  //         // ${dateFormat.format(start)}&end_date=${dateFormat.format(end)}",
  //         "comissionStatus":globals["comissionstatus"]?.toString(),
  //         "manufacturedDate": {
  //           "from": fromxk,
  //           "to": toxk,
  //         },
  //         "warrantyActiveDate": {
  //           "from": fromkh,
  //           "to": tokh,
  //         },
  //         "warrantyEndDate": {
  //           "from": fromhh,
  //           "to": tohh,
  //         },
  //       },
  //       "select":"",
  //       "search":globals["searchproduct"]?.toString(),
  //       "skip":0,
  //       "take":0,
  //       "sort":{"serialNo":1}
  //     });
  //     // String tokenExp = await storage.read(key: "exp");
  //     // int dt_now_in_second = DateTime.now().millisecondsSinceEpoch ~/ Duration.millisecondsPerSecond;//1351441456 [to seconds]
  //     // if ( dt_now_in_second >= int.parse(tokenExp) ){
  //     //   print("expỉed:${tokenExp}");
  //     //   print("expỉed:${tokenExp}  >= ${dt_now_in_second}");
  //     //   setState(() {});//memory leak
  //     //   BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
  //     // }
  //     String yourApiTokenHere = await storage.read(key: "storagetoken");
  //     Map<String,String> headers = {
  //       'Content-Type':'application/json',
  //       'Authorization':'Bearer $yourApiTokenHere',
  //       'Tenant' :'pna'
  //     };
  //     final res = await http.post(
  //       Uri.parse("https://gtnexpress.vn/api/service-items/total-paymentsg"),
  //       headers: headers,
  //       body: bodyx,
  //     );
  //     print("test::::::::${json.decode(res.body)}::::${bodyx.toString()}");
  //
  //     // if(res.statusCode == 401) {
  //     //  print("ReLogin");
  //     //  // setState(() {});//memory leak
  //     //  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
  //     // }
  //     if(res.statusCode == 200) {
  //       final List fetchedPosts = json.decode(res.body);
  //       if (mounted) {
  //         setState(() {
  //           if (fetchedPosts != null && fetchedPosts.length > 0) {
  //             // int.parse(strVal);
  //             _total_pay = "${noSimbolInUSFormat.format(
  //                 fetchedPosts[0]['commissionPaidAmount'] ?? 0)}";
  //             // _total_pay = fetchedPosts[0]['commissionPaidAmount'].toString(); //json.decode(res.body)['total'];
  //           } else {
  //             _total_pay = '0';
  //           }
  //         });
  //       }
  //     }
  //   } catch (err) {
  //     if (kDebugMode) {
  //       print('Something went wrong::::_getpay: ${err}');
  //     }
  //   }
  // }

  var noSimbolInUSFormat = NumberFormat.simpleCurrency(locale: "vi_VN", decimalDigits: 0);
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    _firstLoad();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      setState(() {
        // getResponse(_selectedDateRange.start,_selectedDateRange.end);
        _firstLoad();
      });
    }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this);
    // print("SET STATE TEST ${_firstDateRange.start},....${_firstDateRange.end}");
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
    accomodationListDataSG = accomodationListSG = [
      PopularFilterListDataSG(
        titleTxt: 'Tất cả',
        isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
      ),
      PopularFilterListDataSG(
        titleTxt: 'chưa thanh toán',
        isSelected: (globals["ship_chua_thanh_toan"] == "true" || globals["ship_chua_thanh_toan"]?.toString() == "true") ? true : false,
      ),
      PopularFilterListDataSG(
        titleTxt: 'đã thanh toán',
        isSelected: (globals["ship_chua_thanh_toan"] == "true" || globals["ship_da_thanh_toan"]?.toString() == "true") ? true : false,
      ),
    ];
    super.initState();
  }
  @override
  void dispose() {
    animationController.dispose();
    _controller.removeListener(_loadMore);
    super.dispose();
  }


  AnimationController animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  // final ScrollController _scrollController = ScrollController();

  // DateTime startDate = DateTime.now();
  // DateTime endDate = DateTime.now().add(const Duration(days: 5));
  // Future<bool> getData() async {
  //   await Future<dynamic>.delayed(const Duration(milliseconds: 200));
  //   return true;
  // }
  DateTime _selectedStartDate = DateTime.now().subtract( Duration(days: 365));
  DateTime _selectedEndDate = DateTime.now();

  final TextEditingController _textEditingController = TextEditingController();
  _selectStartDate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedStartDate ?? DateTime.now().subtract( Duration(days: 365));
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Đóng'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Xong'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                      print("text${tempPickedDate}");
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedStartDate) {
      setState(() {
        print("hererere _selectedStartDate");
        _selectedStartDate = pickedDate;
        _textEditingController.text = pickedDate.toString();
      });
    }
  }
  _selectEndtDate() async {
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedEndDate ?? DateTime.now();
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Đóng'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Xong'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                      print("text${tempPickedDate}");
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedEndDate) {
      setState(() {
        print("hererere _selectedEndDate");
        _selectedEndDate = pickedDate;
        // _textEditingController.text = pickedDate.toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    // getAppBarUI(),
                    Expanded(
                      //https://github.com/flutter/flutter/issues/62194 fix scroll overlap
                      //https://stackoverflow.com/questions/54973948/is-it-possible-to-use-listview-builder-inside-of-customscrollview
                      //child: NestedScrollView( headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) { //important 1
                      child: NestedScrollView(
                        physics: ClampingScrollPhysics(),
                        headerSliverBuilder:  (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        // getSearchBarUI(),
                                        getTimeDateUI(),
                                      ],
                                    );
                                  }, childCount: 1),
                            ),
                            // SliverPersistentHeader(//important 2
                            //   pinned: true,
                            //   floating: true,
                            //   delegate: ContestTabHeader(
                            //     getFilterBarUI(),
                            //   ),
                            // ),
                            SliverOverlapAbsorber(//important 3
                              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                              sliver: SliverAppBar(
                                backgroundColor: Colors.grey,
                                pinned: true,
                                flexibleSpace: getFilterBarUI(),
                              ),
                            ),
                          ];
                        },
                        body: Container(
                          color: HotelAppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                            controller: _controller,
                            itemCount: _posts.length,
                            padding: const EdgeInsets.only(top: 55),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              print("INDEX: ${index}");
                              // final int count = _posts.length > 10 ? 10 : _posts.length;
                              int count = _posts.length;
                              Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController,
                                      curve: Interval(
                                          (1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                              animationController.forward();
                              return BookCardTN(book: SerialModal.fromJson(_posts[index]));
                            },
                          ),
                          // child: _buildUsersList(),
                        ),

                      ),



                      // child: NestedScrollView(
                      //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
                      //   <Widget>[
                      //     SliverToBoxAdapter(
                      //       child: SizedBox(
                      //         height: 80,
                      //         child: getTimeDateUI(),
                      //       ),
                      //     ),
                      //     SliverOverlapAbsorber(
                      //       handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                      //       sliver: SliverAppBar(
                      //         pinned: true,
                      //         backgroundColor: Colors.red,
                      //         // expandedHeight: 150.0,
                      //         // flexibleSpace: const FlexibleSpaceBar(
                      //         //   title: Text('Available seats'),
                      //         // ),
                      //         actions: <Widget>[
                      //           getFilterBarUI(),
                      //         ],
                      //       ),
                      //     ),
                      //
                      //   ],
                      //   body: Container(
                      //     color: HotelAppTheme.buildLightTheme().backgroundColor,
                      //     child: ListView.builder(
                      //       controller: _controller,
                      //       itemCount: _posts.length,
                      //       padding: const EdgeInsets.only(top: 8),
                      //       scrollDirection: Axis.vertical,
                      //       itemBuilder: (BuildContext context, int index) {
                      //         print("INDEX: ${index}");
                      //         // final int count = _posts.length > 10 ? 10 : _posts.length;
                      //         int count = _posts.length;
                      //         Animation<double> animation =
                      //         Tween<double>(begin: 0.0, end: 1.0).animate(
                      //             CurvedAnimation(
                      //                 parent: animationController,
                      //                 curve: Interval(
                      //                     (1 / count) * index, 1.0,
                      //                     curve: Curves.fastOutSlowIn)));
                      //         animationController.forward();
                      //         return BookCard(book: SerialModal.fromJson(_posts[index]));
                      //         // return HotelListView(
                      //         //   callback: () {},
                      //         //   hotelData: hotelList[index],
                      //         //   animation: animation,
                      //         //   animationController: animationController,
                      //         // );
                      //       },
                      //     ),
                      //     // child: _buildUsersList(),
                      //   ),
                      // ),



                    ),

                    if (_isLoadMoreRunning == true)
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    // When nothing else to load
                    (_hasNextPage == false && _total == 0)
                        ?
                    Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        color: Colors.amber,
                        child:  Center(
                          child: Text("Không tìm thấy"),
                        )
                    )
                        :
                    Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        // color: Colors.tealAccent,
                        child:  Center(
                          child: Text("Hiển thị: ${_total <= _limit ? _total : _limit }/${_total}",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        )
                    ),

                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: favoriteButton(),
        ),
      ),
    );

    // return Scaffold(
    //   // appBar: AppBar(
    //   //   title: const Text('Thống kê'),
    //   //   elevation: 10.0,
    //   //   backgroundColor: Colors.indigo,
    //   //   shape: RoundedRectangleBorder(
    //   //     borderRadius: BorderRadius.vertical(
    //   //       bottom: Radius.circular(10),
    //   //     ),
    //   //   ),
    //   // ),
    //     body: _isFirstLoadRunning
    //         ? const Center( child: const CircularProgressIndicator(),)
    //         : _buildBody(),
    // );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.only(bottom: 10.0,top: 10.0),
          // decoration: BoxDecoration(
          //     border: Border.all(color: Colors.blueAccent)
          // ),
          // decoration: const BoxDecoration(
          //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.0)),
          //   color: Color(0xFFE9F6EB),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey,
          //       offset: Offset(0.0, 1.0), //(x,y)
          //       blurRadius: 5.0,
          //     ),
          //   ],
          // ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, // use whichever suits your need
                  children: <Widget>[
                    Text(
                      "Hiển thị: ${_total <= _limit ? _total : _limit }/${_total}",
                      style: const TextStyle(fontSize: 17, color: Colors.black,),
                    ),
                    const SizedBox(width: 20),

                    first_date_pick
                        ?
                    Text(
                      // "${_firstDateRange.start.toString().split(' ')[0]} ${_firstDateRange.end.toString().split(' ')[0]}",
                      "${DateFormat('dd/MM/y').format(DateTime.parse(_firstDateRange.start.toString()).toLocal()).toString()} ${DateFormat('dd/MM/y').format(DateTime.parse(_firstDateRange.end.toString()).toLocal()).toString()} ",
                      style: const TextStyle(fontSize: 17, color: Colors.blue,),
                    )
                        :
                    Text(
                      // "${_selectedDateRange.start.toString().split(' ')[0]} ${_selectedDateRange.end.toString().split(' ')[0]}",
                      "${DateFormat('dd/MM/y').format(DateTime.parse(_selectedDateRange.start.toString()).toLocal()).toString()} ${DateFormat('dd/MM/y').format(DateTime.parse(_selectedDateRange.end.toString()).toLocal()).toString()} ",
                      style: const TextStyle(fontSize: 17, color: Colors.blue),
                    ),
                    const SizedBox(width: 0),
                    InkWell(
                      onTap: () {
                        //_show();
                      },
                      child: const CircleAvatar(
                        radius: 12.0,
                        backgroundColor: Colors.blueAccent,
                        child: Icon(Icons.date_range,
                            color: Color(0xFFFFFFFF), size: 16),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // use whichever suits your need
                //   children: <Widget>[
                //     // InkWell(
                //     //   onTap: () {  _show(); },
                //     //   child: const CircleAvatar(
                //     //     radius: 12.0,
                //     //     backgroundColor: Colors.lightBlueAccent,
                //     //     child: Icon(Icons.date_range,
                //     //         color: Color(0xFFFFFFFF), size: 16),
                //     //   ),
                //     // ),
                //     first_date_pick
                //         ?
                //     Text(
                //       "${_firstDateRange.start.toString().split(' ')[0]} ${_firstDateRange.end.toString().split(' ')[0]}",
                //       style: const TextStyle(fontSize: 17, color: Colors.blue,),
                //     )
                //         :
                //     Text(
                //       "Tổng cộng: 1.900.000 ₫",
                //       style: const TextStyle(fontSize: 17, color: Colors.blue),
                //     ),
                //     const SizedBox(width: 50),
                //     // const SizedBox(width: 50),
                //     Text(
                //       "Hiển thị ${_total <= _limit ? _total : _limit } / ${_total}",
                //       style: const TextStyle(fontSize: 17, color: Colors.blue,),
                //     )
                //
                //   ],
                // ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Scrollbar(
              // child: SmartRefresher(
              //     enablePullDown: true,
              //     header: const WaterDropMaterialHeader(),
              //     footer: CustomFooter(
              //       builder: (BuildContext context, LoadStatus status) {
              //         Widget body;
              //         if (status == LoadStatus.idle) {
              //           body = const Text("pull up load");
              //         } else if (status == LoadStatus.loading) {
              //           body = const CupertinoActivityIndicator();
              //         } else if (status == LoadStatus.failed) {
              //           body = const Text("Load Failed!Click retry!");
              //         } else if (status == LoadStatus.canLoading) {
              //           body = const Text("release to load more");
              //         } else {
              //           body = const Text("No more Data");
              //         }
              //         return SizedBox(
              //           height: 55.0,
              //           child: Center(child: body),
              //         );
              //       },
              //     ),
              //     controller: _refreshController,
              //     onRefresh: _onRefresh,
              //     onLoading: _onLoading,
              //     child: _buildUsersList()),
              child: _buildUsersList(),
            )
        ),

        if (_isLoadMoreRunning == true)
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),

        // When nothing else to load
        if (_hasNextPage == false)
          _total == 0 ?
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            color: Colors.amber,
            child:  Center(
              child: Text("Không tìm thấy"),
            ),
          )
              :
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            // color: Colors.amber,
            child:  Center(
              child: Text(""),
            ),
          ),
        // Container(
        //   padding: const EdgeInsets.only(top: 15, bottom: 15),
        //   color: Colors.amber,
        //   child:  Center(
        //   child: Text("Bạn đã xem tất cả ${_total}"),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildUsersList() {
    return ListView.builder(
      controller: _controller,
      itemCount: _posts.length,
      itemBuilder: (BuildContext context, int index) {
        print("INDEX: ${index}");
        return  Padding(
          padding: const EdgeInsets.only(top:4.0),
          child: BookCardTN(book: SerialModal.fromJson(_posts[index])),
        );
      },
    );
  }

  // Widget getAppBarUI() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       color: HotelAppTheme.buildLightTheme().backgroundColor,
  //       boxShadow: <BoxShadow>[
  //         BoxShadow(
  //             color: Colors.grey.withOpacity(0.2),
  //             offset: const Offset(0, 2),
  //             blurRadius: 8.0),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.only(
  //           top: MediaQuery.of(context).padding.top, left: 8, right: 8),
  //       child: Row(
  //         children: <Widget>[
  //           Container(
  //             alignment: Alignment.centerLeft,
  //             width: AppBar().preferredSize.height + 40,
  //             height: AppBar().preferredSize.height,
  //             child: Material(
  //               color: Colors.transparent,
  //               child: InkWell(
  //                 borderRadius: const BorderRadius.all(
  //                   Radius.circular(32.0),
  //                 ),
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: Icon(Icons.arrow_back),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             child: Center(
  //               child: Text(
  //                 'Explore',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w600,
  //                   fontSize: 22,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Container(
  //             width: AppBar().preferredSize.height + 40,
  //             height: AppBar().preferredSize.height,
  //             child: Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: <Widget>[
  //                 Material(
  //                   color: Colors.transparent,
  //                   child: InkWell(
  //                     borderRadius: const BorderRadius.all(
  //                       Radius.circular(32.0),
  //                     ),
  //                     onTap: () {},
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Icon(Icons.favorite_border),
  //                     ),
  //                   ),
  //                 ),
  //                 Material(
  //                   color: Colors.transparent,
  //                   child: InkWell(
  //                     borderRadius: const BorderRadius.all(
  //                       Radius.circular(32.0),
  //                     ),
  //                     onTap: () {},
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Icon(Icons.location_on_outlined),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget getSearchBarUI() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: Padding(
  //             padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: HotelAppTheme.buildLightTheme().backgroundColor,
  //                 borderRadius: const BorderRadius.all(
  //                   Radius.circular(38.0),
  //                 ),
  //                 boxShadow: <BoxShadow>[
  //                   BoxShadow(
  //                       color: Colors.grey.withOpacity(0.2),
  //                       offset: const Offset(0, 2),
  //                       blurRadius: 8.0),
  //                 ],
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.only(
  //                     left: 16, right: 16, top: 4, bottom: 4),
  //                 child: TextField(
  //                   onChanged: (String txt) {},
  //                   style: const TextStyle(
  //                     fontSize: 18,
  //                   ),
  //                   cursorColor: HotelAppTheme.buildLightTheme().primaryColor,
  //                   decoration: InputDecoration(
  //                     border: InputBorder.none,
  //                     hintText: 'London...',
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           decoration: BoxDecoration(
  //             color: HotelAppTheme.buildLightTheme().primaryColor,
  //             borderRadius: const BorderRadius.all(
  //               Radius.circular(38.0),
  //             ),
  //             boxShadow: <BoxShadow>[
  //               BoxShadow(
  //                   color: Colors.grey.withOpacity(0.4),
  //                   offset: const Offset(0, 2),
  //                   blurRadius: 8.0),
  //             ],
  //           ),
  //           child: Material(
  //             color: Colors.transparent,
  //             child: InkWell(
  //               borderRadius: const BorderRadius.all(
  //                 Radius.circular(32.0),
  //               ),
  //               onTap: () {
  //                 FocusScope.of(context).requestFocus(FocusNode());
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.all(16.0),
  //                 child: Icon(Icons.search_outlined,
  //                     size: 20,
  //                     color: HotelAppTheme.buildLightTheme().backgroundColor),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(0.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      // setState(() {
                      //   isDatePopupOpen = true;
                      // });
                      // showDemoDialog(context: context);
                      //// _show();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      // child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     Text(
                      //       'Ngày kích hoạt',
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.w400,
                      //           // fontWeight: FontWeight.bold,
                      //           fontSize: 14,
                      //           // color: Colors.grey.withOpacity(0.8)
                      //       ),
                      //     ),
                      //     // const SizedBox(
                      //     //   height: 8,
                      //     // ),
                      //     // Text(
                      //     //   // '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
                      //     //   '${DateFormat('dd/MM/y').format(DateTime.parse(_selectedDateRange.start.toString()).toLocal()).toString()} ${DateFormat('dd/MM/y').format(DateTime.parse(_selectedDateRange.end.toString()).toLocal()).toString()}',
                      //     //   style: TextStyle(
                      //     //     fontWeight: FontWeight.w400,
                      //     //     fontSize: 14,
                      //     //   ),
                      //     // ),
                      //     // Icon(Icons.filter_alt_outlined),
                      //     Padding(
                      //       padding: const EdgeInsets.only(top: 8),
                      //       child: Row(
                      //         children: <Widget>[
                      //           Text(
                      //             '${DateFormat('d/M/yyyy').format(DateTime.parse(_selectedDateRange.start.toString()).toLocal()).toString()} ${DateFormat('d/M/yyyy').format(DateTime.parse(_selectedDateRange.end.toString()).toLocal()).toString()}',
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.w400,
                      //               fontSize: 14,
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.only(left: 0.0),
                      //             child: Icon(Icons.sort, color: HotelAppTheme.buildLightTheme().primaryColor),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 0, bottom: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container (
                              padding: const EdgeInsets.all(0.0),
                              width: MediaQuery.of(context).size.width*0.45,
                              child: new Column (
                                children: <Widget>[
                                  Text(
                                    // '1 Room - 2 Adults',
                                    (int.parse(globals['roles'])>=7) ? 'Thu nhập' : 'Tổng cước',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    // '1 Room - 2 Adults',
                                    '${count_tong_cuoc}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container (
                              padding: const EdgeInsets.all(0.0),
                              width: MediaQuery.of(context).size.width*0.45,
                              child: new Column (
                                children: <Widget>[
                                  Text(
                                    // '1 Room - 2 Adults',
                                    (int.parse(globals['roles'])>=7) ? 'Chờ thanh toán ${_total_pay}' : 'COD chờ thanh toán',
                                    // 'COD chờ thanh toán',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    // '1 Room - 2 Adults',
                                    '${count_tong_cho_tra_cod}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Container(
              width: 1,
              height: 42,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 4, right: 4, top: 20, bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container (
                            padding: const EdgeInsets.all(0.0),
                            width: MediaQuery.of(context).size.width*0.40,
                            child: new Column (
                              children: <Widget>[
                                Text(
                                  (int.parse(globals['roles'])==7) ? 'Đã thanh toán' : 'Tổng thu COD',
                                  // 'Tổng thu COD',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  '${count_tong_thu_cod}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container (
                            padding: const EdgeInsets.all(0.0),
                            width: MediaQuery.of(context).size.width*0.40,
                            child: new Column (
                              children: <Widget>[
                                Text(
                                  (int.parse(globals['roles'])>=7) ? 'Tổng đơn' : 'COD đã nhận',
                                  // 'COD đã nhận',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  '${_total_unpay}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Text(
                          //   // '1 Room - 2 Adults',
                          //   '${_total_unpay}',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 14,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget renderFilters() {
    return Row(
      children: [
        Expanded(
          child: _renderFilterTitle(),
        ),
        const SizedBox(width: 5),
        const SizedBox(
          height: 44,
          child: VerticalDivider(
            width: 15,
            indent: 8,
            endIndent: 8,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 5),
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Text("Bộ lọc",
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(width: 4),
              const Icon(CupertinoIcons.chevron_down, size: 13),
            ],
          ),
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());
            _awaitReturnValueFromSecondScreen(context);
          },
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  Widget _renderFilterTitle() {
    // var attributeTerms = getAttributeTerm(showName: true);
    // var attributeList =
    // attributeTerms.isNotEmpty ? attributeTerms.split(',') : [];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _renderFilterSortByTagShipGiao()
        ],
      ),
    );
  }

  Widget _renderFilterSortByTagShipGiao() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if ( globals["searchproduct"] != null && globals["searchproduct"]?.toString() != "null" && globals["searchproduct"]?.toString() != ""  )
          FilterLabel(
            label: "${globals["searchproduct"]?.toString()}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["searchproduct"]= null;
                _firstLoad();
              });
            },
            // leading: "filterSortBy.onSale" ?? false
            leading: Icon(
              // CupertinoIcons.star_circle_fill,
              CupertinoIcons.search,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        if (globals["comissionstatus"]?.toString() == "true" || globals["comissionstatus"] == null &&
            (
                (globals["ship_chua_thanh_toan"] == null || globals["ship_chua_thanh_toan"]?.toString() == "false") &&
                    (globals["ship_da_thanh_toan"] == null || globals["ship_da_thanh_toan"]?.toString() == "false")
            )
        )
          FilterLabel(
            label: "Tất cả",
            onTap: () {
              print(globals["comissionstatus"]?.toString());
              print("Nothing");
            },
            // leading: "filterSortBy.onSale" ?? false
            leading: Icon(
              // CupertinoIcons.star_circle_fill,
              CupertinoIcons.money_dollar_circle_fill,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),

        if ( globals["ship_chua_thanh_toan"] != null &&  globals["ship_chua_thanh_toan"]?.toString() != "null" && globals["ship_chua_thanh_toan"]?.toString() != "false" )
          FilterLabel(
            label: "chưa thanh toán",
            onTap: () {
              setState(() {
                accomodationListDataSG[1].isSelected = false;
                globals["ship_chua_thanh_toan"] = null;
                if(
                globals["ship_chua_thanh_toan"]?.toString() == "false" &&
                    globals["ship_da_thanh_toan"]?.toString() == "false"
                ){
                  globals["comissionstatus"] = "true";
                }
                _firstLoad();
              });
            },
            // leading: "filterSortBy.onSale" ?? false
            leading: Icon(
              // CupertinoIcons.star_circle_fill,
              CupertinoIcons.money_dollar_circle_fill,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        if ( globals["ship_da_thanh_toan"] != null &&  globals["ship_da_thanh_toan"]?.toString() != "null" && globals["ship_da_thanh_toan"]?.toString() != "false" )
          FilterLabel(
            label: "Đã thanh toán",
            onTap: () {
              setState(() {
                accomodationListDataSG[2].isSelected = false;
                globals["ship_da_thanh_toan"] = null;
                if(
                globals["ship_chua_thanh_toan"]?.toString() == "false" &&
                    globals["ship_da_thanh_toan"]?.toString() == "false"
                ){
                  globals["comissionstatus"] = "true";
                }
                _firstLoad();
              });
            },
            // leading: "filterSortBy.onSale" ?? false
            leading: Icon(
              // CupertinoIcons.star_circle_fill,
              CupertinoIcons.money_dollar_circle_fill,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),

        if (globals["startdatekh"]?.toIso8601String() != null && globals["enddatekh"]?.toIso8601String() == null )
          FilterLabel(
            label: "${formatter.format(globals["startdatekh"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatekh"] = null;
                globals["enddatekh"] = null;
                _firstLoad();
              });
            },
            // leading: "filterSortBy.onSale" ?? false
            leading: Icon(
              CupertinoIcons.star_circle_fill,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        if (globals["startdatekh"]?.toIso8601String() == null && globals["enddatekh"]?.toIso8601String() != null )
          FilterLabel(
            label: "${formatter.format(globals["enddatekh"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatekh"] = null;
                globals["enddatekh"] = null;
                _firstLoad();
              });
            },
            // leading: "filterSortBy.onSale" ?? false
            leading: Icon(
              CupertinoIcons.star_circle_fill,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        if (globals["startdatekh"]?.toIso8601String() != null && globals["enddatekh"]?.toIso8601String() != null )
          FilterLabel(
            label: "${formatter.format(globals["startdatekh"])} - ${formatter.format(globals["enddatekh"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatekh"] = null;
                globals["enddatekh"] = null;
                _firstLoad();
              });
            },
            // leading: "filterSortBy.onSale" ?? false
            leading: Icon(
              CupertinoIcons.star_circle_fill,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
      ],
    );
  }
  Widget getFilterBarUI() {
    // return renderFilters();
    return Stack(
      children: <Widget>[
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   right: 0,
        //   child: Container(
        //     height: 24,
        //     decoration: BoxDecoration(
        //       color: HotelAppTheme.buildLightTheme().backgroundColor,
        //       boxShadow: <BoxShadow>[
        //         BoxShadow(
        //             color: Colors.grey.withOpacity(0.2),
        //             offset: const Offset(0, -2),
        //             blurRadius: 8.0),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          color: HotelAppTheme.buildLightTheme().secondaryHeaderColor,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
            child:renderFilters(),
          ),
        ),
        const Positioned(
          top: 0,//only1
          // bottom: 0,//only1
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        ),
        const Positioned(
          // top: 0,//only1
          bottom: 0,//only1
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  void _awaitReturnValueFromSecondScreen(BuildContext context) async {

    // start the SecondScreen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FiltersScreenSG(),
        ));

    // after the SecondScreen result comes back update the Text widget with it
    setState(() {
      text = result;
      print("aaaaaaaaaerror ${result.toString()}");
      if (result != null) {
        // print("init: ${text.toString()} ${text["Hoàn thành"]=="true"}");
        if (text["Tất cả"] != null && text["Tất cả"]=="true" && text["Tất cả"]?.toString() != "false"){
          globals["comissionstatus"] = "true";
        }
        if (text["chưa thanh toán"]?.toString() == "true"){
          globals["ship_chua_thanh_toan"] = "true";
        }
        if (text["đã thanh toán"]?.toString() == "true"){
          globals["ship_da_thanh_toan"] = "true";
        }

      }
      _firstLoad();

    });

  }

  void showDemoDialog({BuildContext context}) {
    showDateRangePicker(
      context: context,
      // locale: const Locale("vi", "VN"),
      firstDate: DateTime(2024, 5, 1),
      lastDate: DateTime.now(),
      currentDate: DateTime.now(),
      initialDateRange: _selectedDateRange,
      // saveText: 'Áp Dụng',
      saveText: 'OK',
    );

  }

  favoriteButton() {
    return FloatingActionButton.small(
      heroTag: "vdship",
      onPressed: ()  {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebViewExample(),));
        setState(() {
          _firstLoad();
        });
      },
      child: const Icon(Icons.refresh),
    );
  }

  void checkAppPositionX(int index) {

    if (index == 0) {
      if (globals["comissionstatus"]?.toString()=="true" || globals["comissionstatus"] == null ) {
        accomodationListDataSG.forEach((d) {
          d.isSelected = true;
        });
      } else {
        accomodationListDataSG.forEach((d) {
          d.isSelected = false;
        });
      }
    } else {
      accomodationListDataSG[index].isSelected =
      !accomodationListDataSG[index].isSelected;

      int count = 0;
      for (int i = 0; i < accomodationListDataSG.length; i++) {
        if (i != 0) {
          final PopularFilterListDataSG data = accomodationListDataSG[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == accomodationListDataSG.length - 1) {
        accomodationListDataSG[0].isSelected = true;
      } else {
        accomodationListDataSG[0].isSelected = false;
      }
    }
  }

}

class FiltersScreenSG extends StatefulWidget {
  List<PopularFilterListDataSG> popularFList;
  List<PopularFilterListDataSG> accomodationList;
  FiltersScreenSG({Key key, this.popularFList, this.accomodationList}) : super(key: key);

  @override
  _FiltersScreenSGState createState() => _FiltersScreenSGState();
}

class _FiltersScreenSGState extends State<FiltersScreenSG> {

  List<PopularFilterListDataSG> accomodationListDataSG;
  List<PopularFilterListDataSG> popularFilterListDataSG;


  RangeValues _values = const RangeValues(100, 600);
  double distValue = 50.0;

  dynamic tatca;
  dynamic hoanthanh;
  dynamic chuathanhtoan;

  @override
  void initState() {

    accomodationListDataSG = [
      PopularFilterListDataSG(
        titleTxt: 'Tất cả',
        isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
      ),
      PopularFilterListDataSG(
        titleTxt: 'chưa thanh toán',
        isSelected: (globals["ship_chua_thanh_toan"] == "true" || globals["ship_chua_thanh_toan"]?.toString() == "true") ? true : false,
      ),
      PopularFilterListDataSG(
        titleTxt: 'đã thanh toán',
        isSelected: (globals["ship_da_thanh_toan"] == "true" || globals["ship_da_thanh_toan"]?.toString() == "true") ? true : false,
      ),
    ];

    popularFilterListDataSG = accomodationListDataSG;
    print("initState accomodationListData.length");
    print(popularFilterListDataSG.length);
    print(popularFilterListDataSG.last.titleTxt);
    print("initState accomodationListDataSG.length${int.parse(globals["roles"])} ${int.parse(globals["id"])} ${( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 )}");

    super.initState();
  }

  DateTime selectedDate;


  ////Start new
  final TextEditingController _usernameController = TextEditingController(text: ( globals["searchproduct"] != null || globals["searchproduct"] != "")?globals["searchproduct"]:null );//add dispose

  DateTime _selectedstartdatexk = globals["startdatexk"];
  DateTime _selectedenddatexk = globals["enddatexk"];
  DateTime _selectedstartdatekh = globals["startdatexk"];
  DateTime _selectedenddatekh = globals["enddatexk"];
  DateTime _selectedstartdatehh = globals["startdatehh"];
  DateTime _selectedenddatehh = globals["enddatehh"];

  DateTime now = new DateTime.now();

  _selectStartDateXK() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus &&
        currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    DateTime mindate = new DateTime(now.year - 1, now.month, now.day);
    DateTime maxdate = new DateTime.now();
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedstartdatexk ?? mindate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Đóng'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Xong'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    key: UniqueKey(),maximumDate: maxdate,minimumDate: mindate,minimumYear: now.year - 1, maximumYear: now.year,
                    initialDateTime: tempPickedDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                      print("text${tempPickedDate}");
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedstartdatexk) {
      setState(() {
        print("hererere _selected startdatekh");
        _selectedstartdatexk = pickedDate;
        globals["startdatexk"] = pickedDate;
        // _textEditingController.text = pickedDate.toString();
      });
    }
  }
  _selectEndtDateXK() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus &&
        currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    DateTime mindate = new DateTime(now.year - 1, now.month, now.day);
    DateTime maxdate = new DateTime.now();
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedenddatexk ?? maxdate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Đóng'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Xong'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    key: UniqueKey(),maximumDate: maxdate,minimumDate: mindate,minimumYear: now.year - 1, maximumYear: now.year,
                    initialDateTime: tempPickedDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                      print("text${tempPickedDate}");
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedenddatexk) {
      setState(() {
        print("hererere _selected enddatekh");
        _selectedenddatexk = pickedDate;
        globals["enddatexk"] = pickedDate;
      });
    }
  }
  _selectStartDateKH() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus &&
        currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    DateTime mindate = new DateTime(now.year - 1, now.month, now.day);
    DateTime maxdate = new DateTime.now();
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: Colors.white,
      context: context,
      // isDismissible: false,
      builder: (context) {
        DateTime tempPickedDate = _selectedstartdatekh ?? mindate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Đóng'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Xong'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    key: UniqueKey(),maximumDate: maxdate,minimumDate: mindate,minimumYear: now.year - 1, maximumYear: now.year,
                    initialDateTime: tempPickedDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                      print("text tempPickedDate ${tempPickedDate}");
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedstartdatekh) {
      setState(() {
        print("hererere _selected startdatekh");
        _selectedstartdatekh = pickedDate;
        globals["startdatekh"] = pickedDate;
        // _textEditingController.text = pickedDate.toString();
      });
    }
  }
  _selectEndtDateKH() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus &&
        currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    DateTime mindate = new DateTime(now.year - 1, now.month, now.day);
    DateTime maxdate = new DateTime.now();
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedenddatekh ?? maxdate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Đóng'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Xong'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    key: UniqueKey(),maximumDate: maxdate,minimumDate: mindate,minimumYear: now.year - 1, maximumYear: now.year,
                    initialDateTime: tempPickedDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                      print("text${tempPickedDate}");
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedenddatekh) {
      setState(() {
        print("hererere _selected enddatekh");
        _selectedenddatekh = pickedDate;
        globals["enddatekh"] = pickedDate;
      });
    }
  }
  _selectStartDateHH() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus &&
        currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    DateTime mindate = new DateTime(now.year - 1, now.month, now.day);
    DateTime maxdate = new DateTime.now();
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedstartdatehh ?? mindate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Đóng'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Xong'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    key: UniqueKey(),maximumDate: maxdate,minimumDate: mindate,minimumYear: now.year - 1, maximumYear: now.year,
                    initialDateTime: tempPickedDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                      print("text${tempPickedDate}");
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedstartdatehh) {
      setState(() {
        print("hererere _selected startdatekh");
        _selectedstartdatehh = pickedDate;
        globals["startdatehh"] = pickedDate;
        // _textEditingController.text = pickedDate.toString();
      });
    }
  }
  _selectEndDateHH() async {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus &&
        currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    DateTime mindate = new DateTime(now.year - 1, now.month, now.day);
    DateTime maxdate = new DateTime.now();
    DateTime pickedDate = await showModalBottomSheet<DateTime>(
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        DateTime tempPickedDate = _selectedenddatehh ?? maxdate;
        return Container(
          height: 250,
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      child: Text('Đóng'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Xong'),
                      onPressed: () {
                        Navigator.of(context).pop(tempPickedDate);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  child: CupertinoDatePicker(
                    key: UniqueKey(),maximumDate: maxdate,minimumDate: mindate,minimumYear: now.year - 1, maximumYear: now.year,
                    initialDateTime: tempPickedDate,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (DateTime dateTime) {
                      tempPickedDate = dateTime;
                      print("text${tempPickedDate}");
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    if (pickedDate != null && pickedDate != _selectedenddatehh) {
      setState(() {
        print("hererere _selected enddatekh");
        _selectedenddatehh = pickedDate;
        globals["enddatehh"] = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
  ////End new

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Container(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        // color: HotelAppTheme.buildLightTheme().secondaryHeaderColor,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              getAppBarUI(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Padding(
                        padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                        // child: TextFormField(
                        //   controller: _usernameController,
                        //   keyboardType: TextInputType.text,
                        //   decoration: InputDecoration(
                        //       enabledBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15.0),
                        //         borderSide:  BorderSide(color: Colors.grey,width: 2),
                        //       ),
                        //       focusedBorder: OutlineInputBorder(
                        //         borderRadius: BorderRadius.circular(15.0),
                        //         borderSide:  BorderSide(color: Color(0xFFc7a500),width: 2),
                        //       ),
                        //       labelText: "Tìm kiếm tự do",
                        //       labelStyle: TextStyle(
                        //         // color: const Color(0xFFc7a500),
                        //         color: Colors.black,
                        //         fontSize: 18.0,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //       suffixText: '',
                        //       hintText: 'Model, số máy, tên khách, điện thoại',
                        //       isDense: true, // important line
                        //       floatingLabelBehavior: FloatingLabelBehavior.always
                        //   ),
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            // enabledBorder: OutlineInputBorder(
                            //   borderSide: BorderSide(color: Colors.yellow,width: 3),
                            // ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              // borderSide:  BorderSide(color: Colors.grey,width: 2),
                              borderSide:  BorderSide(color: HotelAppTheme.buildLightTheme().primaryColor,width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide:  BorderSide(color: const Color(0xFFc7a500),width: 2),
                            ),
                            labelText: "Tìm kiếm tự do",
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            hintText: "Mã vận đơn, tên khách, điện thoại",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            isDense: true, // important line
                            // Here is key idea
                            suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                Icons.clear,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                // Update the state i.e. toogle the state of passwordVisible variable
                                setState(() {
                                  _usernameController.clear();
                                  globals["searchproduct"] = null;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      ////Apply startenddate
                      const Divider(
                        height: 1,
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                        child: Text(
                          'Ngày tạo',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16, left: 16),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,//BK not center
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45.withOpacity(0.4),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),

                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        splashColor: Colors.grey.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0),
                                        ),
                                        onTap: () {
                                          // FocusScope.of(context).requestFocus(FocusNode());
                                          // _show();
                                          _selectStartDateHH();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                '${_selectedstartdatehh != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedstartdatehh.toLocal().toString())).toString() : "dd/mm/yyyy"}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0,top:4.0,bottom: 4),
                                                // child: Icon(Icons.sort,color: HotelAppTheme.buildLightTheme().primaryColor),
                                                child: Icon(Icons.date_range,color: HotelAppTheme.buildLightTheme().primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,//BK not center
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black45.withOpacity(0.4),
                                          spreadRadius: 1,
                                          blurRadius: 1,
                                          offset: Offset(0, 1), // changes position of shadow
                                        ),
                                      ],
                                    ),

                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        focusColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        splashColor: Colors.grey.withOpacity(0.2),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0),
                                        ),
                                        onTap: () {
                                          // FocusScope.of(context).requestFocus(FocusNode());
                                          // _show();
                                          _selectEndDateHH();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                '${_selectedenddatehh != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedenddatehh.toLocal().toString())).toString() : "dd/mm/yyyy"}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 0,top:4.0,bottom: 4),
                                                // child: Icon(Icons.sort,color: HotelAppTheme.buildLightTheme().primaryColor),
                                                child: Icon(Icons.date_range,color: HotelAppTheme.buildLightTheme().primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,//BK not center
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black45.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),

                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      focusColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      splashColor: Colors.grey.withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _selectedenddatexk = null;
                                          _selectedstartdatexk = null;
                                          globals["startdatexk"] = null;
                                          globals["enddatexk"] = null;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 4.0,top:4.0,bottom: 4,right: 4),
                                        child: Icon(Icons.clear,color: HotelAppTheme.buildLightTheme().primaryColor),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      allAccommodationUI(),

                      const Divider(
                        height: 8,
                      ),
                      // distanceViewUI(),
                      // const Divider(
                      //   height: 1,
                      // ),

                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 16, bottom: 16, top: 8),
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: HotelAppTheme.buildLightTheme().disabledColor,
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            blurRadius: 8,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                          highlightColor: Colors.transparent,
                          onTap: () {
                            setState(() {
                              _usernameController.clear();
                              globals["searchproduct"] = null;

                              globals["comissionstatus"] = "true";

                              checkAppPositionClear(accomodationListDataSG);

                              _selectedenddatexk = null;
                              _selectedstartdatexk = null;
                              globals["startdatexk"] = null;
                              globals["enddatexk"] = null;
                              _selectedenddatekh = null;
                              _selectedstartdatekh = null;
                              globals["startdatekh"] = null;
                              globals["enddatekh"] = null;
                              _selectedenddatehh = null;
                              _selectedstartdatehh = null;
                              globals["startdatehh"] = null;
                              globals["enddatehh"] = null;

                            });
                          },
                          child: Center(
                            child: Text(
                              ' Clear ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 16, bottom: 16, top: 8),
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: HotelAppTheme.buildLightTheme().primaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            blurRadius: 8,
                            offset: const Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                          highlightColor: Colors.transparent,
                          onTap: () {
                            var result = {};
                            for (int i = 0; i < accomodationListDataSG.length; i++) {
                              result["${accomodationListDataSG[i].titleTxt.toString()}"] = accomodationListDataSG[i].isSelected.toString();
                            }
                            print(result);
                            globals["comissionstatus"] = popularFilterListDataSG[0].isSelected.toString() == "true" ? true : false;
                            globals["ship_chua_thanh_toan"] = popularFilterListDataSG[1].isSelected.toString() == "true" ?  true : false;
                            globals["ship_da_thanh_toan"] = popularFilterListDataSG[2].isSelected.toString() == "true" ?  true : false;
                            // print(result);
                            globals["searchproduct"] = _usernameController.text?.toString() != "" || _usernameController.text?.toString() != "null" ? _usernameController.text?.toString() : null;
                            print("CHeck apply:${globals["searchproduct"]}");
                            print("Dsadsa result ${result.toString()}");
                            Navigator.pop(context, result);
                          },
                          child: Center(
                            child: Text(
                              ' Áp dụng ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
        context: context,
        locale: const Locale("vi", "VN"),
        initialDate: selectedDate ?? DateTime.now().subtract( Duration(days: 365)),
        firstDate: new DateTime(2024),
        lastDate: new DateTime.now());
    if (picked != null && picked!= selectedDate) {
      setState(() => selectedDate = picked);
      print(picked);
    }
    else{
      print(picked);
    }
  }

  Widget allAccommodationUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Trạng thái',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getAccomodationListUI(),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  List<Widget> getAccomodationListUI() {
    final List<Widget> noList = <Widget>[];
    for (int i = 0; i < accomodationListDataSG.length; i++) {
      final PopularFilterListDataSG date = accomodationListDataSG[i];
      noList.add(
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              setState(() {
                checkAppPosition(i);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      date.titleTxt,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  CupertinoSwitch(
                    activeColor: date.isSelected
                        ? HotelAppTheme.buildLightTheme().primaryColor
                        : Colors.grey.withOpacity(0.6),
                    onChanged: (bool value) {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.focusedChild != null) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                      setState(() {
                        checkAppPosition(i);
                      });
                    },
                    value: date.isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (i == 0) {
        noList.add(const Divider(
          height: 1,
        ));
      }
    }
    return noList;
  }

  void checkAppPositionClear(dynamic accomodationListDataSG) {
    // print("checkAppPosition {$index}");
    accomodationListDataSG.forEach((d) {
      d.isSelected = false;
    });
    accomodationListDataSG[0].isSelected = true;
  }
  void checkAppPosition(int index) {

    if (index == 0) {
      if (accomodationListDataSG[0].isSelected) {
        accomodationListDataSG.forEach((d) {
          d.isSelected = false;
        });
      } else {
        accomodationListDataSG.forEach((d) {
          d.isSelected = true;
        });
      }
    } else {
      accomodationListDataSG[index].isSelected =
      !accomodationListDataSG[index].isSelected;

      int count = 0;
      for (int i = 0; i < accomodationListDataSG.length; i++) {
        if (i != 0) {
          final PopularFilterListDataSG data = accomodationListDataSG[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == accomodationListDataSG.length - 1) {
        accomodationListDataSG[0].isSelected = true;
      } else {
        accomodationListDataSG[0].isSelected = false;
      }
    }
  }

  Widget distanceViewUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Distance from city center',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        // SliderView(
        //   distValue: distValue,
        //   onChangedistValue: (double value) {
        //     distValue = value;
        //   },
        // ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }

  // Widget popularFilter() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       Padding(
  //         padding:
  //         const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
  //         child: Text(
  //           'Popular filters',
  //           textAlign: TextAlign.left,
  //           style: TextStyle(
  //               color: Colors.black,
  //               fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
  //               fontWeight: FontWeight.normal),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.only(right: 16, left: 16),
  //         child: Column(
  //           children: getPList(),
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 8,
  //       )
  //     ],
  //   );
  // }

  // List<Widget> getPList() {
  //   final List<Widget> noList = <Widget>[];
  //   int count = 0;
  //   const int columnCount = 2;
  //   for (int i = 0; i < PopularFilterListDataSG.length / columnCount; i++) {
  //     final List<Widget> listUI = <Widget>[];
  //     for (int i = 0; i < columnCount; i++) {
  //       try {
  //         final PopularFilterListDataSG date = PopularFilterListDataSG[count];
  //         listUI.add(Expanded(
  //           child: Row(
  //             children: <Widget>[
  //               Material(
  //                 color: Colors.transparent,
  //                 child: InkWell(
  //                   borderRadius: const BorderRadius.all(Radius.circular(4.0)),
  //                   onTap: () {
  //                     setState(() {
  //                       date.isSelected = !date.isSelected;
  //                     });
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Row(
  //                       children: <Widget>[
  //                         Icon(
  //                           date.isSelected
  //                               ? Icons.check_box
  //                               : Icons.check_box_outline_blank,
  //                           color: date.isSelected
  //                               ? HotelAppTheme.buildLightTheme().primaryColor
  //                               : Colors.grey.withOpacity(0.6),
  //                         ),
  //                         const SizedBox(
  //                           width: 4,
  //                         ),
  //                         Text(
  //                           date.titleTxt,
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ));
  //         if (count < PopularFilterListDataSG.length - 1) {
  //           count += 1;
  //         } else {
  //           break;
  //         }
  //       } catch (e) {
  //         print(e);
  //       }
  //     }
  //     noList.add(Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.min,
  //       children: listUI,
  //     ));
  //   }
  //   return noList;
  // }

  List<Widget> getXK() {
    final List<Widget> noList = <Widget>[];
    final List<Widget> listUI = <Widget>[];
    return noList;
  }

  Widget priceBarFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Price (for 1 night)',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        // RangeSliderView(
        //   values: _values,
        //   onChangeRangeValues: (RangeValues values) {
        //     _values = values;
        //   },
        // ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 4.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Tìm kiếm & Bộ lọc',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
            )
          ],
        ),
      ),
    );
  }
}

class PopularFilterListDataSG extends StatefulWidget {
  String titleTxt = 'PopularFilterListDataSG';
  bool isSelected = true;
  PopularFilterListDataSG({Key key,this.titleTxt,this.isSelected}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopularFilterListDataSGState();
}
class _PopularFilterListDataSGState extends State<PopularFilterListDataSG> {
// class PopularFilterListData {
//   PopularFilterListData({
//     this.titleTxt = 'PopularFilterListData',
//     this.isSelected = true,
//   });
//   PopularFilterListData({
//     this.titleTxt,
//     this.isSelected,
//   });

  String titleTxt;
  bool isSelected;

  static List<PopularFilterListDataSG> popularFList = <PopularFilterListDataSG>[
    PopularFilterListDataSG(
      titleTxt: 'Tat ca',
      isSelected: false,
    ),
    PopularFilterListDataSG(
      titleTxt: 'Moi tao',
      isSelected: false,
    ),
    PopularFilterListDataSG(
      titleTxt: 'Dang nhan',
      isSelected: false,
    ),
  ];
  static List<PopularFilterListDataSG> accomodationListSG;
  @override
  void initState() {
    super.initState();
    print("initState _PopularFilterListDataSGState");
    if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) < 12 ){
      accomodationListSG = [
        PopularFilterListDataSG(
          titleTxt: 'Tất cả',
          isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
        ),
        PopularFilterListDataSG(
          titleTxt: 'chưa thanh toán',
          isSelected: (globals["ship_chua_thanh_toan"] == "true" || globals["ship_chua_thanh_toan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListDataSG(
          titleTxt: 'đã thanh toán',
          isSelected: (globals["ship_da_thanh_toan"] == "true" || globals["ship_da_thanh_toan"]?.toString() == "true") ? true : false,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("accomodationListSG");
  }

}
