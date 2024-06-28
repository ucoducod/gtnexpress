import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'home_page.dart';


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
        this.da_giao,
        this.cho_giao_lai,
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

class Pie extends StatefulWidget {
  const Pie({Key key}) : super(key: key);

  @override
  _PieState createState() => _PieState();
}

class _PieState extends State<Pie> {
  List<Severity> dataList = []; // list of api data
  final storage = const FlutterSecureStorage();


  // bool checkLimit(DateTime limitDay) {
  //   if (limitDay.isBefore(DateTime.now().subtract(Duration(days: 90)))) {
  //     return false;
  //   } else if (limitDay.isAfter( DateTime.now().add(Duration(days: 1)))) {
  //     return false;
  //   }
  //   return true;
  // }
  // DateTimeRange _selectedDateRange = DateTimeRange(
  //   start: DateTime.now().subtract(Duration(days: 90)),
  //   end: DateTime.now(),
  // );
  // // This function will be triggered when the floating button is pressed
  // void _show() async {
  //   final DateTimeRange result = await showDateRangePicker(
  //     context: context,
  //     locale:  Locale("vi", "VN"),
  //     // firstDate: DateTime(2022, 1, 1),
  //     // lastDate: DateTime(2030, 12, 31),
  //     firstDate: _selectedDateRange.start,
  //     lastDate:_selectedDateRange.end,
  //     currentDate: DateTime.now(),
  //     // initialEntryMode: DatePickerEntryMode.calendar,
  //     // initialEntryMode: DatePickerEntryMode.calendar,
  //     saveText: 'Done',
  //   );}




  // DateTimeRange _selectedDateRange;

  // DateTimeRange _selectedDateRange = DateTimeRange(
  //   start: DateTime(2021, 11, 5),
  //   end: DateTime.now(),
  // );
  DateTime firstDayCurrentMonth = DateTime.utc(DateTime.now().year, DateTime.now().month, 1);
  DateTime lastDayCurrentMonth = DateTime.utc(DateTime.now().year, DateTime.now().month + 1).subtract(Duration(days: 1));
  // 1-6 => 30-6 //

