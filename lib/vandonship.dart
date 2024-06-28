import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'bloc/authentication_bloc.dart';
import 'constants.dart';
import 'home_page.dart';
import 'main_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class Severity {
  int moi_tao;
  int da_chap_nhan;
  int dang_nhan;
  int da_nhan;
  int dang_nhan_lai;
  int dang_giao;
  int da_giao;
  int cho_chuyen_cod;
  int da_chuyen_cod;
  int hoan_tat;
  int luu_kho;
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
        this.da_giao,
        this.cho_chuyen_cod,
        this.da_chuyen_cod,
        this.hoan_tat,
        this.luu_kho,
        this.da_tra,
        this.tong_don_hang,
        this.tong_cuoc,
        this.tong_thu_cod,
        this.tong_tra_cod,
        this.tong_cho_tra_cod,
        this.dang_giao_cod
      });
}

class FilterLabel extends StatelessWidget {
  final String label;
  final Widget icon;
  final Widget leading;
  final Function() onTap;

  const FilterLabel({
    Key key,
    this.label,
    this.onTap,
    this.icon,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        constraints: const BoxConstraints(minWidth: 50),
        height: 30,
        decoration: BoxDecoration(
          // color: Theme.of(context).primaryColor.withOpacity(0.2),
          color: Colors.white70,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: Theme.of(context).primaryColor, width: 0.5),
        ),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) ...[
              leading,
              const SizedBox(width: 4),
            ],
            Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  textBaseline: TextBaseline.ideographic,
                ),
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 4),
              icon,
            ]
          ],
        ),
      ),
    );
  }
}

class HotelAppTheme {
  static TextTheme _buildTextTheme(TextTheme base) {
    const String fontName = 'WorkSans';
    return base.copyWith(
      headline1: base.headline1?.copyWith(fontFamily: fontName),
      headline2: base.headline2?.copyWith(fontFamily: fontName),
      headline3: base.headline3?.copyWith(fontFamily: fontName),
      headline4: base.headline4?.copyWith(fontFamily: fontName),
      headline5: base.headline5?.copyWith(fontFamily: fontName),
      headline6: base.headline6?.copyWith(fontFamily: fontName),
      button: base.button?.copyWith(fontFamily: fontName),
      caption: base.caption?.copyWith(fontFamily: fontName),
      bodyText1: base.bodyText1?.copyWith(fontFamily: fontName),
      bodyText2: base.bodyText2?.copyWith(fontFamily: fontName),
      subtitle1: base.subtitle1?.copyWith(fontFamily: fontName),
      subtitle2: base.subtitle2?.copyWith(fontFamily: fontName),
      overline: base.overline?.copyWith(fontFamily: fontName),
    );
  }

  static ThemeData buildLightTheme() {
    // final Color primaryColor = HexColor('#54D3C2');
    final Color primaryColor = Colors.indigo;
    final Color secondaryColor = HexColor('#54D3C2');
    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      platform: TargetPlatform.iOS,
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
      this.searchUI,
      );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 50.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;//false do not rebuild date
  }
}