  bool first_date_pick = true;
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract( Duration(days: 30)),
    end: DateTime.now(),
  );

  DateTimeRange _firstDateRange = DateTimeRange(
    // start: DateTime.now().subtract( Duration(days: 30)),
    start: DateTime(DateTime.now().year, DateTime.now().month, 1),
    end: DateTime.now(),
  );
  void _show() async {
    // print(firstDayCurrentMonth);
    // print(lastDayCurrentMonth);
    if (first_date_pick) {
      DateTimeRange result = await showDateRangePicker(
        context: context,
        locale: const Locale("vi", "VN"),
        firstDate: DateTime(2024, 5, 1),// firstDayCurrentMonth, //DateTime(2024, 3, 1),
        lastDate: DateTime.now(),// lastDayCurrentMonth, //DateTime.now(),
        currentDate: DateTime.now(),
        initialDateRange: _firstDateRange,
        // saveText: 'Áp Dụng',
      );
      if (result != null) {
        // Rebuild the UI
        setState(() {
          first_date_pick = false;
          _selectedDateRange = result;
          getResponse(_selectedDateRange.start, _selectedDateRange.end);
        });
      }
    } else {
      DateTimeRange result = await showDateRangePicker(
        context: context,
        locale: const Locale("vi", "VN"),
        firstDate: DateTime(2024, 5, 1),
        lastDate: DateTime.now(),
        currentDate: DateTime.now(),
        initialDateRange: _selectedDateRange,
        saveText: 'Done',
      );
      if (result != null) {
        // Rebuild the UI
        setState(() {
          first_date_pick = false;
          _selectedDateRange = result;
          getResponse(_selectedDateRange.start, _selectedDateRange.end);
        });
      }
    }
  }

  var noSimbolInUSFormat = NumberFormat.simpleCurrency(locale: "vi_VN", decimalDigits: 0);
   RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    if (first_date_pick){
      _selectedDateRange = _firstDateRange;
    }
    getResponse(_selectedDateRange.start,_selectedDateRange.end);
    // if (abc == 2) {
    //   print("_onRefresh yes api result");
    //   _refreshController.refreshCompleted();
    // } else {
    //   print("_onRefresh no api result");
    //   _refreshController.refreshFailed();
    // }
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 500));
    // getResponse(_selectedDateRange.start,_selectedDateRange.end);

    if (mounted) {
      setState(() {
        getResponse(_selectedDateRange.start,_selectedDateRange.end);
      });
    }
    // if (abcd == 2) {
    //   print("_onRefresh yes api result");
    //   _refreshController.loadComplete();
    // } else {
    //   print("_onRefresh no api result");
    //   _refreshController.loadNoData();
    // }
    _refreshController.loadComplete();
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // print(dataList);
  }

  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  getResponse(DateTime start,DateTime end) async {
    String your_api_token_here = await storage.read(key: "storagetoken");
    print("Count API DATE RANGE TEST: ${start} => ${end}");
    var url ="https://gtnexpress.vn/api/counttest?start_date=${dateFormat.format(start)}&end_date=${dateFormat.format(end)}"; // your URL must be paste here, it's required
    await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $your_api_token_here',
      },
    ).then(
          (value) {
        // if (dataList.isEmpty) {
        // if list is empty to avoid repetitive data
        if (value.statusCode == 200) {
          // if status of request was ok will continue
          List jsonList =
          convert.jsonDecode(value.body); // this like convert json to list
          if (jsonList.isNotEmpty) {
            // if jsonList wasnt empty which means had data will make data for each json object
            // print(jsonList.toString());
            for (var i = 0; i < jsonList.length; i++) {
              // print(jsonList[i]["moi_tao"]);
              setState(() {
                dataList = [];
                dataList.add(
                  Severity(
                      moi_tao: jsonList[i]["moi_tao"],
                      dang_nhan: jsonList[i]["dang_nhan"],
                      da_nhan: jsonList[i]["da_nhan"],
                      dang_giao: jsonList[i]["dang_giao"],
                      da_giao: jsonList[i]["da_giao"],
                      cho_giao_lai: jsonList[i]["cho_giao_lai"],
                      cho_chuyen_cod: jsonList[i]["cho_chuyen_cod"],
                      da_chuyen_cod: jsonList[i]["da_chuyen_cod"],
                      hoan_tat: jsonList[i]["hoan_tat"],
                      luu_kho: jsonList[i]["luu_kho"],
                      cho_tra: jsonList[i]["cho_tra"],
                      da_tra: jsonList[i]["da_tra"],
                      tong_cuoc: jsonList[i]["tong_cuoc"],
                      tong_thu_cod: jsonList[i]["tong_thu_cod"],
                      tong_tra_cod: jsonList[i]["tong_tra_cod"],
                      tong_cho_tra_cod: jsonList[i]["tong_cho_tra_cod"],
                      tong_don_hang: jsonList[i]["tong_don_hang"],
                      dang_giao_cod: jsonList[i]["dang_giao_cod"]
                  )
                );
              });
            }
            return 1;
          } else {
            dataList.add(
              /// if couldnt catch data, this will make one entry of zero data
              Severity(
                moi_tao: 0,
                dang_nhan: 0,
                da_nhan: 0,
                dang_giao: 0,
                da_giao: 0,
                cho_giao_lai: 0,
                cho_chuyen_cod: 0,
                da_chuyen_cod: 0,
                hoan_tat: 0,
                luu_kho: 0,
                cho_tra: 0,
                da_tra: 0,
                tong_don_hang: 0,
              ),
            );
            return 2;
          }
        }
        return 0;
        // }
      },
    );
  }

  // this will make state when app runs
  @override
  void initState() {
    // print("SET STATE TEST ${_firstDateRange.start},....${_firstDateRange.end}");
    getResponse(_firstDateRange.start,_firstDateRange.end);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Thống kê'),
      //   elevation: 0.0,
      //   backgroundColor: Colors.lightBlueAccent,
      // ),
      body: _buildBody(),

    );
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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(5.0)),
            color: Color(0xFFE9F6EB),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 5.0,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // use whichever suits your need
            children: <Widget>[
              first_date_pick
              ?
                Text(
                  "${_firstDateRange.start.toString().split(' ')[0]} ${_firstDateRange.end.toString().split(' ')[0]}",
                  style: const TextStyle(fontSize: 17, color: Colors.blue,),
                )
              :
                Text(
                  "${_selectedDateRange.start.toString().split(' ')[0]} ${_selectedDateRange.end.toString().split(' ')[0]}",
                  style: const TextStyle(fontSize: 17, color: Colors.blue),
                ),

              const SizedBox(width: 50),
              InkWell(
                onTap: () {  _show(); },
                child: const CircleAvatar(
                  radius: 12.0,
                  backgroundColor: Colors.lightBlueAccent,
                  child: Icon(Icons.date_range,
                      color: Color(0xFFFFFFFF), size: 16),
                ),
              ),

            ],
          ),
        ),
        Expanded(
            child: Scrollbar(
              child: SmartRefresher(
                  enablePullDown: true,
                  header: const WaterDropMaterialHeader(),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus status) {
                      Widget body;
                      if (status == LoadStatus.idle) {
                        body = const Text("pull up load");
                      } else if (status == LoadStatus.loading) {
                        body = const CupertinoActivityIndicator();
                      } else if (status == LoadStatus.failed) {
                        body = const Text("Load Failed!Click retry!");
                      } else if (status == LoadStatus.canLoading) {
                        body = const Text("release to load more");
                      } else {
                        body = const Text("No more Data");
                      }
                      return SizedBox(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: _buildUsersList()),
            )
        ),
      ],
    );
  }
  Widget _buildUsersList() {
    Map<String, double> dataMap = {
      "${dataList.isNotEmpty ? dataList[0].moi_tao.toDouble().toInt() : 0} Mới tạo": dataList.isNotEmpty ? dataList[0].moi_tao.toDouble() : 0,
      // "da_chap_nhan": dataList.isNotEmpty ? dataList[0].da_chap_nhan.toDouble() : 0,
      "${dataList.isNotEmpty ? dataList[0].dang_nhan.toDouble().toInt() : 0} Đang nhận": dataList.isNotEmpty ? dataList[0].dang_nhan.toDouble() : 0,
      // "dang_nhan_lai": dataList.isNotEmpty ? dataList[0].dang_nhan_lai.toDouble() : 0,
      "${dataList.isNotEmpty ? dataList[0].da_nhan.toDouble().toInt() : 0} Đã nhận": dataList.isNotEmpty ? dataList[0].da_nhan.toDouble() : 0,
      "${dataList.isNotEmpty ? dataList[0].dang_giao.toDouble().toInt() : 0} Đang giao": dataList.isNotEmpty ? dataList[0].dang_giao.toDouble() : 0,
      "${dataList.isNotEmpty ? dataList[0].da_giao.toDouble().toInt() : 0} Đã giao": dataList.isNotEmpty ? dataList[0].da_giao.toDouble() : 0,
      "${dataList.isNotEmpty ? dataList[0].cho_giao_lai.toDouble().toInt() : 0} Chờ xử lý": dataList.isNotEmpty ? dataList[0].cho_giao_lai.toDouble() : 0,
      "${dataList.isNotEmpty ? dataList[0].luu_kho.toDouble().toInt() : 0} Lưu kho": dataList.isNotEmpty ? dataList[0].luu_kho.toDouble() : 0,
      "${dataList.isNotEmpty ? dataList[0].cho_tra.toDouble().toInt() : 0} Chờ trả": dataList.isNotEmpty ? dataList[0].cho_tra.toDouble() : 0,
      "${dataList.isNotEmpty ? dataList[0].da_tra.toDouble().toInt() : 0} Đã trả": dataList.isNotEmpty ? dataList[0].da_tra.toDouble() : 0,
      "${dataList.isNotEmpty ? dataList[0].cho_chuyen_cod.toDouble().toInt() : 0} Chờ thanh toán":dataList.isNotEmpty ? dataList[0].cho_chuyen_cod.toDouble() : 0,
      "${dataList.isNotEmpty ? dataList[0].da_chuyen_cod.toDouble().toInt() : 0} Đã thanh toán":dataList.isNotEmpty ? dataList[0].da_chuyen_cod.toDouble() : 0,
      // "${dataList.isNotEmpty ? dataList[0].hoan_tat.toDouble().toInt() : 0} Hoàn tất": dataList.isNotEmpty ? dataList[0].hoan_tat.toDouble() : 0,
    };
    Map<String, double> dataMap2 = {
      "Đang giao: ${noSimbolInUSFormat.format(dataList.isNotEmpty ? dataList[0].dang_giao_cod : 0)}": dataList.isNotEmpty ? dataList[0].dang_giao_cod: 0,
      "Tổng cước: ${noSimbolInUSFormat.format(dataList.isNotEmpty ? dataList[0].tong_cuoc : 0)}": dataList.isNotEmpty ? dataList[0].tong_cuoc : 0,
      "Tổng thu: ${noSimbolInUSFormat.format(dataList.isNotEmpty ? dataList[0].tong_thu_cod : 0)}": dataList.isNotEmpty ? dataList[0].tong_thu_cod: 0,
      "Chờ trả: ${noSimbolInUSFormat.format(dataList.isNotEmpty ? dataList[0].tong_cho_tra_cod : 0)}":dataList.isNotEmpty ? dataList[0].tong_cho_tra_cod : 0,
      "Đã trả: ${noSimbolInUSFormat.format(dataList.isNotEmpty ? dataList[0].tong_tra_cod : 0)}":dataList.isNotEmpty ? dataList[0].tong_tra_cod : 0,
    };
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.pie_chart_outline_sharp),
                title:
                Text('Trạng thái: (Tổng đơn ${dataList[0].tong_don_hang ?? 0})'),
                // trailing: Icon(Icons.more_vert),
                dense: false,
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  color: Colors.transparent,
                  child: PieChart(
                    dataMap: dataMap, // this need to be map for piechart
                    animationDuration: const Duration(milliseconds: 800),
                    // chartLegendSpacing: 40,
                    chartLegendSpacing: 50,
                    initialAngleInDegree: 0,
                    // chartType: ChartType.disc,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 30,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 0,
                    ),
                  ),
                ),
              ),
            ),
            // Divider(color: Colors.green,),

            // Container(child: const Text("Công nợ"),),
            Card(
              child: ListTile(
                leading: const Icon(Icons.monetization_on_outlined),
                title: Text('Công nợ: Tổng tiền ${noSimbolInUSFormat.format( dataList[0].tong_cuoc ?? 0) }'),
                dense: false,
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  color: Colors.transparent,
                  child: PieChart(
                    dataMap: dataMap2, // this need to be map for piechart
                    animationDuration: const Duration(milliseconds: 800),
                    // chartLegendSpacing: 40,
                    chartLegendSpacing: 50,
                    initialAngleInDegree: 0,
                    // chartType: ChartType.disc,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 30,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                    ),
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 0,
                    ),
                  ),
                ),
              ),
            ),
            // if (dataList[0].moi_tao != null && dataList[0].moi_tao != 0)
            //   Card(
            //     child: ListTile(
            //       title: Text('Đơn mới tạo: ${dataList[0].moi_tao ?? 0}'),
            //       trailing: const Icon(Icons.arrow_forward),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     HomePageDanggiao(recordObject: 1)));
            //       },
            //       dense: true,
            //     ),
            //   )
            // else
            //   const SizedBox(height: 0.0),
            // if (dataList[0].dang_nhan != null && dataList[0].dang_nhan != 0)
            //   Card(
            //     child: ListTile(
            //       title: Text('Đơn đang nhận: ${dataList[0].dang_nhan ?? 0}'),
            //       trailing: const Icon(Icons.arrow_forward),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     HomePageDanggiao(recordObject: 2)));
            //       },
            //       dense: true,
            //     ),
            //   )
            // else
            //   const SizedBox(height: 0.0),
            // if (dataList[0].da_nhan != null && dataList[0].da_nhan != 0)
            //   Card(
            //     child: ListTile(
            //       title: Text('Đơn đã nhận: ${dataList[0].da_nhan ?? 0}'),
            //       trailing: const Icon(Icons.arrow_forward),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     HomePageDanggiao(recordObject: 4)));
            //       },
            //       dense: true,
            //     ),
            //   )
            // else
            //   const SizedBox(height: 0.0),
            // if (dataList[0].luu_kho != null && dataList[0].luu_kho != 0)
            //   Card(
            //     child: ListTile(
            //       title: Text('Đơn lưu kho: ${dataList[0].luu_kho ?? 0}'),
            //       trailing: const Icon(Icons.arrow_forward),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     HomePageDanggiao(recordObject: 13)));
            //       },
            //       dense: true,
            //     ),
            //   )
            // else
            //   const SizedBox(height: 0.0),
            // if (dataList[0].dang_giao != null && dataList[0].dang_giao != 0)
            //   Card(
            //     child: ListTile(
            //       title: Text('Đơn đang giao: ${dataList[0].dang_giao ?? 0}'),
            //       trailing: const Icon(Icons.arrow_forward),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     HomePageDanggiao(recordObject: 5)));
            //       },
            //       dense: true,
            //     ),
            //   )
            // else
            //   const SizedBox(height: 0.0),
            // if (dataList[0].da_giao != null && dataList[0].da_giao != 0)
            //   Card(
            //     child: ListTile(
            //       title: Text('Đơn đã giao: ${dataList[0].da_giao ?? 0}'),
            //       trailing: const Icon(Icons.arrow_forward),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     HomePageDanggiao(recordObject: 7)));
            //       },
            //       dense: true,
            //     ),
            //   )
            // else
            //   const SizedBox(height: 0.0),
            // if (dataList[0].da_tra != null && dataList[0].da_tra != 0)
            //   Card(
            //     child: ListTile(
            //       title: Text('Đơn đã trả: ${dataList[0].da_tra ?? 0}'),
            //       trailing: const Icon(Icons.arrow_forward),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     HomePageDanggiao(recordObject: 9)));
            //       },
            //       dense: true,
            //     ),
            //   )
            // else
            //   const SizedBox(height: 0.0),
            // if (dataList[0].cho_chuyen_cod != null &&
            //     dataList[0].cho_chuyen_cod != 0)
            //   Card(
            //     child: ListTile(
            //       title:
            //       Text('Đơn chờ t/t: ${dataList[0].cho_chuyen_cod ?? 0}'),
            //       trailing: const Icon(Icons.arrow_forward),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     HomePageDanggiao(recordObject: 10)));
            //       },
            //       dense: true,
            //     ),
            //   )
            // else
            //   const SizedBox(height: 0.0),
            // if (dataList[0].da_chuyen_cod != null &&
            //     dataList[0].da_chuyen_cod != 0)
            //   Card(
            //     child: ListTile(
            //       title: Text('Đơn đã t/t COD: ${dataList[0].da_chuyen_cod ?? 0}'),
            //       trailing: const Icon(Icons.arrow_forward),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     HomePageDanggiao(recordObject: 11)));
            //       },
            //       dense: true,
            //     ),
            //   )
            // else
            //   const SizedBox(height: 0.0),
            // if (dataList[0].hoan_tat != null && dataList[0].hoan_tat != 0)
            //   Card(
            //     child: ListTile(
            //       title: Text('Đơn hoàn tất: ${dataList[0].hoan_tat ?? 0}'),
            //       trailing: const Icon(Icons.arrow_forward),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) =>
            //                     HomePageDanggiao(recordObject: 12)));
            //       },
            //       dense: true,
            //     ),
            //   )
            // else
            //   const SizedBox(height: 0.0),
          ],
        );
      },
    );
  }
}