class FiltersScreen extends StatefulWidget {
  List<PopularFilterListData> popularFList;
  List<PopularFilterListData> accomodationList;
  FiltersScreen({Key key, this.popularFList, this.accomodationList}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  List<PopularFilterListData> accomodationListData;
  List<PopularFilterListData> accomodationListDataSG;
  List<PopularFilterListData> accomodationListDataSN;
  List<PopularFilterListData> popularFilterListData;

  // List<PopularFilterListData> popularFilterListData =
  //     PopularFilterListData.popularFList;
  // List<PopularFilterListData> accomodationListData =
  //     accomodationListData;

  RangeValues _values = const RangeValues(100, 600);
  double distValue = 50.0;

  dynamic tatca;
  dynamic hoanthanh;
  dynamic chuathanhtoan;

  @override
  void initState() {
    if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) < 12 ){
      accomodationListData = [
        PopularFilterListData(
          titleTxt: 'Tất cả',
          isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_tra"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_tra"]?.toString() == "true") ? true : false,
        ),
      ];
    } else if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 ){
      accomodationListData = [
        PopularFilterListData(
          titleTxt: 'Tất cả',
          isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_giao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ xử lý',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_giao_lai"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_giao"]?.toString() == "true") ? true : false,
        )
      ];
    } else {
      accomodationListData = [
        PopularFilterListData(
          titleTxt: 'Tất cả',
          isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'mới tạo',
          isSelected: (globals["comissionstatus"] == "true" || globals["moi_tao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'lưu kho',
          isSelected: (globals["comissionstatus"] == "true" || globals["luu_kho"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_giao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ xử lý',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_giao_lai"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_giao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_tra"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_tra"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ thanh toán',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_chuyen_cod"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã thanh toán',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_chuyen_cod"]?.toString() == "true") ? true : false,
        )
      ];
    }
    popularFilterListData = accomodationListData;
    print("initState accomodationListData.length");
    print(accomodationListData.length);
    print(accomodationListData.last.titleTxt);
    print("initState accomodationListData.length${int.parse(globals["roles"])} ${int.parse(globals["id"])} ${( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 )}");
    // if (widget.popularFList != null) {
    //   popularFilterListData= widget.popularFList;
    // }
    // if (widget.accomodationList != null) {
    //   accomodationListData= widget.accomodationList;
    // }
    super.initState();
  }

  DateTime selectedDate;


  ////Start new
  final TextEditingController _usernameController = TextEditingController(text: ( globals["searchproduct"] != null || globals["searchproduct"] != "")?globals["searchproduct"]:null );//add dispose

  DateTime _selectedstartdatexk = globals["startdatexk"];
  DateTime _selectedenddatexk = globals["enddatexk"];
  DateTime _selectedstartdatekh = globals["startdatekh"];
  DateTime _selectedenddatekh = globals["enddatekh"];
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
        print("hererere _selected startdatexk");
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
        print("hererere _selected enddatexk");
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
  _selectEndtDateHH() async {
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
                                          _selectStartDateXK();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                '${_selectedstartdatexk != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedstartdatexk.toLocal().toString())).toString() : "dd/mm/yyyy"}',
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
                                          _selectEndtDateXK();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8,right: 8),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Text(
                                                '${_selectedenddatexk != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedenddatexk.toLocal().toString())).toString() : "dd/mm/yyyy"}',
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



                      // Padding(
                      //   padding:
                      //   const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                      //   child: Text(
                      //     'Ngày kích hoạt',
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                      //         fontWeight: FontWeight.normal),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 16, left: 16),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,//BK not center
                      //           children: <Widget>[
                      //             Container(
                      //               margin: EdgeInsets.all(8),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.all(Radius.circular(8)),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black45.withOpacity(0.4),
                      //                     spreadRadius: 1,
                      //                     blurRadius: 1,
                      //                     offset: Offset(0, 1), // changes position of shadow
                      //                   ),
                      //                 ],
                      //               ),
                      //
                      //               child: Material(
                      //                 color: Colors.transparent,
                      //                 child: InkWell(
                      //                   focusColor: Colors.transparent,
                      //                   highlightColor: Colors.transparent,
                      //                   hoverColor: Colors.transparent,
                      //                   splashColor: Colors.grey.withOpacity(0.2),
                      //                   borderRadius: const BorderRadius.all(
                      //                     Radius.circular(4.0),
                      //                   ),
                      //                   onTap: () {
                      //                     // FocusScope.of(context).requestFocus(FocusNode());
                      //                     // _show();
                      //                     _selectStartDateKH();
                      //                   },
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.only(left: 8,right: 8),
                      //                     child: Row(
                      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                       children: <Widget>[
                      //                         Text(
                      //                           '${_selectedstartdatekh != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedstartdatekh.toLocal().toString())).toString() : "dd/mm/yyyy"}',
                      //                           style: TextStyle(
                      //                             fontWeight: FontWeight.w500,
                      //                             fontSize: 16,
                      //                           ),
                      //                         ),
                      //                         Padding(
                      //                           padding: const EdgeInsets.only(left: 0,top:4.0,bottom: 4),
                      //                           // child: Icon(Icons.sort,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                           child: Icon(Icons.date_range,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,//BK not center
                      //           children: <Widget>[
                      //             Container(
                      //               margin: EdgeInsets.all(8),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.all(Radius.circular(8)),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black45.withOpacity(0.4),
                      //                     spreadRadius: 1,
                      //                     blurRadius: 1,
                      //                     offset: Offset(0, 1), // changes position of shadow
                      //                   ),
                      //                 ],
                      //               ),
                      //
                      //               child: Material(
                      //                 color: Colors.transparent,
                      //                 child: InkWell(
                      //                   focusColor: Colors.transparent,
                      //                   highlightColor: Colors.transparent,
                      //                   hoverColor: Colors.transparent,
                      //                   splashColor: Colors.grey.withOpacity(0.2),
                      //                   borderRadius: const BorderRadius.all(
                      //                     Radius.circular(4.0),
                      //                   ),
                      //                   onTap: () {
                      //                     // FocusScope.of(context).requestFocus(FocusNode());
                      //                     // _show();
                      //                     _selectEndtDateKH();
                      //                   },
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.only(left: 8,right: 8),
                      //                     child: Row(
                      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                       children: <Widget>[
                      //                         Text(
                      //                           '${_selectedenddatekh != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedenddatekh.toLocal().toString())).toString() : "dd/mm/yyyy"}',
                      //                           style: TextStyle(
                      //                             fontWeight: FontWeight.w500,
                      //                             fontSize: 16,
                      //                           ),
                      //                         ),
                      //                         Padding(
                      //                           padding: const EdgeInsets.only(left: 0,top:4.0,bottom: 4),
                      //                           // child: Icon(Icons.sort,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                           child: Icon(Icons.date_range,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,//BK not center
                      //         children: <Widget>[
                      //           Container(
                      //             margin: EdgeInsets.all(8),
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.all(Radius.circular(8)),
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: Colors.black45.withOpacity(0.4),
                      //                   spreadRadius: 1,
                      //                   blurRadius: 1,
                      //                   offset: Offset(0, 1), // changes position of shadow
                      //                 ),
                      //               ],
                      //             ),
                      //
                      //             child: Material(
                      //               color: Colors.transparent,
                      //               child: InkWell(
                      //                 focusColor: Colors.transparent,
                      //                 highlightColor: Colors.transparent,
                      //                 hoverColor: Colors.transparent,
                      //                 splashColor: Colors.grey.withOpacity(0.2),
                      //                 borderRadius: const BorderRadius.all(
                      //                   Radius.circular(4.0),
                      //                 ),
                      //                 onTap: () {
                      //                   setState(() {
                      //                     _selectedenddatekh = null;
                      //                     _selectedstartdatekh = null;
                      //                     globals["startdatekh"] = null;
                      //                     globals["enddatekh"] = null;
                      //                   });
                      //                 },
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(left: 4.0,top:4.0,bottom: 4,right: 4),
                      //                   child: Icon(Icons.clear,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      //
                      // Padding(
                      //   padding:
                      //   const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                      //   child: Text(
                      //     'Ngày hết hạn',
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                      //         fontWeight: FontWeight.normal),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 16, left: 16),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,//BK not center
                      //           children: <Widget>[
                      //             Container(
                      //               margin: EdgeInsets.all(8),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.all(Radius.circular(8)),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black45.withOpacity(0.4),
                      //                     spreadRadius: 1,
                      //                     blurRadius: 1,
                      //                     offset: Offset(0, 1), // changes position of shadow
                      //                   ),
                      //                 ],
                      //               ),
                      //
                      //               child: Material(
                      //                 color: Colors.transparent,
                      //                 child: InkWell(
                      //                   focusColor: Colors.transparent,
                      //                   highlightColor: Colors.transparent,
                      //                   hoverColor: Colors.transparent,
                      //                   splashColor: Colors.grey.withOpacity(0.2),
                      //                   borderRadius: const BorderRadius.all(
                      //                     Radius.circular(4.0),
                      //                   ),
                      //                   onTap: () {
                      //                     // FocusScope.of(context).requestFocus(FocusNode());
                      //                     // _show();
                      //                     _selectStartDateHH();
                      //                   },
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.only(left: 8,right: 8),
                      //                     child: Row(
                      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                       children: <Widget>[
                      //                         Text(
                      //                           '${_selectedstartdatehh != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedstartdatehh.toLocal().toString())).toString() : "dd/mm/yyyy"}',
                      //                           style: TextStyle(
                      //                             fontWeight: FontWeight.w500,
                      //                             fontSize: 16,
                      //                           ),
                      //                         ),
                      //                         Padding(
                      //                           padding: const EdgeInsets.only(left: 0,top:4.0,bottom: 4),
                      //                           // child: Icon(Icons.sort,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                           child: Icon(Icons.date_range,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,//BK not center
                      //           children: <Widget>[
                      //             Container(
                      //               margin: EdgeInsets.all(8),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.all(Radius.circular(8)),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black45.withOpacity(0.4),
                      //                     spreadRadius: 1,
                      //                     blurRadius: 1,
                      //                     offset: Offset(0, 1), // changes position of shadow
                      //                   ),
                      //                 ],
                      //               ),
                      //
                      //               child: Material(
                      //                 color: Colors.transparent,
                      //                 child: InkWell(
                      //                   focusColor: Colors.transparent,
                      //                   highlightColor: Colors.transparent,
                      //                   hoverColor: Colors.transparent,
                      //                   splashColor: Colors.grey.withOpacity(0.2),
                      //                   borderRadius: const BorderRadius.all(
                      //                     Radius.circular(4.0),
                      //                   ),
                      //                   onTap: () {
                      //                     // FocusScope.of(context).requestFocus(FocusNode());
                      //                     // _show();
                      //                     _selectEndtDateHH();
                      //                   },
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.only(left: 8,right: 8),
                      //                     child: Row(
                      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                       children: <Widget>[
                      //                         Text(
                      //                           '${_selectedenddatehh != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedenddatehh.toLocal().toString())).toString() : "dd/mm/yyyy"}',
                      //                           style: TextStyle(
                      //                             fontWeight: FontWeight.w500,
                      //                             fontSize: 16,
                      //                           ),
                      //                         ),
                      //                         Padding(
                      //                           padding: const EdgeInsets.only(left: 0,top:4.0,bottom: 4),
                      //                           // child: Icon(Icons.sort,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                           child: Icon(Icons.date_range,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.end,//BK not center
                      //         children: <Widget>[
                      //           Container(
                      //             margin: EdgeInsets.all(8),
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.all(Radius.circular(8)),
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: Colors.black45.withOpacity(0.4),
                      //                   spreadRadius: 1,
                      //                   blurRadius: 1,
                      //                   offset: Offset(0, 1), // changes position of shadow
                      //                 ),
                      //               ],
                      //             ),
                      //
                      //             child: Material(
                      //               color: Colors.transparent,
                      //               child: InkWell(
                      //                 focusColor: Colors.transparent,
                      //                 highlightColor: Colors.transparent,
                      //                 hoverColor: Colors.transparent,
                      //                 splashColor: Colors.grey.withOpacity(0.2),
                      //                 borderRadius: const BorderRadius.all(
                      //                   Radius.circular(4.0),
                      //                 ),
                      //                 onTap: () {
                      //                   setState(() {
                      //                     _selectedenddatehh = null;
                      //                     _selectedstartdatehh = null;
                      //                     globals["startdatehh"] = null;
                      //                     globals["enddatehh"] = null;
                      //                   });
                      //                 },
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(left: 4.0,top:4.0,bottom: 4,right: 4),
                      //                   child: Icon(Icons.clear,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),



                      ////Apply startenddate
                      //BK not center
                      // Padding(
                      //   padding:
                      //   const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
                      //   child: Text(
                      //     'Ngày xuất kho',
                      //     textAlign: TextAlign.left,
                      //     style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                      //         fontWeight: FontWeight.normal),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 16, left: 16),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: Row(
                      //           children: <Widget>[
                      //             Container(
                      //               margin: EdgeInsets.all(8),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.all(Radius.circular(8)),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black45.withOpacity(0.4),
                      //                     spreadRadius: 1,
                      //                     blurRadius: 1,
                      //                     offset: Offset(0, 1), // changes position of shadow
                      //                   ),
                      //                 ],
                      //               ),
                      //
                      //               child: Material(
                      //                 color: Colors.transparent,
                      //                 child: InkWell(
                      //                   focusColor: Colors.transparent,
                      //                   highlightColor: Colors.transparent,
                      //                   hoverColor: Colors.transparent,
                      //                   splashColor: Colors.grey.withOpacity(0.2),
                      //                   borderRadius: const BorderRadius.all(
                      //                     Radius.circular(4.0),
                      //                   ),
                      //                   onTap: () {
                      //                     // FocusScope.of(context).requestFocus(FocusNode());
                      //                     // _show();
                      //                     _selectStartDate();
                      //                   },
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.only(left: 8,right: 8),
                      //                     child: Row(
                      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                       children: <Widget>[
                      //                         Text(
                      //                           '${_selectedStartDate != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedStartDate.toLocal().toString())).toString() : "dd/mm/yyyy"}',
                      //                           style: TextStyle(
                      //                             fontWeight: FontWeight.w500,
                      //                             fontSize: 16,
                      //                           ),
                      //                         ),
                      //                         Padding(
                      //                           padding: const EdgeInsets.only(left: 0,top:4.0,bottom: 4),
                      //                           // child: Icon(Icons.sort,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                           child: Icon(Icons.date_range,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Expanded(
                      //         child: Row(
                      //           children: <Widget>[
                      //             Container(
                      //               margin: EdgeInsets.all(8),
                      //               decoration: BoxDecoration(
                      //                 color: Colors.white,
                      //                 borderRadius: BorderRadius.all(Radius.circular(8)),
                      //                 boxShadow: [
                      //                   BoxShadow(
                      //                     color: Colors.black45.withOpacity(0.4),
                      //                     spreadRadius: 1,
                      //                     blurRadius: 1,
                      //                     offset: Offset(0, 1), // changes position of shadow
                      //                   ),
                      //                 ],
                      //               ),
                      //
                      //               child: Material(
                      //                 color: Colors.transparent,
                      //                 child: InkWell(
                      //                   focusColor: Colors.transparent,
                      //                   highlightColor: Colors.transparent,
                      //                   hoverColor: Colors.transparent,
                      //                   splashColor: Colors.grey.withOpacity(0.2),
                      //                   borderRadius: const BorderRadius.all(
                      //                     Radius.circular(4.0),
                      //                   ),
                      //                   onTap: () {
                      //                     // FocusScope.of(context).requestFocus(FocusNode());
                      //                     // _show();
                      //                     _selectEndtDate();
                      //                   },
                      //                   child: Padding(
                      //                     padding: const EdgeInsets.only(left: 8,right: 8),
                      //                     child: Row(
                      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                       children: <Widget>[
                      //                         Text(
                      //                           '${_selectedEndDate != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedEndDate.toLocal().toString())).toString() : "dd/mm/yyyy"}',
                      //                           style: TextStyle(
                      //                             fontWeight: FontWeight.w500,
                      //                             fontSize: 16,
                      //                           ),
                      //                         ),
                      //                         Padding(
                      //                           padding: const EdgeInsets.only(left: 0,top:4.0,bottom: 4),
                      //                           // child: Icon(Icons.sort,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                           child: Icon(Icons.date_range,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),


                      // Padding(
                      //   padding: const EdgeInsets.only(right: 16, left: 16),
                      //   child: Container(
                      //     // color: HotelAppTheme.buildLightTheme().secondaryHeaderColor,
                      //     // decoration: const BoxDecoration(
                      //     //   border: Border(
                      //     //     top: BorderSide(color: Color(0xFFFFFFFF)),
                      //     //     left: BorderSide(color: Color(0xFFFFFFFF)),
                      //     //     right: BorderSide(),
                      //     //     bottom: BorderSide(),
                      //     //   ),
                      //     // ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceAround,//add for start-end-new feature
                      //         children: <Widget>[
                      //           // Modal pick
                      //           Container(
                      //             margin: EdgeInsets.all(2),
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.all(Radius.circular(8)),
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: Colors.black45.withOpacity(0.4),
                      //                   spreadRadius: 1,
                      //                   blurRadius: 1,
                      //                   offset: Offset(0, 1), // changes position of shadow
                      //                 ),
                      //               ],
                      //             ),
                      //
                      //             child: Material(
                      //               color: Colors.transparent,
                      //               child: InkWell(
                      //                 focusColor: Colors.transparent,
                      //                 highlightColor: Colors.transparent,
                      //                 hoverColor: Colors.transparent,
                      //                 splashColor: Colors.grey.withOpacity(0.2),
                      //                 borderRadius: const BorderRadius.all(
                      //                   Radius.circular(4.0),
                      //                 ),
                      //                 onTap: () {
                      //                   // FocusScope.of(context).requestFocus(FocusNode());
                      //                   // _show();
                      //                   _selectStartDate();
                      //                 },
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(left: 8,right: 8),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                     children: <Widget>[
                      //                       Text(
                      //                         '${_selectedStartDate != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedStartDate.toLocal().toString())).toString() : "dd/mm/yyy"}',
                      //                         style: TextStyle(
                      //                           fontWeight: FontWeight.w500,
                      //                           fontSize: 16,
                      //                         ),
                      //                       ),
                      //                       Padding(
                      //                         padding: const EdgeInsets.only(left: 0,top:4.0,bottom: 4),
                      //                         // child: Icon(Icons.sort,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                         child: Icon(Icons.date_range,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           Container(
                      //             margin: EdgeInsets.all(2),
                      //             decoration: BoxDecoration(
                      //               color: Colors.white,
                      //               borderRadius: BorderRadius.all(Radius.circular(8)),
                      //               boxShadow: [
                      //                 BoxShadow(
                      //                   color: Colors.black45.withOpacity(0.4),
                      //                   spreadRadius: 1,
                      //                   blurRadius: 1,
                      //                   offset: Offset(0, 1), // changes position of shadow
                      //                 ),
                      //               ],
                      //             ),
                      //
                      //             child: Material(
                      //               color: Colors.transparent,
                      //               child: InkWell(
                      //                 focusColor: Colors.transparent,
                      //                 highlightColor: Colors.transparent,
                      //                 hoverColor: Colors.transparent,
                      //                 splashColor: Colors.grey.withOpacity(0.2),
                      //                 borderRadius: const BorderRadius.all(
                      //                   Radius.circular(4.0),
                      //                 ),
                      //                 onTap: () {
                      //                   // FocusScope.of(context).requestFocus(FocusNode());
                      //                   // _show();
                      //                   _selectEndtDate();
                      //                 },
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.only(left: 8,right: 8),
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //                     children: <Widget>[
                      //                       Text(
                      //                         '${_selectedEndDate != null ? DateFormat('dd/MM/yyyy').format(DateTime.parse(_selectedEndDate.toLocal().toString())).toString() : "dd/mm/yyy"}',
                      //                         style: TextStyle(
                      //                           fontWeight: FontWeight.w500,
                      //                           fontSize: 16,
                      //                         ),
                      //                       ),
                      //                       Padding(
                      //                         padding: const EdgeInsets.only(left: 0,top:4.0,bottom: 4),
                      //                         // child: Icon(Icons.sort,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                         child: Icon(Icons.date_range,color: HotelAppTheme.buildLightTheme().primaryColor),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           //End Modal pick
                      //
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),


                      // priceBarFilter(),
                      // const Divider(
                      //   height: 1,
                      // ),

                      // Center(
                      //     child: RaisedButton(
                      //         child: Text('${selectedDate ?? "dd/mm/yyyy"} KHBH'),
                      //         onPressed: () {
                      //           selectDate(context);
                      //         }
                      //     )
                      // ),

                      ////Khong su dung
                      // popularFilter(),//Xoa
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
                            // Navigator.of(context, rootNavigator: true).pop(popularFilterListData);
                            // Navigator.pop(context);

                            // Navigator.pop(context, result);
                            setState(() {
                              _usernameController.clear();
                              globals["searchproduct"] = null;

                              globals["comissionstatus"] = "true";
                              // popularFilterListData = PopularFilterListData.popularFList;
                              // for (int i = 0; i < accomodationListData.length; i++) {
                              //   checkAppPosition(i);
                              // }
                              // accomodationListData = PopularFilterListData.accomodationList;
                              print("Clear and reset accomodationListData ");
                              checkAppPositionClear(accomodationListData);

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
                            // Navigator.of(context, rootNavigator: true).pop(popularFilterListData);
                            // Navigator.pop(context);
                            var result = {};
                            for (int i = 0; i < accomodationListData.length; i++) {
                              result["${accomodationListData[i].titleTxt.toString()}"] = accomodationListData[i].isSelected.toString();
                            }
                            print(result);
                            // for (int i = 0; i < popularFilterListData.length; i++) {
                            //   result["${popularFilterListData[i].titleTxt.toString()}"] = popularFilterListData[i].isSelected.toString();
                            // }
                            globals["comissionstatus"] = popularFilterListData[0].isSelected.toString() == "true" ? true : false;

                            if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) < 12 ) {
                              globals["dang_nhan"] = popularFilterListData[1].isSelected.toString() == "true" ?  true : false;
                              globals["da_nhan"] = popularFilterListData[2].isSelected.toString() == "true" ?  true : false;
                              globals["cho_tra"] = popularFilterListData[3].isSelected.toString() == "true" ?  true : false;
                              globals["da_tra"] = popularFilterListData[4].isSelected.toString() == "true" ? true : false;
                            } else if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 )  {
                              globals["dang_giao"] = popularFilterListData[1].isSelected.toString() == "true" ?  true : false;
                              globals["cho_giao_lai"] = popularFilterListData[2].isSelected.toString() == "true" ? true : false;
                              globals["da_giao"] = popularFilterListData[3].isSelected.toString() == "true" ?  true : false;
                            } else {
                              globals["moi_tao"] = popularFilterListData[1].isSelected.toString() == "true" ? true : false;
                              globals["dang_nhan"] = popularFilterListData[2].isSelected.toString() == "true" ?  true : false;
                              globals["da_nhan"] = popularFilterListData[3].isSelected.toString() == "true" ?  true : false;
                              globals["luu_kho"] = popularFilterListData[4].isSelected.toString() == "true" ?  true : false;
                              globals["dang_giao"] = popularFilterListData[5].isSelected.toString() == "true" ?  true : false;
                              globals["cho_giao_lai"] = popularFilterListData[6].isSelected.toString() == "true" ? true : false;
                              globals["da_giao"] = popularFilterListData[7].isSelected.toString() == "true" ?  true : false;
                              globals["cho_tra"] = popularFilterListData[8].isSelected.toString() == "true" ?  true : false;
                              globals["da_tra"] = popularFilterListData[9].isSelected.toString() == "true" ? true : false;
                              globals["cho_chuyen_cod"] = popularFilterListData[10].isSelected.toString() == "true" ?  true : false;
                              globals["da_chuyen_cod"] = popularFilterListData[11].isSelected.toString() == "true" ?  true : false;
                            }
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
    for (int i = 0; i < accomodationListData.length; i++) {
      final PopularFilterListData date = accomodationListData[i];
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

  void checkAppPositionClear(dynamic accomodationListData) {
    // print("checkAppPosition {$index}");
    accomodationListData.forEach((d) {
      d.isSelected = false;
    });
    accomodationListData[0].isSelected = true;
  }
  void checkAppPosition(int index) {

    if (index == 0) {
      if (accomodationListData[0].isSelected) {
        accomodationListData.forEach((d) {
          d.isSelected = false;
        });
      } else {
        accomodationListData.forEach((d) {
          d.isSelected = true;
        });
      }
    } else {
      accomodationListData[index].isSelected =
      !accomodationListData[index].isSelected;

      int count = 0;
      for (int i = 0; i < accomodationListData.length; i++) {
        if (i != 0) {
          final PopularFilterListData data = accomodationListData[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == accomodationListData.length - 1) {
        accomodationListData[0].isSelected = true;
      } else {
        accomodationListData[0].isSelected = false;
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

  Widget popularFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Popular filters',
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
            children: getPList(),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getPList() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    const int columnCount = 2;
    for (int i = 0; i < popularFilterListData.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < columnCount; i++) {
        try {
          final PopularFilterListData date = popularFilterListData[count];
          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        date.isSelected = !date.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            date.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: date.isSelected
                                ? HotelAppTheme.buildLightTheme().primaryColor
                                : Colors.grey.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            date.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          if (count < popularFilterListData.length - 1) {
            count += 1;
          } else {
            break;
          }
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  List<Widget> getXK() {
    final List<Widget> noList = <Widget>[];
    final List<Widget> listUI = <Widget>[];
    // listUI.add(Expanded(
    //   child: Row(
    //     children: <Widget>[
    //       Material(
    //         color: Colors.transparent,
    //         child: InkWell(
    //           borderRadius: const BorderRadius.all(Radius.circular(4.0)),
    //           onTap: () {
    //             setState(() {
    //               date.isSelected = !date.isSelected;
    //             });
    //           },
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Row(
    //               children: <Widget>[
    //                 Icon(
    //                   date.isSelected
    //                       ? Icons.check_box
    //                       : Icons.check_box_outline_blank,
    //                   color: date.isSelected
    //                       ? HotelAppTheme.buildLightTheme().primaryColor
    //                       : Colors.grey.withOpacity(0.6),
    //                 ),
    //                 const SizedBox(
    //                   width: 4,
    //                 ),
    //                 Text(
    //                   date.titleTxt,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ));
    // noList.add(Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   crossAxisAlignment: CrossAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.min,
    //   children: listUI,
    // ));
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

class PopularFilterListData extends StatefulWidget {
  String titleTxt = 'PopularFilterListData';
  bool isSelected = true;
  PopularFilterListData({Key key,this.titleTxt,this.isSelected}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopularFilterListDataState();
}
class _PopularFilterListDataState extends State<PopularFilterListData> {
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

  static List<PopularFilterListData> popularFList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'Tat ca',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Moi tao',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Dang nhan',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Da nhan',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Dang giao',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Cho xu ly',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Da giao',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Dang tra',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Da tra',
      isSelected: false,
      // isSelected: (globals["da_tra"]==null || globals["da_tra"]?.toString()=="true") ? false : true,
    ),
    PopularFilterListData(
      titleTxt: 'Cho thanh toan',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Da thanh toan',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Luu kho',
      isSelected: false,
    ),
  ];
  static List<PopularFilterListData> accomodationList;
  @override
  void initState() {
    super.initState();
    print("initState _PopularFilterListDataState");
    if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) < 12 ){
      accomodationList = [
        PopularFilterListData(
          titleTxt: 'Tất cả',
          isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_tra"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_tra"]?.toString() == "true") ? true : false,
        ),
      ];
    } else if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 ){
      accomodationList = [
        PopularFilterListData(
          titleTxt: 'Tất cả',
          isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_giao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ xử lý',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_giao_lai"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_giao"]?.toString() == "true") ? true : false,
        )
      ];
    } else {
      accomodationList = [
        PopularFilterListData(
          titleTxt: 'Tất cả',
          isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'mới tạo',
          isSelected: (globals["comissionstatus"] == "true" || globals["moi_tao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'lưu kho',
          isSelected: (globals["comissionstatus"] == "true" || globals["luu_kho"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_giao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ xử lý',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_giao_lai"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_giao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_tra"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_tra"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ thanh toán',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_chuyen_cod"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã thanh toán',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_chuyen_cod"]?.toString() == "true") ? true : false,
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("accomodationList");
  }

// static List<PopularFilterListData> accomodationList = [
//   if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) < 12 ) ...[
//     PopularFilterListData(
//       titleTxt: 'Tất cả',
//       isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đang nhận',
//       isSelected: (globals["comissionstatus"] == "true" || globals["dang_nhan"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đã nhận',
//       isSelected: (globals["comissionstatus"] == "true" || globals["da_nhan"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'chờ trả',
//       isSelected: (globals["comissionstatus"] == "true" || globals["cho_tra"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đã trả',
//       isSelected: (globals["comissionstatus"] == "true" || globals["da_tra"]?.toString() == "true") ? true : false,
//     ),
//   ] else if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 )  ...[
//     PopularFilterListData(
//       titleTxt: 'Tất cả',
//       isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đang giao',
//       isSelected: (globals["comissionstatus"] == "true" || globals["dang_giao"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'chờ xử lý',
//       isSelected: (globals["comissionstatus"] == "true" || globals["cho_giao_lai"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đã giao',
//       isSelected: (globals["comissionstatus"] == "true" || globals["da_giao"]?.toString() == "true") ? true : false,
//     )
//   ] else ...[
//     PopularFilterListData(
//       titleTxt: 'Tất cả',
//       isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'mới tạo',
//       isSelected: (globals["comissionstatus"] == "true" || globals["moi_tao"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đang nhận',
//       isSelected: (globals["comissionstatus"] == "true" || globals["dang_nhan"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đã nhận',
//       isSelected: (globals["comissionstatus"] == "true" || globals["da_nhan"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'lưu kho',
//       isSelected: (globals["comissionstatus"] == "true" || globals["luu_kho"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đang giao',
//       isSelected: (globals["comissionstatus"] == "true" || globals["dang_giao"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'chờ xử lý',
//       isSelected: (globals["comissionstatus"] == "true" || globals["cho_giao_lai"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đã giao',
//       isSelected: (globals["comissionstatus"] == "true" || globals["da_giao"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'chờ trả',
//       isSelected: (globals["comissionstatus"] == "true" || globals["cho_tra"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đã trả',
//       isSelected: (globals["comissionstatus"] == "true" || globals["da_tra"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'chờ thanh toán',
//       isSelected: (globals["comissionstatus"] == "true" || globals["cho_chuyen_cod"]?.toString() == "true") ? true : false,
//     ),
//     PopularFilterListData(
//       titleTxt: 'đã thanh toán',
//       isSelected: (globals["comissionstatus"] == "true" || globals["da_chuyen_cod"]?.toString() == "true") ? true : false,
//     )]
// ];

}

class HotelListData {
  HotelListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = 1.8,
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = 180,
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  double dist;
  double rating;
  int reviews;
  int perNight;

  static List<HotelListData> hotelList = <HotelListData>[
    HotelListData(
      imagePath: 'assets/hotel/hotel_1.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 80,
      rating: 4.4,
      perNight: 180,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_2.png',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 4.0,
      reviews: 74,
      rating: 4.5,
      perNight: 200,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_3.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 3.0,
      reviews: 62,
      rating: 4.0,
      perNight: 60,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_4.png',
      titleTxt: 'Queen Hotel',
      subTxt: 'Wembley, London',
      dist: 7.0,
      reviews: 90,
      rating: 4.4,
      perNight: 170,
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_5.png',
      titleTxt: 'Grand Royal Hotel',
      subTxt: 'Wembley, London',
      dist: 2.0,
      reviews: 240,
      rating: 4.5,
      perNight: 200,
    ),
  ];
}

class HotelListView extends StatelessWidget {
  const HotelListView(
      {Key key,
        this.hotelData,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback callback;
  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.asset(
                                hotelData.imagePath,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: HotelAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              hotelData.titleTxt,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 22,
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  hotelData.subTxt,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey
                                                          .withOpacity(0.8)),
                                                ),
                                                const SizedBox(
                                                  width: 4,
                                                ),
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  size: 12,
                                                  color: HotelAppTheme
                                                      .buildLightTheme()
                                                      .primaryColor,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${hotelData.dist.toStringAsFixed(1)} km to city',
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  // RatingBar(
                                                  //   initialRating:
                                                  //   hotelData.rating,
                                                  //   direction: Axis.horizontal,
                                                  //   allowHalfRating: true,
                                                  //   itemCount: 5,
                                                  //   itemSize: 24,
                                                  //   ratingWidget: RatingWidget(
                                                  //     full: Icon(
                                                  //       Icons.star_rate_rounded,
                                                  //       color: HotelAppTheme
                                                  //           .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //     half: Icon(
                                                  //       Icons.star_half_rounded,
                                                  //       color: HotelAppTheme
                                                  //           .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //     empty: Icon(
                                                  //       Icons
                                                  //           .star_border_rounded,
                                                  //       color: HotelAppTheme
                                                  //           .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //   ),
                                                  //   itemPadding:
                                                  //   EdgeInsets.zero,
                                                  //   onRatingUpdate: (rating) {
                                                  //     print(rating);
                                                  //   },
                                                  // ),
                                                  Text(
                                                    ' ${hotelData.reviews} Reviews',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey
                                                            .withOpacity(0.8)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '\$${hotelData.perNight}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(
                                          '/per night',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                              Colors.grey.withOpacity(0.8)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(32.0),
                              ),
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.favorite_border,
                                  color: HotelAppTheme.buildLightTheme()
                                      .primaryColor,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// The DismissKeybaord widget (it's reusable)
class DismissKeyboard extends StatelessWidget {
  final Widget child;
  const DismissKeyboard({Key key,  this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}











class PiegtnsgXX extends StatefulWidget {
  const PiegtnsgXX({Key key}) : super(key: key);

  @override
  _PiegtnsgXXState createState() => _PiegtnsgXXState();
}
// extends State<HotelHomeScreen> with TickerProviderStateMixin {
class _PiegtnsgXXState extends State<PiegtnsgXX> with TickerProviderStateMixin {

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
  static List<PopularFilterListData> accomodationList;

  // List<PopularFilterListData> popularFilterListData =
  //     PopularFilterListData.popularFList;

  List<PopularFilterListData> accomodationListData;

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
    if (globals["comissionstatus"].toString() == "true" || globals["comissionstatus"] == null || globals["comissionstatus"].toString() == "null" ){
      _getunpay();
      // _getpay();
    } else {
      _getunpay();
      // _getpay();
    }
    // else if (globals["comissionstatus"].toString() == "paid") {
    //   _getpay();
    //   setState(() {_total_unpay='0';});
    // } else if (globals["comissionstatus"].toString() == "not-paid") {
    //   _getunpay();
    //   setState(() {_total_pay='0';});
    // }

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
    final fromxk = globals["startdatexk"]?.toIso8601String();
    final toxk = globals["enddatexk"]?.toIso8601String();
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
        "status":[globals["comissionstatus"],2,3, globals["moi_tao"],globals["dang_nhan"],globals["da_nhan"],globals["dang_giao"],globals["cho_giao_lai"],globals["da_giao"],globals["cho_tra"],globals["da_tra"],globals["cho_chuyen_cod"],globals["da_chuyen_cod"],globals["luu_kho"]],
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

      print("FirstLoad check: ${bodyx.toString()}");
      final res = await http.post(
        Uri.parse("https://gtnexpress.vn/api/service-items/search"),
        headers: headers,
        body: bodyx,
      );
      setState(() {
        _total = json.decode(res.body)['total']??0;
        _posts = json.decode(res.body)['data']??[];
        if (_total <= _limit) {
          _hasNextPage = false;
        }
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong::_firstLoad::: ${err}');
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
    final fromxk = globals["startdatexk"]?.toIso8601String();
    final toxk = globals["enddatexk"]?.toIso8601String();
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
          "status":[globals["comissionstatus"],2,3, globals["moi_tao"],globals["dang_nhan"],globals["da_nhan"],globals["dang_giao"],globals["cho_giao_lai"],globals["da_giao"],globals["cho_tra"],globals["da_tra"],globals["cho_chuyen_cod"],globals["da_chuyen_cod"],globals["luu_kho"]],
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
          Uri.parse("https://gtnexpress.vn/api/service-items/search"),
          headers: headers,
          body: body,
        );
        print("===============Loadmore:total:${_total} skip:${_page.toString()} limit:${_limit.toString()}");
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
          print('Something went wrong! _loadMore');
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
    final fromxk = globals["startdatexk"]?.toIso8601String();
    final toxk = globals["enddatexk"]?.toIso8601String();
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
      Map<String,String> headers = {
        'Content-Type':'application/json',
        'Authorization':'Bearer $yourApiTokenHere',
        'Tenant' :'pna'
      };
      final res = await http.post(
        Uri.parse("https://gtnexpress.vn/api/service-items/total-payment"),
        headers: headers,
        body: bodyx,
      );
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
        final List fetchedPosts = json.decode(res.body);
        // print(fetchedPosts[0]['commissionPaidAmount'].toString());
        // print(fetchedPosts.length);
        if (mounted) {
          setState(() {
            if (fetchedPosts != null && fetchedPosts.length > 0) {
              // int.parse(strVal);
              _total_unpay = "${noSimbolInUSFormat.format(fetchedPosts[0]['commissionPaidAmount'] ?? 0)}";
              _total_pay = "${noSimbolInUSFormat.format(fetchedPosts[1]['commissionPriceAmount'] ?? 0)}";
              count_tong_cuoc = "${noSimbolInUSFormat.format(fetchedPosts[2]['count_tong_cuoc'] ?? 0)}";
              count_tong_thu_cod = "${noSimbolInUSFormat.format(fetchedPosts[3]['count_tong_thu_cod'] ?? 0)}";
              count_tong_tra_cod = "${noSimbolInUSFormat.format(fetchedPosts[4]['count_tong_tra_cod'] ?? 0)}";
              count_tong_cho_tra_cod = "${noSimbolInUSFormat.format(fetchedPosts[5]['count_tong_cho_tra_cod'] ?? 0)}";
              count_tong_dang_giao_cod = "${noSimbolInUSFormat.format(fetchedPosts[6]['count_tong_dang_giao_cod'] ?? 0)}";
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
  //   final fromxk = globals["startdatexk"]?.toIso8601String();
  //   final toxk = globals["enddatexk"]?.toIso8601String();
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
  //       Uri.parse("https://gtnexpress.vn/api/service-items/total-payment"),
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


    if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) < 12 ){
      print("init vd filter sn");
      accomodationListData = accomodationList = [
        PopularFilterListData(
          titleTxt: 'Tất cả',
          isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_tra"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_tra"]?.toString() == "true") ? true : false,
        ),
      ];
    } else if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 ){
      print("ini accomodationList shipgiao");
      accomodationListData = accomodationList = [
        PopularFilterListData(
          titleTxt: 'Tất cả',
          isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_giao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ xử lý',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_giao_lai"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_giao"]?.toString() == "true") ? true : false,
        )
      ];
    } else {
      print("init vd filter else");
      accomodationListData = accomodationList = [
        PopularFilterListData(
          titleTxt: 'Tất cả',
          isSelected: (globals["comissionstatus"]==null || globals["comissionstatus"] == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'mới tạo',
          isSelected: (globals["comissionstatus"] == "true" || globals["moi_tao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã nhận',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_nhan"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'lưu kho',
          isSelected: (globals["comissionstatus"] == "true" || globals["luu_kho"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đang giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["dang_giao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ xử lý',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_giao_lai"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã giao',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_giao"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_tra"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã trả',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_tra"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'chờ thanh toán',
          isSelected: (globals["comissionstatus"] == "true" || globals["cho_chuyen_cod"]?.toString() == "true") ? true : false,
        ),
        PopularFilterListData(
          titleTxt: 'đã thanh toán',
          isSelected: (globals["comissionstatus"] == "true" || globals["da_chuyen_cod"]?.toString() == "true") ? true : false,
        )
      ];
    }
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
                              return BookCard(book: SerialModal.fromJson(_posts[index]));
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
          child: BookCard(book: SerialModal.fromJson(_posts[index])),
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
                                    (int.parse(globals['roles'])==7) ? 'Thu nhập' : 'Tổng cước',
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
                                    (int.parse(globals['roles'])==7) ? 'Chờ thanh toán' : 'COD chờ thanh toán',
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
                                  (int.parse(globals['roles'])==7) ? 'Đã thu' : 'Tổng thu COD',
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
                                  (int.parse(globals['roles'])==7) ? 'Đang nhận' : 'COD đã nhận',
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
                                  '${count_tong_tra_cod}',
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
          if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 ) ...[
            _renderFilterSortByTagShipGiao()
          ] else if( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) < 12 ) ...[
            _renderFilterSortByTagShipNhan()
          ] else ...[
            _renderFilterSortByTag()
          ]
        ],
      ),
    );
  }

  Widget _renderFilterSortByTag() {
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
        if (globals["comissionstatus"]?.toString() == "true" || globals["comissionstatus"] == null && (
            (globals["moi_tao"] == null || globals["moi_tao"]?.toString() == "false") &&
                (globals["dang_nhan"] == null || globals["dang_nhan"]?.toString() == "false") &&
                (globals["da_nhan"] == null || globals["da_nhan"]?.toString() == "false") &&
                (globals["luu_kho"] == null || globals["luu_kho"]?.toString() == "false") &&
                (globals["dang_giao"] == null || globals["dang_giao"]?.toString() == "false") &&
                (globals["cho_giao_lai"] == null || globals["cho_giao_lai"]?.toString() == "false") &&
                (globals["da_giao"] == null || globals["da_giao"]?.toString() == "false") &&
                (globals["cho_tra"] == null || globals["cho_tra"]?.toString() == "false") &&
                (globals["da_tra"] == null || globals["da_tra"]?.toString() == "false") &&
                (globals["cho_chuyen_cod"] == null || globals["cho_chuyen_cod"]?.toString() == "false") &&
                (globals["da_chuyen_cod"] == null || globals["da_chuyen_cod"]?.toString() == "false")
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

        if ( globals["moi_tao"] != null &&  globals["moi_tao"]?.toString() != "null" && globals["moi_tao"]?.toString() != "false" )
          FilterLabel(
            label: "mới tạo",
            onTap: () {
              setState(() {
                accomodationListData[1].isSelected = false;
                globals["moi_tao"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["dang_nhan"] != null &&  globals["dang_nhan"]?.toString() != "null" && globals["dang_nhan"]?.toString() != "false" )
          FilterLabel(
            label: "đang nhận",
            onTap: () {
              setState(() {
                accomodationListData[2].isSelected = false;
                globals["dang_nhan"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["da_nhan"] != null &&  globals["da_nhan"]?.toString() != "null" && globals["da_nhan"]?.toString() != "false" )
          FilterLabel(
            label: "đã nhận",
            onTap: () {
              setState(() {
                accomodationListData[3].isSelected = false;
                globals["da_nhan"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["luu_kho"] != null &&  globals["luu_kho"]?.toString() != "null" && globals["luu_kho"]?.toString() != "false" )
          FilterLabel(
            label: "lưu kho",
            onTap: () {
              setState(() {
                accomodationListData[4].isSelected = false;
                globals["luu_kho"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["dang_giao"] != null &&  globals["dang_giao"]?.toString() != "null" && globals["dang_giao"]?.toString() != "false" )
          FilterLabel(
            label: "đang giao",
            onTap: () {
              setState(() {
                accomodationListData[5].isSelected = false;
                globals["dang_giao"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["cho_giao_lai"] != null &&  globals["cho_giao_lai"]?.toString() != "null" && globals["cho_giao_lai"]?.toString() != "false" )
          FilterLabel(
            label: "chờ xử lý",
            onTap: () {
              setState(() {
                accomodationListData[6].isSelected = false;
                globals["cho_giao_lai"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["da_giao"] != null &&  globals["da_giao"]?.toString() != "null" && globals["da_giao"]?.toString() != "false" )
          FilterLabel(
            label: "đã giao",
            onTap: () {
              setState(() {
                accomodationListData[7].isSelected = false;
                globals["da_giao"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["cho_tra"] != null &&  globals["cho_tra"]?.toString() != "null" && globals["cho_tra"]?.toString() != "false" )
          FilterLabel(
            label: "chờ trả",
            onTap: () {
              setState(() {
                accomodationListData[8].isSelected = false;
                globals["cho_tra"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["da_tra"] != null &&  globals["da_tra"]?.toString() != "null" && globals["da_tra"]?.toString() != "false" )
          FilterLabel(
            label: "đã trả",
            onTap: () {
              setState(() {
                accomodationListData[9].isSelected = false;
                globals["da_tra"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["cho_chuyen_cod"] != null &&  globals["cho_chuyen_cod"]?.toString() != "null" && globals["cho_chuyen_cod"]?.toString() != "false" )
          FilterLabel(
            label: "chờ thanh toán",
            onTap: () {
              setState(() {
                accomodationListData[10].isSelected = false;
                globals["cho_chuyen_cod"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["da_chuyen_cod"] != null &&  globals["da_chuyen_cod"]?.toString() != "null" && globals["da_chuyen_cod"]?.toString() != "false" )
          FilterLabel(
            label: "đã thanh toán",
            onTap: () {
              setState(() {
                accomodationListData[11].isSelected = false;
                globals["da_chuyen_cod"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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


        if (globals["startdatexk"]?.toIso8601String() != null && globals["enddatexk"]?.toIso8601String() == null )
          FilterLabel(
            label: "${formatter.format(globals["startdatexk"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatexk"] = null;
                globals["enddatexk"] = null;
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
        if (globals["startdatexk"]?.toIso8601String() == null && globals["enddatexk"]?.toIso8601String() != null )
          FilterLabel(
            label: "${formatter.format(globals["enddatexk"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatexk"] = null;
                globals["enddatexk"] = null;
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
        if (globals["startdatexk"]?.toIso8601String() != null && globals["enddatexk"]?.toIso8601String() != null )
          FilterLabel(
            label: "${formatter.format(globals["startdatexk"])} - ${formatter.format(globals["enddatexk"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatexk"] = null;
                globals["enddatexk"] = null;
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
                (globals["moi_tao"] == null || globals["moi_tao"]?.toString() == "false") &&
                    (globals["dang_nhan"] == null || globals["dang_nhan"]?.toString() == "false") &&
                    (globals["da_nhan"] == null || globals["da_nhan"]?.toString() == "false") &&
                    (globals["luu_kho"] == null || globals["luu_kho"]?.toString() == "false") &&
                    (globals["dang_giao"] == null || globals["dang_giao"]?.toString() == "false") &&
                    (globals["cho_giao_lai"] == null || globals["cho_giao_lai"]?.toString() == "false") &&
                    (globals["da_giao"] == null || globals["da_giao"]?.toString() == "false") &&
                    (globals["cho_tra"] == null || globals["cho_tra"]?.toString() == "false") &&
                    (globals["da_tra"] == null || globals["da_tra"]?.toString() == "false") &&
                    (globals["cho_chuyen_cod"] == null || globals["cho_chuyen_cod"]?.toString() == "false") &&
                    (globals["da_chuyen_cod"] == null || globals["da_chuyen_cod"]?.toString() == "false")
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

        if ( globals["dang_giao"] != null &&  globals["dang_giao"]?.toString() != "null" && globals["dang_giao"]?.toString() != "false" )
          FilterLabel(
            label: "đang giao",
            onTap: () {
              setState(() {
                if ( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) < 12 ){
                  // accomodationListData[5].isSelected = false;
                } else if ( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 ){
                  accomodationListData[1].isSelected = false;
                } else {
                  accomodationListData[5].isSelected = false;
                }
                globals["dang_giao"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["cho_giao_lai"] != null &&  globals["cho_giao_lai"]?.toString() != "null" && globals["cho_giao_lai"]?.toString() != "false" )
          FilterLabel(
            label: "chờ xử lý",
            onTap: () {
              setState(() {
                if ( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) < 12 ){
                  // accomodationListData[5].isSelected = false;
                } else if ( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 ){
                  accomodationListData[2].isSelected = false;
                } else {
                  accomodationListData[6].isSelected = false;
                }
                globals["cho_giao_lai"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["da_giao"] != null &&  globals["da_giao"]?.toString() != "null" && globals["da_giao"]?.toString() != "false" )
          FilterLabel(
            label: "đã giao",
            onTap: () {
              setState(() {
                if ( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) < 12 ){
                  // accomodationListData[5].isSelected = false;
                } else if ( int.parse(globals["roles"]) == 7 && int.parse(globals["id"]) > 12 ){
                  accomodationListData[3].isSelected = false;
                } else {
                  accomodationListData[7].isSelected = false;
                }
                globals["da_giao"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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

        if (globals["startdatexk"]?.toIso8601String() != null && globals["enddatexk"]?.toIso8601String() == null )
          FilterLabel(
            label: "${formatter.format(globals["startdatexk"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatexk"] = null;
                globals["enddatexk"] = null;
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
        if (globals["startdatexk"]?.toIso8601String() == null && globals["enddatexk"]?.toIso8601String() != null )
          FilterLabel(
            label: "${formatter.format(globals["enddatexk"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatexk"] = null;
                globals["enddatexk"] = null;
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
        if (globals["startdatexk"]?.toIso8601String() != null && globals["enddatexk"]?.toIso8601String() != null )
          FilterLabel(
            label: "${formatter.format(globals["startdatexk"])} - ${formatter.format(globals["enddatexk"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatexk"] = null;
                globals["enddatexk"] = null;
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
  Widget _renderFilterSortByTagShipNhan() {
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
                (globals["moi_tao"] == null || globals["moi_tao"]?.toString() == "false") &&
                    (globals["dang_nhan"] == null || globals["dang_nhan"]?.toString() == "false") &&
                    (globals["da_nhan"] == null || globals["da_nhan"]?.toString() == "false") &&
                    (globals["luu_kho"] == null || globals["luu_kho"]?.toString() == "false") &&
                    (globals["dang_giao"] == null || globals["dang_giao"]?.toString() == "false") &&
                    (globals["cho_giao_lai"] == null || globals["cho_giao_lai"]?.toString() == "false") &&
                    (globals["da_giao"] == null || globals["da_giao"]?.toString() == "false") &&
                    (globals["cho_tra"] == null || globals["cho_tra"]?.toString() == "false") &&
                    (globals["da_tra"] == null || globals["da_tra"]?.toString() == "false") &&
                    (globals["cho_chuyen_cod"] == null || globals["cho_chuyen_cod"]?.toString() == "false") &&
                    (globals["da_chuyen_cod"] == null || globals["da_chuyen_cod"]?.toString() == "false")
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
        if ( globals["dang_nhan"] != null &&  globals["dang_nhan"]?.toString() != "null" && globals["dang_nhan"]?.toString() != "false" )
          FilterLabel(
            label: "đang nhận",
            onTap: () {
              setState(() {
                accomodationListData[2].isSelected = false;
                globals["dang_nhan"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["da_nhan"] != null &&  globals["da_nhan"]?.toString() != "null" && globals["da_nhan"]?.toString() != "false" )
          FilterLabel(
            label: "đã nhận",
            onTap: () {
              setState(() {
                accomodationListData[3].isSelected = false;
                globals["da_nhan"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["cho_tra"] != null &&  globals["cho_tra"]?.toString() != "null" && globals["cho_tra"]?.toString() != "false" )
          FilterLabel(
            label: "chờ trả",
            onTap: () {
              setState(() {
                accomodationListData[8].isSelected = false;
                globals["cho_tra"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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
        if ( globals["da_tra"] != null &&  globals["da_tra"]?.toString() != "null" && globals["da_tra"]?.toString() != "false" )
          FilterLabel(
            label: "đã trả",
            onTap: () {
              setState(() {
                accomodationListData[9].isSelected = false;
                globals["da_tra"] = null;
                if(
                globals["moi_tao"]?.toString() == "false" &&
                    globals["dang_nhan"]?.toString() == "false" &&
                    globals["da_nhan"]?.toString() == "false" &&
                    globals["luu_kho"]?.toString() == "false" &&
                    globals["dang_giao"]?.toString() == "false" &&
                    globals["cho_giao_lai"]?.toString() == "false" &&
                    globals["da_giao"]?.toString() == "false" &&
                    globals["cho_tra"]?.toString() == "false" &&
                    globals["da_tra"]?.toString() == "false" &&
                    globals["cho_chuyen_cod"]?.toString() == "false" &&
                    globals["da_chuyen_cod"]?.toString() == "false"
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


        if (globals["startdatexk"]?.toIso8601String() != null && globals["enddatexk"]?.toIso8601String() == null )
          FilterLabel(
            label: "${formatter.format(globals["startdatexk"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatexk"] = null;
                globals["enddatexk"] = null;
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
        if (globals["startdatexk"]?.toIso8601String() == null && globals["enddatexk"]?.toIso8601String() != null )
          FilterLabel(
            label: "${formatter.format(globals["enddatexk"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatexk"] = null;
                globals["enddatexk"] = null;
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
        if (globals["startdatexk"]?.toIso8601String() != null && globals["enddatexk"]?.toIso8601String() != null )
          FilterLabel(
            label: "${formatter.format(globals["startdatexk"])} - ${formatter.format(globals["enddatexk"])}",
            onTap: () {
              // filterSortBy = filterSortBy.applyOnSale(null).applyFeatured(null);
              // onFilter();
              setState(() {
                globals["startdatexk"] = null;
                globals["enddatexk"] = null;
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
          builder: (context) => FiltersScreen(),
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
        if (text["mới tạo"]?.toString() == "true"){
          globals["moi_tao"] = "true";
        }
        if (text["đang nhận"]?.toString() == "true"){
          globals["dang_nhan"] = "true";
        }
        if (text["đã nhận"]?.toString() == "true"){
          globals["da_nhan"] = "true";
        }
        if (text["lưu kho"]?.toString() == "true"){
          globals["luu_kho"] = "true";
        }
        if (text["đang giao"]?.toString() == "true"){
          globals["dang_giao"] = "true";
        }
        if (text["chờ xử lý"]?.toString() == "true"){
          globals["cho_giao_lai"] = "true";
        }
        if (text["đã giao"]?.toString() == "true"){
          globals["da_giao"] = "true";
        }
        if (text["chờ trả"]?.toString() == "true"){
          globals["cho_tra"] = "true";
        }
        if (text["đã trả"]?.toString() == "true"){
          globals["da_tra"] = "true";
        }
        if (text["chờ thanh toán"]?.toString() == "true"){
          globals["cho_chuyen_cod"] = "true";
        }
        if (text["đã thanh toán"]?.toString() == "true"){
          globals["da_chuyen_cod"] = "true";
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
      heroTag: "vdshiphoanthien",
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
        accomodationListData.forEach((d) {
          d.isSelected = true;
        });
      } else {
        accomodationListData.forEach((d) {
          d.isSelected = false;
        });
      }
    } else {
      accomodationListData[index].isSelected =
      !accomodationListData[index].isSelected;

      int count = 0;
      for (int i = 0; i < accomodationListData.length; i++) {
        if (i != 0) {
          final PopularFilterListData data = accomodationListData[i];
          if (data.isSelected) {
            count += 1;
          }
        }
      }

      if (count == accomodationListData.length - 1) {
        accomodationListData[0].isSelected = true;
      } else {
        accomodationListData[0].isSelected = false;
      }
    }
  }

}










