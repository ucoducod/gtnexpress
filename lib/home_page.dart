// import 'dart:ffi';
// ignore_for_file: must_be_immutable

import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:GTNexpress/main_screen.dart';
import 'package:GTNexpress/web_page.dart';
import 'package:flutter/services.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:timelines/timelines.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';
import 'vandon.dart';
class SerialModal {
  String serialNo;
  bool active;
  String contactAddress;
  dynamic contactCity;
  String contactName;
  String contactPhoneNo;
  String createdBy;
  DateTime createdOn;
  String dealerId;
  dynamic description;
  DateTime manufacturedDate;
  String modelNo;
  String modifiedBy;
  DateTime modifiedOn;
  String productGroupCode;
  String serviceGroupCode;
  DateTime warrantyActiveDate;
  DateTime warrantyEndDate;
  bool commissionPaid;
  int commissionPaidAmount;
  dynamic commissionPaidDate;
  bool warrantyActivatedByDealer;
  String contactDistrict;
  int id;
  int status;
  Dealer serviceGroup;
  Dealer productGroup;
  Dealer dealer;

  SerialModal({
    this.serialNo,
    this.active,
    this.contactAddress,
    this.contactCity,
    this.contactName,
    this.contactPhoneNo,
    this.createdBy,
    this.createdOn,
    this.dealerId,
    this.description,
    this.manufacturedDate,
    this.modelNo,
    this.modifiedBy,
    this.modifiedOn,
    this.productGroupCode,
    this.serviceGroupCode,
    this.warrantyActiveDate,
    this.warrantyEndDate,
    this.commissionPaid,
    this.commissionPaidAmount,
    this.commissionPaidDate,
    this.warrantyActivatedByDealer,
    this.contactDistrict,
    this.id,
    this.status,
    this.serviceGroup,
    this.productGroup,
    this.dealer,
  });

  factory SerialModal.fromRawJson(String str) => SerialModal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SerialModal.fromJson(Map<String, dynamic> json) => SerialModal(
    serialNo: json["serialNo"],
    active: json["active"],
    contactAddress: json["contactAddress"],
    contactCity: json["contactCity"],
    contactName: json["contactName"],
    contactPhoneNo: json["contactPhoneNo"],
    createdBy: json["createdBy"],
    createdOn: DateTime.parse(json["createdOn"]),
    dealerId: json["dealerId"],
    description: json["description"],
    manufacturedDate: DateTime.parse(json["manufacturedDate"]),
    modelNo: json["modelNo"],
    modifiedBy: json["modifiedBy"],
    modifiedOn: DateTime.parse(json["modifiedOn"]),
    productGroupCode: json["productGroupCode"],
    serviceGroupCode: json["serviceGroupCode"],
    warrantyActiveDate: DateTime.parse(json["warrantyActiveDate"]),
    warrantyEndDate: DateTime.parse(json["warrantyEndDate"]),
    commissionPaid: json["commissionPaid"],
    commissionPaidAmount: json["commissionPaidAmount"],
    commissionPaidDate: json["commissionPaidDate"],
    warrantyActivatedByDealer: json["warrantyActivatedByDealer"],
    contactDistrict: json["contactDistrict"],
    id: json["id"],
    status: json["status"],
    serviceGroup: Dealer.fromJson(json["serviceGroup"]),
    productGroup: Dealer.fromJson(json["productGroup"]),
    dealer: Dealer.fromJson(json["dealer"]),
  );

  Map<String, dynamic> toJson() => {
    "serialNo": serialNo,
    "active": active,
    "contactAddress": contactAddress,
    "contactCity": contactCity,
    "contactName": contactName,
    "contactPhoneNo": contactPhoneNo,
    "createdBy": createdBy,
    "createdOn": createdOn.toIso8601String(),
    "dealerId": dealerId,
    "description": description,
    "manufacturedDate": manufacturedDate.toIso8601String(),
    "modelNo": modelNo,
    "modifiedBy": modifiedBy,
    "modifiedOn": modifiedOn.toIso8601String(),
    "productGroupCode": productGroupCode,
    "serviceGroupCode": serviceGroupCode,
    "warrantyActiveDate": warrantyActiveDate.toIso8601String(),
    "warrantyEndDate": warrantyEndDate.toIso8601String(),
    "commissionPaid": commissionPaid,
    "commissionPaidAmount": commissionPaidAmount,
    "commissionPaidDate": commissionPaidDate,
    "warrantyActivatedByDealer": warrantyActivatedByDealer,
    "contactDistrict": contactDistrict,
    "id": id,
    "status": status,
    "serviceGroup": serviceGroup.toJson(),
    "productGroup": productGroup.toJson(),
    "dealer": dealer.toJson(),
  };
}

class Dealer {
  String code;
  String commissionGroupId;
  String name;
  String id;
  String serviceGroupCode;

  Dealer({
    this.code,
    this.commissionGroupId,
    this.name,
    this.id,
    this.serviceGroupCode,
  });

  factory Dealer.fromJson(Map<String, dynamic> data) {
    if (data == null) {
      // throw FormatException('Invalid JSON: required "NULLLLL $data');
      return Dealer(code: "NA", name: "NA",commissionGroupId:"NA",id:"NA",serviceGroupCode:"NA");
    } else {
      return Dealer(code: data["code"], name: data["name"],commissionGroupId: data["commissionGroupId"], id: data["id"],serviceGroupCode: data["serviceGroupCode"]);
    }
  }

  String toRawJson() => json.encode(toJson());

  // factory Dealer.fromJson(Map<String, dynamic> json) => Dealer(
  //   code: json["code"],
  //   commissionGroupId: json["commissionGroupId"],
  //   name: json["name"],
  //   id: json["id"],
  //   serviceGroupCode: json["serviceGroupCode"],
  // );

  Map<String, dynamic> toJson() => {
    "code": code,
    "commissionGroupId": commissionGroupId,
    "name": name,
    "id": id,
    "serviceGroupCode": serviceGroupCode,
  };
}


class HomePageDanggiao extends StatefulWidget {
  final int recordObject;

  HomePageDanggiao({Key key, @required this.recordObject}) : super(key: key);

  @override
  _HomePageDanggiaoState createState() => _HomePageDanggiaoState();
}

class _HomePageDanggiaoState extends State<HomePageDanggiao> {
  int recordObject;
  var title_x = 'Vận đơn: ';
  List<Vandon> _searchResult = [];
  // List<Vandon> _userDetails = [];
  List<Vandon> vandons = [];
  TextEditingController controller = TextEditingController();
  bool loading = true;
  bool vdempty = true;

  // final  url = 'https://gtnexpress.vn/api/vdallapi?status_filter=${recordObject}';
  methodname(num radians) {
    // you can adjust this values according to your accuracy requirements
    // const myPI = 3142;
    int r = radians;

    switch (r) {
      case 0:
        return "Tất cả";
        break;
      case 1:
        return "Mới tạo";
        break;
      case 2:
        return "Đang nhận";
        break;
      case 3:
        return "Hủy";
        break;
      case 4:
        return "Đã nhận";
        break;
      case 5:
        return "Đang giao";
        break;
      case 6:
        return "Chờ xử lý";
        break;
      case 7:
        return "Đã giao";
        break;
      case 8:
        return "Chờ trả";
        break;
      case 9:
        return "Đã trả hàng";
        break;
      case 10:
        return "Chờ chuyển COD";
        break;
      case 11:
        return "Đã chuyển COD";
        break;
      case 12:
        return "Hoàn tất";
        break;
      case 13:
        return "Lưu kho";
        break;
      case 14:
        return "Đã chấp nhận";
        break;
      default:
        return "Error";
    }
  }

  var client = http.Client();
  final storage = const FlutterSecureStorage();



  //Implement Date time range
  bool first_date_pick = true;
  DateTimeRange _selectedDateRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 90)),
    end: DateTime.now(),
  );
  DateTimeRange _firstDateRange = DateTimeRange(
    start: DateTime.now().subtract(Duration(days: 7)),
    end: DateTime.now(),
  );
  void _show() async {
    if (first_date_pick) {
      DateTimeRange result = await showDateRangePicker(
        context: context,
        locale: const Locale("vi", "VN"),
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime.now(),
        currentDate: DateTime.now(),
        initialDateRange: _firstDateRange,
        // saveText: 'Done',
      );
      if (result != null) {
        // Rebuild the UI
        setState(() {
          first_date_pick = false;
          _selectedDateRange = result;
          // print(result.start.toString());
          // print(result.end.toString());
          getUserDetailsDate(_selectedDateRange.start,_selectedDateRange.end);
        });
      }
    } else {
      DateTimeRange result = await showDateRangePicker(
        context: context,
        locale: const Locale("vi", "VN"),
        firstDate: DateTime(2022, 1, 1),
        lastDate: DateTime.now(),
        // firstDate: _selectedDateRange.start,
        // lastDate: _selectedDateRange.end,
        currentDate: DateTime.now(),
        initialDateRange: _selectedDateRange,
        // saveText: 'Done',
      );
      if (result != null) {
        // Rebuild the UI
        setState(() {
          first_date_pick = false;
          _selectedDateRange = result;
          // print(result.start.toString());
          // print(result.end.toString());
          getUserDetailsDate(_selectedDateRange.start, _selectedDateRange.end);
        });
      }
    }
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // _userDetails = [];
    vandons.clear();
    vdempty = true;
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // getUserDetails();
    if (first_date_pick){
      _selectedDateRange = _firstDateRange;
    }
    getUserDetailsDate(_selectedDateRange.start,_selectedDateRange.end);//change range
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // print(vandons);
    if (mounted) {
      setState(() {
        recordObject = widget.recordObject;
        // getUserDetails();
        // print("SET STATE TEST OnLoading ${_selectedDateRange.start},....${_selectedDateRange.end}");
        getUserDetailsDate(_selectedDateRange.start,_selectedDateRange.end);//change range
      });
    }
    _refreshController.loadComplete();
  }

  // Get json result and convert it to model. Then add
  Future<void> getUserDetails() async {
    String your_api_token_here = await storage.read(key: "storagetoken");
    // print("VandonPage: $your_api_token_here #'https://gtnexpress.vn/api/vdallapi?status_filter=${recordObject}'");
    http.Response response = await client.get(
      Uri.parse(
          'https://gtnexpress.vn/api/vdallapi?status_filter=$recordObject'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $your_api_token_here',
      },
    );
    if (response.statusCode == 200) {
      // Connection Ok
      List responseJson = json.decode(response.body);
      // print(responseJson);
      vandons = [];
      _searchResult = [];
      responseJson.map((m) => vandons.add(Vandon.fromJson(m))).toList();
      setState(() {
        loading = false;
        // if (widget.recordObject == 0 || widget.recordObject == null){
        //   title_x = title_x+'tất cả';
        // } else {
        //   title_x = title_x+methodname(widget.recordObject);
        // }
      });
    } else {
      throw ('error');
    }
  }

  // Date_range
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  Future<void> getUserDetailsDate(DateTime start,DateTime end) async {
    print("Count API DATE RANGE TEST: ${start} => ${end}");
    String your_api_token_here = await storage.read(key: "storagetoken");
    // print("VandonPageRange: $your_api_token_here #'https://gtnexpress.vn/api/vdallapi?status_filter=${recordObject}&start_date=${dateFormat.format(start)}&end_date=${dateFormat.format(end)}'");
    http.Response response = await client.get(
      Uri.parse(
          'https://gtnexpress.vn/api/vdallapi?status_filter=$recordObject&start_date=${dateFormat.format(start)}&end_date=${dateFormat.format(end)}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $your_api_token_here',
      },
    );
    if (response.statusCode == 200) {
      // Connection Ok
      List responseJson = json.decode(response.body);
      // print(responseJson.length);
      vandons = [];
      _searchResult = [];
      responseJson.map((m) => vandons.add(Vandon.fromJson(m))).toList();
      setState(() {
        loading = false;
        // if (widget.recordObject == 0 || widget.recordObject == null){
        //   title_x = title_x+'tất cả';
        // } else {
        //   title_x = title_x+methodname(widget.recordObject);
        // }
      });
    } else {
      throw ('error');
    }
  }

  Future<bool> deleteVandon(int id) async {
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    // print("DeleteVandonPage: $yourApiTokenHere #'https://gtnexpress.vn/api/vandon_delete/${id}'");
    http.Response response = await client.put(
      Uri.parse('https://gtnexpress.vn/api/vandon_delete/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $yourApiTokenHere',"content-type": "application/json"
      },
    );
    // final response = await client.put(
    //   "https://gtnexpress.vn/api/vandon_delete/${id}",
    //   headers: {"content-type": "application/json"}
    // );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    recordObject = widget.recordObject;
    // getUserDetails();
    // print("SET STATE TEST ${_firstDateRange.start},....${_firstDateRange.end}");
    getUserDetailsDate(_firstDateRange.start,_firstDateRange.end);//change range
    super.initState();
    if (widget.recordObject != null) {
      title_x = title_x+methodname(widget.recordObject);
    } else {
      title_x = 'Tất cả vận đơn';
    }
    // recordObject = widget.recordObject;
  }

  Widget _buildUsersList() {
    return ListView.builder(
      itemCount: vandons.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Expanded(
                    //   flex: 1,
                    //   child: Text("Dang giao"),
                    // ),
                    Expanded(
                      flex: 4,
                      child: VideoDescription(
                        vandon: vandons[index],
                        // trackid: vandons[index].trackid,
                        // trackstatus: vandons[index].status,
                        // receiverPhone: vandons[index].receiverPhone,
                        // receiverName: vandons[index].receiverName+vandons[index].receiverAddress,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                    vandons[index].statusFilter == 1
                    ?
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 16.0,
                              color: Colors.green[900],
                            ),
                            onPressed: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => WebViewEdit(recordObject: vandons[index].id) ));
                            },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.dangerous,
                            size: 16.0,
                            color: Colors.brown[900],
                          ),
                          onPressed: () {
                            // setState(() {
                            //   showAlertDialog(context, 'Are you sure you want to delete?', "AppName" , "Ok", "Cancel", vandons[index].id);
                            //   vandons.removeAt(index);
                            // });
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text('Xóa vận đơn này?'),
                                    actions: [
                                          TextButton(
                                            // onPressed: (_) => Navigator.pop(context, true), // passing true
                                            onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
                                            child: const Text('Xóa',style: TextStyle(color: Colors.red)),
                                          ),
                                          TextButton(
                                            // onPressed: () => Navigator.pop(context, false),
                                            onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
                                            child: const Text('Không'),
                                          ),

                                        ],
                                      );
                                      }).then((exit) {
                                    if (exit == null) return;
                                    if (exit) {
                                      // user pressed Yes button
                                      // print("yes");
                                      setState(() {
                                        deleteVandon(vandons[index].id).then((isSuccess) {
                                          if (isSuccess) {
                                            // print("Đã xóa");
                                            _onRefresh();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Đã xóa'),
                                              ),
                                            );
                                          } else {
                                            // print("Khộng thành công");
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Không thành công'),
                                              ),
                                            );
                                          }
                                        });});


                                    } else {
                                      // print("no");
                                      // user pressed No button
                                    }
                                  });
                          }
                          // onPressed: () {
                          //   setState(() {
                          //     deleteVandon(vandons[index].id).then((isSuccess) {
                          //       if (isSuccess) {
                          //         print("Xoa thanh cong");
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           const SnackBar(
                          //             content: Text('Xóa thành công'),
                          //           ),
                          //         );
                          //       } else {
                          //         print("Xoa khong thanh cong");
                          //         ScaffoldMessenger.of(context).showSnackBar(
                          //           const SnackBar(
                          //             content: Text('Xóa không thành công'),
                          //           ),
                          //         );
                          //       }
                          //     });});
                          // }
                        )
                      ]
                    )
                    :
                    IconButton(
                      icon: Icon(
                        Icons.place_outlined,
                        size: 16.0,
                        color: Colors.brown[900],
                      ),
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailTrack(vandons[index].id)));
                      },
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                    IconButton(
                      icon: Icon(
                        Icons.chevron_right,
                        size: 18.0,
                        color: Colors.brown[900],
                      ),
                      onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailPage(vandons[index])));
                      },
                    ),
                  ],
                ),
              ),
              Container(height: 5, color: Colors.blue[50])
            ]
            )
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
        itemCount: _searchResult.length,
        itemBuilder: (context, index) {
          // return Card(
          //     color: Colors.white,
          //     child: _searchResult[index].statusFilter == 0 ? ListTile(
          //       contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          //       leading: Container(
          //         padding: EdgeInsets.all( 0.0),
          //         child: IconButton(
          //           icon: Icon(
          //             Icons.dangerous,
          //             size: 20.0,
          //             color: Colors.brown[900],
          //           ),
          //           onPressed: () {
          //             // Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(vandons[index])));
          //           },
          //         ),
          //       ),
          //       title: Text("${_searchResult[index].status}"),
          //       subtitle:  Text(
          //         _searchResult[index].trackid,
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 18.0,
          //             fontWeight: FontWeight.bold
          //         ),
          //       ),
          //       trailing: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: <Widget>[
          //           IconButton(
          //             icon: Icon(
          //               Icons.place_outlined,
          //               size: 20.0,
          //               color: Colors.brown[900],
          //             ),
          //             onPressed: () {
          //               Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailTrack(_searchResult[index])));
          //             },
          //           ),
          //           IconButton(
          //             icon: Icon(
          //               Icons.chevron_right,
          //               size: 20.0,
          //               color: Colors.brown[900],
          //             ),
          //             onPressed: () {
          //               Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(_searchResult[index])));
          //             },
          //           ),
          //         ],
          //       ),
          //     ) : ListTile(
          //       contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          //       title: Text("${_searchResult[index].status}"),
          //       subtitle:  Text(
          //         _searchResult[index].trackid,
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 18.0,
          //             fontWeight: FontWeight.bold
          //         ),
          //       ),
          //       trailing: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: <Widget>[
          //           IconButton(
          //             icon: Icon(
          //               Icons.place_outlined,
          //               size: 20.0,
          //               color: Colors.brown[900],
          //             ),
          //             onPressed: () {
          //               Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailTrack(_searchResult[index])));
          //             },
          //           ),
          //           IconButton(
          //             icon: Icon(
          //               Icons.chevron_right,
          //               size: 20.0,
          //               color: Colors.brown[900],
          //             ),
          //             onPressed: () {
          //               Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(_searchResult[index])));
          //             },
          //           ),
          //         ],
          //       ),
          //     ),
          //   );
          return Center(
              child: Column(children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: VideoDescription(
                          vandon: _searchResult[index],
                          // trackid: _searchResult[index].trackid,
                          // trackstatus: _searchResult[index].status,
                          // receiverPhone: _searchResult[index].receiverPhone,
                          // receiverName: _searchResult[index].receiverName+_searchResult[index].receiverAddress,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                      _searchResult[index].statusFilter == 1
                      ?
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                size: 16.0,
                                color: Colors.green[900],
                              ),
                              onPressed: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => WebViewEdit(recordObject: _searchResult[index].id) ));
                              },
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.dangerous,
                                  size: 16.0,
                                  color: Colors.brown[900],
                                ),
                                onPressed: () {
                                  // setState(() {
                                  //   showAlertDialog(context, 'Are you sure you want to delete?', "AppName" , "Ok", "Cancel", vandons[index].id);
                                  //   vandons.removeAt(index);
                                  // });
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: const Text('Xóa vận đơn này?'),
                                          actions: [
                                            TextButton(
                                              // onPressed: (_) => Navigator.pop(context, true), // passing true
                                              onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
                                              child: const Text('Xóa',style: TextStyle(color: Colors.red)),
                                            ),
                                            TextButton(
                                              // onPressed: () => Navigator.pop(context, false),
                                              onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
                                              child: const Text('Không'),
                                            ),

                                          ],
                                        );
                                      }).then((exit) {
                                    if (exit == null) return;
                                    if (exit) {
                                      // user pressed Yes button
                                      // print("yes");
                                      setState(() {
                                        deleteVandon(_searchResult[index].id).then((isSuccess) {
                                          if (isSuccess) {
                                            // print("Đã xóa");
                                            _onRefresh();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Đã xóa'),
                                              ),
                                            );
                                          } else {
                                            // print("Khộng thành công");
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Không thành công'),
                                              ),
                                            );
                                          }
                                        });});


                                    } else {
                                      // print("no");
                                      // user pressed No button
                                    }
                                  });
                                }
                            )
                          ]
                      )
                      :
                      IconButton(
                        icon: Icon(
                          Icons.place_outlined,
                          size: 16.0,
                          color: Colors.brown[900],
                        ),
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailTrack(vandons[index].id)));
                        },
                      ),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
                      IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          size: 18.0,
                          color: Colors.brown[900],
                        ),
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailPage(_searchResult[index])));
                        },
                      ),
                      // const Icon(
                      //   Icons.pin_drop_outlined,
                      //   size: 16.0,
                      // ),
                    ],
                  ),
              ),
              Container(height: 5, color: Colors.blue[50])
          ]));
          // Card(color: Colors.white,
          //   child: _searchResult[index].statusFilter == 0 ?
          //      Container(
          //         margin: EdgeInsets.all(8.0),
          //         child: Column(
          //           children: <Widget>[
          //             Text(" ${_searchResult[index].trackid}"),
          //             Text("Nguoi nhan: ${_searchResult[index].receiverName}"),
          //             Text("Phone: ${_searchResult[index].receiverPhone}"),
          //             Text("Thu Cod: ${_searchResult[index].priceCod}"),
          //           ],
          //         ),
          //       )
          //     :
          //       Container(
          //       margin: EdgeInsets.all(8.0),
          //       child: Column(
          //         children: <Widget>[
          //           Text(" ${_searchResult[index].trackid}"),
          //           Text("Nguoi nhan: ${_searchResult[index].receiverName}"),
          //           Text("Phone: ${_searchResult[index].receiverPhone}"),
          //           Text("Thu Cod: ${_searchResult[index].priceCod}"),
          //         ],
          //       ),
          //     ),
          // );
        });
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.search),
          title: TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: 'Tìm kiếm', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.cancel_outlined),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[

        Container(
          margin: const EdgeInsets.all(0.0),
          padding: const EdgeInsets.all(0.0),
          // decoration: BoxDecoration(
          //     border: Border.all(color: Colors.blueAccent)
          // ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10.0)),
            color: Colors.white,
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
                "Từ ${_firstDateRange.start.toString().split(' ')[0]} đến ${_firstDateRange.end.toString().split(' ')[0]}",
                style: const TextStyle(fontSize: 14, color: Colors.blue),
              )
                  :
              Text(
                "Từ ${_selectedDateRange.start.toString().split(' ')[0]} đến ${_selectedDateRange.end.toString().split(' ')[0]}",
                style: const TextStyle(fontSize: 14, color: Colors.blue),
              ),

              Text(
                "Tổng: ${vandons.length}",
                style: const TextStyle(fontSize: 14, color: Colors.blue),
              ),
              // IconButton(
              //   icon: Icon(Icons.calendar_today),
              //   tooltip: 'Tap to open date picker',
              //   onPressed: () { return _show(); },
              // ),
              // FlatButton.icon(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: new BorderRadius.circular(18.0),
              //       side: BorderSide(color: Colors.red)),
              //   color: Colors.red,
              //   label: Text("Date"),
              //   icon: Icon(Icons.arrow_forward ),
              //   onPressed: () {
              //     //some function
              //   },
              // ),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.date_range,
                  color: Colors.white,
                ),
                onPressed: () {  _show(); },
                label: const Text(
                  "Ngày",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent,
                  fixedSize: const Size(88, 15),
                ),
              ),
            ],
          ),
        ),

        Container(
            color: Theme.of(context).primaryColorLight,
            child: _buildSearchBox()),
        Expanded(
            child: _searchResult.isNotEmpty ||
                    (controller.text.isNotEmpty && controller.text.length > 4)
                ? Scrollbar(
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
                        child: _buildSearchResults()),
                  )
                : Scrollbar(
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
                  )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   initialIndex: 1,
    //   length: 3,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       title: const Text('TabBar Widget'),
    //       bottom: const TabBar(
    //         tabs: <Widget>[
    //           Tab(
    //             icon: Icon(Icons.cloud_outlined),
    //           ),
    //           Tab(
    //             icon: Icon(Icons.beach_access_sharp),
    //           ),
    //           Tab(
    //             icon: Icon(Icons.brightness_5_sharp),
    //           ),
    //         ],
    //       ),
    //     ),
    //     body: const TabBarView(
    //       children: <Widget>[
    //         Center(
    //           child: Text("It's cloudy here"),
    //         ),
    //         Center(
    //           child: Text("It's rainy here"),
    //         ),
    //         Center(
    //           child: Text("It's sunny here"),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text(title_x),
        elevation: 0.0,
        backgroundColor: Colors.lightBlueAccent,
      ),
      // drawer: SideMenu(),
      body: _buildBody(),
      // resizeToAvoidBottomPadding: true,
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var userDetail in vandons) {
      String textup = text.toUpperCase();
      String textlo = text.toLowerCase();
      String textfirst = text[0].toUpperCase();
      if (textup.length > 2) {
        textfirst = textfirst + textlo.substring(1);
      }
      if ((textup.length > 4 && userDetail.trackid.contains(textup) ||
              (userDetail.receiverPhone != null &&
                  userDetail.receiverPhone.contains(text)) ||
              (userDetail.receiverName != null &&
                  userDetail.receiverName.contains(textup))) ||
          (textlo.length > 4 && userDetail.trackid.contains(textlo) ||
              (userDetail.receiverPhone != null &&
                  userDetail.receiverPhone.contains(text)) ||
              (userDetail.receiverName != null &&
                  userDetail.receiverName.contains(textlo))) ||
          (textfirst.length > 4 && userDetail.trackid.contains(textfirst) ||
              (userDetail.receiverPhone != null &&
                  userDetail.receiverPhone.contains(text)) ||
              (userDetail.receiverName != null &&
                  userDetail.receiverName.contains(textfirst)))) {
        _searchResult.add(userDetail);
      }
      // print("Seach result: ${userDetail.trackid}");
    }
    setState(() {});
  }
}

showAlertDialog(BuildContext context, String message, String heading,String buttonAcceptTitle, String buttonCancelTitle, int iddelete) {

  var client = http.Client();
  const storage = FlutterSecureStorage();
  Future<bool> deleteVandon(int id) async {
    String your_api_token_here = await storage.read(key: "storagetoken");
    // print("DeleteVandonPage: $your_api_token_here #'https://gtnexpress.vn/api/vandon_delete/$id'");
    http.Response response = await client.put(
      Uri.parse('https://gtnexpress.vn/api/vandon_delete/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $your_api_token_here',"content-type": "application/json"
      },
    );
    // final response = await client.put(
    //   "https://gtnexpress.vn/api/vandon_delete/${id}",
    //   headers: {"content-type": "application/json"}
    // );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(buttonCancelTitle),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop(); // dismisses only the dialog and returns nothing
    },
  );
  Widget continueButton = TextButton(
    child: Text(buttonAcceptTitle),
    onPressed: () {
      deleteVandon(iddelete).then((isSuccess) {
        if (isSuccess) {
          // print("Xoa thanh cong");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Xóa thành công'),
            ),
          );
          Navigator.of(context, rootNavigator: true).pop();
        } else {
          // print("Xoa khong thanh cong");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Xóa không thành công'),
            ),
          );
          Navigator.of(context, rootNavigator: true).pop();
        }
      }
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(heading),
    content: Text(message),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// List<Vandons> vandonsFromJson(String str) => List<Vandons>.from(json.decode(str).map((x) => Vandons.fromJson(x)));
// String vandonsToJson(List<Vandons> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
// class Vandons {
//   Vandons({
//     this.id,
//     this.dt,
//     this.trackid,
//     this.trackidshop,
//     this.status,
//     this.sender_name,
//     // this.website,
//     // this.company,
//   });
//
//   String date_filter;
//   String dt;
//   int id;
//   Float kg;
//   String note;
//   Float phaithu;
//   Float phaitra;
//   Float price_cod;
//   Float price_fee;
//   String product_content;
//   Float product_value;
//   Float ptkh;
//   String receiver_district_id;
//   String receiver_name;
//   String sender_date_create;
//   String sender_name;
//   String sercice;
//   String status;
//   int status_filter;
//   String trackid;
//   String trackidshop;
//   String trackidx;
//   String tt;
//   String yckp;
//
//   factory Vandons.fromJson(Map<String, dynamic> json) => Vandons(
//     id: json["id"],
//     dt: json["dt"],
//     trackid: json["trackid"],
//     trackidshop: json["trackidshop"],
//     // address: Address.fromJson(json["address"]),
//     status: json["status"],
//     sender_name: json["sender_name"],
//     // company: Company.fromJson(json["company"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "dt": dt,
//     "trackid": trackid,
//     "trackidshop": trackidshop,
//     // "address": address.toJson(),
//     "status": status,
//     "sender_name": sender_name,
//     // "company": company.toJson(),
//   };
// }
class Hist {
  int status;
  Color color;

  Hist({this.status}) {
    _intialize();
  }
  _intialize() {
    if (status == 0 ) {//upload loi
      color = Colors.pink;
    } else if (status == 1) {//moitao
      color = Colors.red;
    } else if (status == 2) {//dangnhan
      color = Colors.blue[300];
    } else if (status == 3) {//huy
      color = Colors.grey;
    } else if (status == 4) {//danhan
      color = Colors.greenAccent;
    } else if (status == 5) {//danggiao
      color = Colors.yellow[700];
    } else if (status == 6) {//chogiaolai
      color = Colors.deepOrange;
    } else if (status == 7) {//dagiao
      color = Colors.deepPurpleAccent;
    } else if (status == 8) {//chotra
      color = Colors.pink;
    } else if (status == 9) {//datra
      color = Colors.brown;
    } else if (status == 10) {//chochuyen
      color = Colors.green;
    } else if (status == 11) {//dachuyen
      color = Colors.blue[300];
    } else if (status == 12) {//hoantat
      color = Colors.greenAccent;
    } else if (status == 13) {//luukho
      color = Colors.pink[300];
    } else if (status == 14) {//dachapnhan
      color = Colors.lightGreenAccent;
    } else {//error
      color = Colors.black87;
    }
    //Rest of your conditions
  }
}

class VideoDescription extends StatelessWidget {
  VideoDescription({
    Key key,
    this.vandon
  }) : super(key: key);
  Vandon vandon;

  @override
  Widget build(BuildContext context) {
    Hist hist = Hist(status: vandon.statusFilter);
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            vandon.trackid,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            vandon.status,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.0,
                color: hist.color,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          RichText(
            text: TextSpan(
              // text: 'Đt: ',
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                const TextSpan(text: 'Đt: '),
                TextSpan(text: vandon.receiverPhone, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            'NN: '+vandon.receiverName,
            style: const TextStyle(fontSize: 13.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            'Đc: '+vandon.receiverAddress,
            style: const TextStyle(fontSize: 13.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Text(
            '${vandon.dateFilter.year}-${vandon.dateFilter.month}-${vandon.dateFilter.day} ${vandon.dateFilter.hour}:${vandon.dateFilter.minute} ',
            style: const TextStyle(fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}

class DetailTrack extends StatefulWidget {
  int vandon;
  // ignore: use_key_in_widget_constructors
  DetailTrack(this.vandon);

  @override
  State<DetailTrack> createState() => _DetailTrackState();
}

class _DetailTrackState extends State<DetailTrack> {

  Future<Vandon> futureVandon;
  final storage = FlutterSecureStorage();
  var client = http.Client();

  Future<Vandon> fetchVandon(id) async {
    String your_api_token_here = await storage.read(key: "storagetoken");
    http.Response response = await client.get(
      Uri.parse(
          'https://gtnexpress.vn/api/vdapiquerythunhap/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $your_api_token_here',
      },
    );
    // final response = await http.get(Uri.parse('https://gtnexpress.vn/vdapiquery/2899'));

    if (response.statusCode == 200) {
      print("Test track vandon realtime $id");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body.toString());
      return Vandon.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

  methodname(num radians) {
    // you can adjust this values according to your accuracy requirements
    // const myPI = 3142;
    int r = radians;
    switch (r) {
      case 0:
        return "Upload Error";
        break;
      case 1:
        return "Mới tạo";
        break;
      case 2:
        return "Đang nhận";
        break;
      case 3:
        return "Hủy";
        break;
      case 4:
        return "Đã nhận";
        break;
      case 5:
        return "Đang giao";
        break;
      case 6:
        return "Chờ xử lý";
        break;
      case 7:
        return "Đã giao";
        break;
      case 8:
        return "Chờ trả";
        break;
      case 9:
        return "Đã trả hàng";
        break;
      case 10:
        return "Chờ chuyển COD";
        break;
      case 11:
        return "Đã chuyển COD";
        break;
      case 12:
        return "Hoàn tất";
        break;
      case 13:
        return "Lưu kho";
        break;
      case 14:
        return "Đã chấp nhận";
        break;
      default:
        return "Khác!!";
    }
  }

  @override
  void initState() {
    super.initState();
    futureVandon = fetchVandon(widget.vandon);
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('${widget.vandon.trackid} ${methodname(widget.vandon.statusFilter)}'),
    //   ),
    //   // body: PackageDeliveryTrackingPage(),
    //   body: Timeline.tileBuilder(
    //     builder: TimelineTileBuilder.fromStyle(
    //       contentsAlign: ContentsAlign.alternating,
    //       contentsBuilder: (context, index) => Padding(
    //         padding: const EdgeInsets.all(10.0),
    //         child: Column(
    //           children: <Widget>[
    //             Text('${methodname(widget.vandon.tracks[index].statusFilter)}'),
    //             Text('${widget.vandon.tracks[index].dateFilter.year}-${widget.vandon.tracks[index].dateFilter.month}-${widget.vandon.tracks[index].dateFilter.day} ${widget.vandon.tracks[index].dateFilter.hour}:${widget.vandon.tracks[index].dateFilter.minute} '),
    //             (widget.vandon.tracks[index].note.toString().isNotEmpty && widget.vandon.tracks[index].note != 'None' ) ? Text(widget.vandon.tracks[index].note) : const Text(""),
    //           ],
    //         ),
    //       ),
    //       itemCount: widget.vandon.tracks.length,
    //     ),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        // title: Text('Hành trình: ${widget.vandon}'),
        title: Text('Hành trình'),
      ),
      // body: PackageDeliveryTrackingPage(),
      body:Center(
        child: FutureBuilder<Vandon>(
          future: futureVandon,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Timeline.tileBuilder(
                builder: TimelineTileBuilder.fromStyle(
                  contentsAlign: ContentsAlign.alternating,
                  contentsBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Text('${methodname(snapshot.data.tracks[index].statusFilter)}'),
                        Text('${snapshot.data.tracks[index].dateFilter.year}-${snapshot.data.tracks[index].dateFilter.month}-${snapshot.data.tracks[index].dateFilter.day} ${snapshot.data.tracks[index].dateFilter.hour}:${snapshot.data.tracks[index].dateFilter.minute} '),
                        (snapshot.data.tracks[index].note.toString().isNotEmpty && snapshot.data.tracks[index].note != 'None' && !(snapshot.data.tracks[index].note.contains("uploadimage"))  ) ? Text(snapshot.data.tracks[index].note) : const Text(""),
                        // (snapshot.data.tracks[index].note.toString().isNotEmpty && snapshot.data.tracks[index].note.contains("uploadimage") ) ? FadeInImage.assetNetwork( placeholder: 'assets/images/loading5.gif',image: 'https://gtnexpress.vn/${snapshot.data.tracks[index].note}'): const Text(""),
                        // FadeInImage.assetNetwork( placeholder: 'assets/images/loading5.gif',image: 'https://picsum.photos/250?image=9'),
                        // Image.network('https://gtnexpress.vn/${snapshot.data.tracks[index].note}')
                        (snapshot.data.tracks[index].note.toString().isNotEmpty && snapshot.data.tracks[index].note.contains("uploadimage") )
                        ?
                        GestureDetector(
                          child: Hero(
                            tag: 'imageHero',
                            child: FadeInImage.assetNetwork( placeholder: 'assets/images/loading5.gif',image: 'https://gtnexpress.vn/${snapshot.data.tracks[index].note}')
                          ),
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                              return DetailImage('https://gtnexpress.vn/${snapshot.data.tracks[index].note}');
                            }));
                          },
                        )
                        :
                        Text(""),
                      ],
                    ),
                  ),
                  itemCount: snapshot.data.tracks.length,
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
class DetailImage extends StatefulWidget {
  String url;
  // ignore: use_key_in_widget_constructors
  DetailImage(this.url);

  @override
  State<DetailImage> createState() => _DetailImageState();
}

class _DetailImageState extends State<DetailImage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.url,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  Vandon vandon;
  // ignore: use_key_in_widget_constructors
  DetailPage(this.vandon);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<Vandon> futureVandon;
  final storage = FlutterSecureStorage();
  var client = http.Client();

  Future<Vandon> fetchVandon(id) async {
    String your_api_token_here = await storage.read(key: "storagetoken");
    http.Response response = await client.get(
      Uri.parse(
          'https://gtnexpress.vn/api/vdapiquery/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $your_api_token_here',
      },
    );
    // final response = await http.get(Uri.parse('https://gtnexpress.vn/vdapiquery/2899'));

    if (response.statusCode == 200) {
      print("Test track vandon realtime $id");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Vandon.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Khong tim thay');
    }
  }

  methodname(num radians) {
    // you can adjust this values according to your accuracy requirements
    // const myPI = 3142;
    int r = radians;
    switch (r) {
      case 0:
        return "Upload Error";
        break;
      case 1:
        return "Mới tạo";
        break;
      case 2:
        return "Đang nhận";
        break;
      case 3:
        return "Hủy";
        break;
      case 4:
        return "Đã nhận";
        break;
      case 5:
        return "Đang giao";
        break;
      case 6:
        return "Chờ xử lý";
        break;
      case 7:
        return "Đã giao";
        break;
      case 8:
        return "Chờ trả";
        break;
      case 9:
        return "Đã trả hàng";
        break;
      case 10:
        return "Chờ chuyển COD";
        break;
      case 11:
        return "Đã chuyển COD";
        break;
      case 12:
        return "Hoàn tất";
        break;
      case 13:
        return "Lưu kho";
        break;
      case 14:
        return "Đã chấp nhận";
        break;
      default:
        return "Khác!";
    }
  }

  @override
  void initState() {
    super.initState();
    futureVandon = fetchVandon(widget.vandon.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.vandon.trackid),
        ),
        // body: SingleChildScrollView(
        //   // color: Colors.white,
        //   // elevation: 5,
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: <Widget>[
        //       const Padding(padding: EdgeInsets.only(top: 15)),
        //       Row(children: const <Widget>[
        //         Padding(padding: EdgeInsets.only(left: 12)),
        //         Text("Thông tin hàng hóa",
        //             style: TextStyle(fontSize: 18.0, color: Colors.blue)),
        //       ]),
        //
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 12)),
        //         Text("Dịch vụ",
        //             style: TextStyle(
        //                 fontSize: 16.0, color: Colors.lightBlue[900])),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Loại dịch vụ:',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Text(
        //           widget.vandon.service,
        //           style: const TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         //Padding(padding: EdgeInsets.only(left: 5)),
        //         const Padding(padding: EdgeInsets.only(bottom: 5)),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Nội dung:',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Expanded(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               Container(
        //                 margin: const EdgeInsets.only(top: 5.0),
        //                 child: Text(widget.vandon.productContent),
        //               ),
        //             ],
        //           ),
        //         ),
        //         // Flexible(
        //         //   child: Text('${vandon.productContent}'),
        //         // ),
        //         //Padding(padding: EdgeInsets.only(left: 5)),
        //       ]),
        //       // Padding(padding: EdgeInsets.all(3)),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Tiền COD: ',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Text(
        //           '${widget.vandon.priceCod}',
        //           style: const TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         //Padding(padding: EdgeInsets.only(left: 5)),
        //         const Padding(padding: EdgeInsets.only(bottom: 5)),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Yêu cầu: ',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Text(
        //           widget.vandon.yckp,
        //           style: const TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         //Padding(padding: EdgeInsets.only(left: 5)),
        //         const Padding(padding: EdgeInsets.only(bottom: 5)),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 12)),
        //         Text("Cước phí",
        //             style: TextStyle(
        //                 fontSize: 16.0, color: Colors.lightBlue[900])),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Trọng lượng: ',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Text(
        //           '${widget.vandon.kg} kg',
        //           style: const TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Tổng cước:',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Text(
        //           '${widget.vandon.priceFee}',
        //           style: const TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Người trả cước:',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Text(
        //           widget.vandon.tt,
        //           style: const TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //       ]),
        //       const Divider(),
        //       const Padding(padding: EdgeInsets.only(top: 15)),
        //       Row(children: const <Widget>[
        //         Padding(padding: EdgeInsets.only(left: 12)),
        //         Text("Thông tin đơn hàng",
        //             style: TextStyle(fontSize: 18.0, color: Colors.blue)),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 12)),
        //         Text("Người nhận",
        //             style: TextStyle(
        //                 fontSize: 16.0, color: Colors.lightBlue[900])),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Họ tên: ',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Text(
        //           widget.vandon.receiverName,
        //           style: const TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         //Padding(padding: EdgeInsets.only(left: 5)),
        //         const Padding(padding: EdgeInsets.only(bottom: 5)),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Số điện thoại: ',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Text(
        //           widget.vandon.receiverPhone,
        //           style: const TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //       ]),
        //       // Padding(padding: EdgeInsets.all(3)),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Địa chỉ: ',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Expanded(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               Container(
        //                 margin: const EdgeInsets.only(top: 5.0),
        //                 child: Text(widget.vandon.receiverAddress),
        //               ),
        //             ],
        //           ),
        //         ),
        //         const Padding(padding: EdgeInsets.only(bottom: 5)),
        //       ]),
        //
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 12)),
        //         Text("Người gửi",
        //             style: TextStyle(
        //                 fontSize: 16.0, color: Colors.lightBlue[900])),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Họ tên: ',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Text(
        //           widget.vandon.senderName,
        //           style: const TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         //Padding(padding: EdgeInsets.only(left: 5)),
        //         const Padding(padding: EdgeInsets.only(bottom: 5)),
        //       ]),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Số điện thoại: ',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         Text(
        //           widget.vandon.senderPhone,
        //           style: const TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //       ]),
        //       // Padding(padding: EdgeInsets.all(3)),
        //       const Divider(),
        //       Row(children: <Widget>[
        //         const Padding(padding: EdgeInsets.only(left: 10)),
        //         const Text(
        //           'Địa chỉ: ',
        //           style: TextStyle(color: Colors.grey, fontSize: 16),
        //         ),
        //         Expanded(
        //           child: Column(
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               Container(
        //                 margin: const EdgeInsets.only(top: 5.0),
        //                 child: Text(widget.vandon.senderAddress),
        //               ),
        //             ],
        //           ),
        //         ),
        //         const Padding(padding: EdgeInsets.only(bottom: 5)),
        //       ]),
        //       const Divider(),
        //     ],
        //   ),
        // ));
        body: SingleChildScrollView(
          // color: Colors.white,
          // elevation: 5,
          child: Center(
            child: FutureBuilder<Vandon>(
              future: futureVandon,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(top: 15)),
                      Row(children: const <Widget>[
                        Padding(padding: EdgeInsets.only(left: 12)),
                        Text("Thông tin hàng hóa",
                            style: TextStyle(fontSize: 18.0, color: Colors.blue)),
                      ]),

                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 12)),
                        Text("Dịch vụ",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.lightBlue[900])),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Loại dịch vụ:',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          snapshot.data.service,
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        //Padding(padding: EdgeInsets.only(left: 5)),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Nội dung:',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 5.0),
                                child: Text(snapshot.data.productContent, style: TextStyle(color: Colors.grey, fontSize: 16),),
                              ),
                            ],
                          ),
                        ),
                        // Flexible(
                        //   child: Text('${vandon.productContent}'),
                        // ),
                        //Padding(padding: EdgeInsets.only(left: 5)),
                      ]),
                      // Padding(padding: EdgeInsets.all(3)),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Tiền COD: ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          '${snapshot.data.priceCod}',
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        //Padding(padding: EdgeInsets.only(left: 5)),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Yêu cầu: ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          snapshot.data.yckp,
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        //Padding(padding: EdgeInsets.only(left: 5)),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 12)),
                        Text("Cước phí",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.lightBlue[900])),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Trọng lượng: ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          '${snapshot.data.kg} kg',
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Tổng cước:',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          '${snapshot.data.priceFee}',
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Người trả cước:',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          snapshot.data.tt,
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ]),
                      const Divider(),
                      const Padding(padding: EdgeInsets.only(top: 15)),
                      Row(children: const <Widget>[
                        Padding(padding: EdgeInsets.only(left: 12)),
                        Text("Thông tin đơn hàng",
                            style: TextStyle(fontSize: 18.0, color: Colors.blue)),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 12)),
                        Text("Người nhận",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.lightBlue[900])),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Họ tên: ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          snapshot.data.receiverName,
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        //Padding(padding: EdgeInsets.only(left: 5)),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Số điện thoại: ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          snapshot.data.receiverPhone,
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ]),
                      // Padding(padding: EdgeInsets.all(3)),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Địa chỉ: ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 5.0),
                                child: Text(snapshot.data.receiverAddress, style: TextStyle(color: Colors.grey, fontSize: 16),),
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                      ]),

                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 12)),
                        Text("Người gửi",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.lightBlue[900])),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Họ tên: ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          snapshot.data.senderName,
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        //Padding(padding: EdgeInsets.only(left: 5)),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                      ]),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Số điện thoại: ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        Text(
                          snapshot.data.senderPhone,
                          style: const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ]),
                      // Padding(padding: EdgeInsets.all(3)),
                      const Divider(),
                      Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        const Text(
                          'Địa chỉ: ',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(top: 5.0),
                                child: Text(snapshot.data.senderAddress, style: TextStyle(color: Colors.grey, fontSize: 16),),
                              ),
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 5)),
                      ]),
                      const Divider(),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
        );
  }
}

// To parse this JSON data, do
// final vandon = vandonFromJson(jsonString);
// import 'dart:convert';

List<Vandon> vandonFromJson(String str) =>
    List<Vandon>.from(json.decode(str).map((x) => Vandon.fromJson(x)));

String vandonToJson(List<Vandon> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Vandon {
  Vandon({
    this.id,
    this.trackid,
    this.trackidshop,
    this.trackidx,
    this.dateFilter,
    this.senderDateCreate,
    this.kg,
    this.productDai,
    this.productRong,
    this.productCao,
    this.note,
    this.productContent,
    this.productValue,
    this.tt,
    this.yckp,
    this.service,
    this.shopid,
    this.status,
    this.statusFilter,
    this.phaithu,
    this.phaitra,
    this.priceCod,
    this.priceFee,
    this.ptkh,
    this.receiverName,
    this.receiverPhone,
    this.receiverProvinceId,
    this.receiverProvinceName,
    this.receiverAddress,
    this.senderName,
    this.senderPhone,
    this.senderProvinceId,
    this.senderProvinceName,
    this.senderAddress,
    this.tracks,
  });

  int id;
  String trackid;
  String trackidshop;
  String trackidx;
  DateTime dateFilter;
  String senderDateCreate;
  num kg;
  num productDai;
  num productRong;
  num productCao;
  String note;
  String productContent;
  num productValue;
  String tt;
  String yckp;
  String service;
  String shopid;
  String status;
  num statusFilter;
  num phaithu;
  num phaitra;
  String priceCod;
  String priceFee;
  String ptkh;
  String receiverName;
  String receiverPhone;
  num receiverProvinceId;
  String receiverProvinceName;
  String receiverAddress;
  String senderName;
  String senderPhone;
  num senderProvinceId;
  String senderProvinceName;
  String senderAddress;
  List<Track> tracks;

  factory Vandon.fromJson(Map<String, dynamic> json) => Vandon(
        id: json["id"],
        trackid: json["trackid"],
        trackidshop: json["trackidshop"],
        trackidx: json["trackidx"],
        dateFilter: DateTime.parse(json["date_filter"]),
        senderDateCreate: json["sender_date_create"],
        kg: json["kg"],
        productDai: json["product_dai"],
        productRong: json["product_rong"],
        productCao: json["product_cao"],
        note: json["note"],
        productContent: json["product_content"],
        productValue: json["product_value"],
        tt: json["tt"],
        yckp: json["yckp"],
        service: json["service"],
        shopid: json["shopid"],
        status: json["status"],
        statusFilter: json["status_filter"],
        phaithu: json["phaithu"],
        phaitra: json["phaitra"],
        priceCod: json["price_cod"],
        priceFee: json["price_fee"],
        ptkh: json["ptkh"],
        receiverName: json["receiver_name"],
        receiverPhone: json["receiver_phone"],
        receiverProvinceId: json["receiver_province_id"],
        receiverProvinceName: json["receiver_province_name"],
        receiverAddress: json["receiver_address"],
        senderName: json["sender_name"],
        senderPhone: json["sender_phone"],
        senderProvinceId: json["sender_province_id"],
        senderProvinceName: json["sender_province_name"],
        senderAddress: json["sender_address"],
        tracks: List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "trackid": trackid,
        "trackidshop": trackidshop,
        "trackidx": trackidx,
        "date_filter":
            "${dateFilter.year.toString().padLeft(4, '0')}-${dateFilter.month.toString().padLeft(2, '0')}-${dateFilter.day.toString().padLeft(2, '0')}",
        "sender_date_create": senderDateCreate,
        "kg": kg,
        "product_dai": productDai,
        "product_rong": productRong,
        "product_cao": productCao,
        "note": note,
        "product_content": productContent,
        "product_value": productValue,
        "tt": tt,
        "yckp": yckp,
        "service": service,
        "shopid": shopid,
        "status": status,
        "status_filter": statusFilter,
        "phaithu": phaithu,
        "phaitra": phaitra,
        "price_cod": priceCod,
        "price_fee": priceFee,
        "ptkh": ptkh,
        "receiver_name": receiverName,
        "receiver_phone": receiverPhone,
        "receiver_province_id": receiverProvinceId,
        "receiver_province_name": receiverProvinceName,
        "receiver_address": receiverAddress,
        "sender_name": senderName,
        "sender_phone": senderPhone,
        "sender_province_id": senderProvinceId,
        "sender_province_name": senderProvinceName,
        "sender_address": senderAddress,
        "tracks": List<dynamic>.from(tracks.map((x) => x.toJson())),
      };
}

class Track {
  Track({
    this.id,
    this.status,
    this.statusFilter,
    this.note,
    this.ship,
    this.dateFilter,
  });

  int id;
  String status;
  int statusFilter;
  String note;
  String ship;
  DateTime dateFilter;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json["id"],
        status: json["status"],
        statusFilter: json["status_filter"],
        note: json["note"],
        ship: json["ship"],
        dateFilter: DateTime.parse(json["date_filter"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "status_filter": statusFilter,
        "note": note,
        "ship": ship,
        "date_filter":
            "${dateFilter.year.toString().padLeft(4, '0')}-${dateFilter.month.toString().padLeft(2, '0')}-${dateFilter.day.toString().padLeft(2, '0')}",
      };
}

// List<Vandons> vandonsFromJson(String str) => List<Vandons>.from(json.decode(str).map((x) => Vandons.fromJson(x)));
// String vandonsToJson(List<Vandons> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
// class Vandons {
//   Vandons({
//     this.id,
//     this.dt,
//     this.trackid,
//     this.trackidshop,
//     this.status,
//     this.sender_name,
//     // this.website,
//     // this.company,
//   });
//
//   String date_filter;
//   String dt;
//   int id;
//   Float kg;
//   String note;
//   Float phaithu;
//   Float phaitra;
//   Float price_cod;
//   Float price_fee;
//   String product_content;
//   Float product_value;
//   Float ptkh;
//   String receiver_district_id;
//   String receiver_name;
//   String sender_date_create;
//   String sender_name;
//   String sercice;
//   String status;
//   int status_filter;
//   String trackid;
//   String trackidshop;
//   String trackidx;
//   String tt;
//   String yckp;
//
//   factory Vandons.fromJson(Map<String, dynamic> json) => Vandons(
//     id: json["id"],
//     dt: json["dt"],
//     trackid: json["trackid"],
//     trackidshop: json["trackidshop"],
//     // address: Address.fromJson(json["address"]),
//     status: json["status"],
//     sender_name: json["sender_name"],
//     // company: Company.fromJson(json["company"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "dt": dt,
//     "trackid": trackid,
//     "trackidshop": trackidshop,
//     // "address": address.toJson(),
//     "status": status,
//     "sender_name": sender_name,
//     // "company": company.toJson(),
//   };
// }

class Test extends StatelessWidget {
  const Test({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: http.get('https://dc-apps.net/map/services.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          List data = json.decode(snapshot.data.body);

          List categoriesnames = [];
          List stores = [];
          for (var element in data) {
            categoriesnames.add(element["Category"]);
            stores.add(element['stores']);
          }

          // return Text('see');
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              //      print(stores[index][index]['name']);
              return CardItem(
                categoryname: categoriesnames[index],
                sotories: stores[index],
              );
            },
          );
        },
      ),
    );
  }
}

class CardItem extends StatefulWidget {
  final String categoryname;
  List sotories;
  CardItem({Key key, this.categoryname, this.sotories}) : super(key: key);

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(widget.categoryname),
          const SizedBox(
            height: 5,
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.sotories.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(widget.sotories[index]['name']),
              subtitle: Column(
                children: [
                  Text(widget.sotories[index]['phone_1']),
                  Text(widget.sotories[index]['phone_2']),
                ],
              ),
              trailing: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.sotories[index]['logo_url']),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PackageDeliveryTrackingPage extends StatelessWidget {
  const PackageDeliveryTrackingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: TitleAppBar('Package Delivery Tracking'),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final data = _data(index + 1);
          return Center(
            child: SizedBox(
              width: 360.0,
              child: Card(
                margin: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _OrderTitle(
                        orderInfo: data,
                      ),
                    ),
                    const Divider(height: 1.0),
                    _DeliveryProcesses(processes: data.deliveryProcesses),
                    const Divider(height: 1.0),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _OnTimeBar(driver: data.driverInfo),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _OrderTitle extends StatelessWidget {
  const _OrderTitle({
    Key key,
    this.orderInfo,
  }) : super(key: key);

  final _OrderInfo orderInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Delivery #${orderInfo.id}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          '${orderInfo.date.day}/${orderInfo.date.month}/${orderInfo.date.year}',
          style: const TextStyle(
            color: Color(0xffb6b2b2),
          ),
        ),
      ],
    );
  }
}

class _InnerTimeline extends StatelessWidget {
  const _InnerTimeline({
    this.messages,
  });

  final List<_DeliveryMessage> messages;

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      return index == 0 || index == messages.length + 1;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
          connectorTheme: TimelineTheme.of(context).connectorTheme.copyWith(
                thickness: 1.0,
              ),
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                size: 10.0,
                position: 0.5,
              ),
        ),
        builder: TimelineTileBuilder(
          indicatorBuilder: (_, index) =>
              !isEdgeIndex(index) ? Indicator.outlined(borderWidth: 1.0) : null,
          startConnectorBuilder: (_, index) => Connector.solidLine(),
          endConnectorBuilder: (_, index) => Connector.solidLine(),
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }

            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(messages[index - 1].toString()),
            );
          },
          itemExtentBuilder: (_, index) => isEdgeIndex(index) ? 10.0 : 30.0,
          nodeItemOverlapBuilder: (_, index) =>
              isEdgeIndex(index) ? true : null,
          itemCount: messages.length + 2,
        ),
      ),
    );
  }
}

class _DeliveryProcesses extends StatelessWidget {
  const _DeliveryProcesses({Key key, this.processes}) : super(key: key);

  final List<_DeliveryProcess> processes;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0,
            color: const Color(0xff989898),
            indicatorTheme: const IndicatorThemeData(
              position: 0,
              size: 20.0,
            ),
            connectorTheme: const ConnectorThemeData(
              thickness: 2.5,
            ),
          ),
          builder: TimelineTileBuilder.connected(
            connectionDirection: ConnectionDirection.before,
            itemCount: processes.length,
            contentsBuilder: (_, index) {
              if (processes[index].isCompleted) return null;

              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      processes[index].name,
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 18.0,
                          ),
                    ),
                    _InnerTimeline(messages: processes[index].messages),
                  ],
                ),
              );
            },
            indicatorBuilder: (_, index) {
              if (processes[index].isCompleted) {
                return const DotIndicator(
                  color: Color(0xff66c97f),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              } else {
                return const OutlinedDotIndicator(
                  borderWidth: 2.5,
                );
              }
            },
            connectorBuilder: (_, index, ___) => SolidLineConnector(
              color: processes[index].isCompleted ? const Color(0xff66c97f) : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _OnTimeBar extends StatelessWidget {
  const _OnTimeBar({Key key, this.driver}) : super(key: key);

  final _DriverInfo driver;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MaterialButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('On-time!'),
              ),
            );
          },
          elevation: 0,
          shape: const StadiumBorder(),
          color: const Color(0xff66c97f),
          textColor: Colors.white,
          child: const Text('On-time'),
        ),
        const Spacer(),
        Text(
          'Driver\n${driver.name}',
          textAlign: TextAlign.center,
        ),
        const SizedBox(width: 12.0),
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                driver.thumbnailUrl,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

_OrderInfo _data(int id) => _OrderInfo(
      id: id,
      date: DateTime.now(),
      driverInfo: const _DriverInfo(
        name: 'Philipe',
        thumbnailUrl:
            'https://i.pinimg.com/originals/08/45/81/084581e3155d339376bf1d0e17979dc6.jpg',
      ),
      deliveryProcesses: [
        const _DeliveryProcess(
          'Package Process',
          messages: [
            _DeliveryMessage('8:30am', 'Package received by driver'),
            _DeliveryMessage('11:30am', 'Reached halfway mark'),
          ],
        ),
        const _DeliveryProcess(
          'In Transit',
          messages: [
            _DeliveryMessage('13:00pm', 'Driver arrived at destination'),
            _DeliveryMessage('11:35am', 'Package delivered by m.vassiliades'),
          ],
        ),
        const _DeliveryProcess.complete(),
      ],
    );

class _OrderInfo {
  const _OrderInfo({
    this.id,
    this.date,
    this.driverInfo,
    this.deliveryProcesses,
  });

  final int id;
  final DateTime date;
  final _DriverInfo driverInfo;
  final List<_DeliveryProcess> deliveryProcesses;
}

class _DriverInfo {
  const _DriverInfo({
    this.name,
    this.thumbnailUrl,
  });

  final String name;
  final String thumbnailUrl;
}

class _DeliveryProcess {
  const _DeliveryProcess(
    this.name, {
    this.messages = const [],
  });

  const _DeliveryProcess.complete()
      : name = 'Done',
        messages = const [];

  final String name;
  final List<_DeliveryMessage> messages;

  bool get isCompleted => name == 'Done';
}

class _DeliveryMessage {
  const _DeliveryMessage(this.createdAt, this.message);

  final String createdAt; // final DateTime createdAt;
  final String message;

  @override
  String toString() {
    return '$createdAt $message';
  }
}



//NEW HT GTN
class VideoDescriptionXTN extends StatelessWidget {
  VideoDescriptionXTN({
    Key key,
    this.vandon
  }) : super(key: key);
  SerialModal vandon;
  // Used to generate random integers
  final _random = Random();

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Hist hist = Hist(status: vandon.status);
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child:  SizedBox(
        //width: 400,
        height: (int.parse(globals["roles"])>0) ? 160 : 165,//159 ok
        child:
        Column(
          children:[
            Container(
              width: double.infinity,
              height:34,
              // color: Colors.red,
              child:Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        children: [
                          WidgetSpan(
                            child: Container(
                              padding: EdgeInsets.only(right:5.0),
                              child: Icon(Icons.person,size: 18.0,),
                            ),
                          ),
                          TextSpan(
                            children: [
                              TextSpan(
                                text: vandon.contactName.toString(),
                                // style: TextStyle(decoration: TextDecoration.lineThrough),
                                // style: TextStyle(fontSize: 14.0,color: Colors.redAccent,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // textAlign: TextAlign.justify,//not help
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    // SelectableText.rich
                    child: GestureDetector(
                      onTap: () {
                        var _launched = _makePhoneCall('tel:${vandon.contactPhoneNo.toString()}');
                      },
                      onLongPress: () async {
                        // open dialog OR navigate OR do what you want
                        await Clipboard.setData(ClipboardData(text: vandon.contactPhoneNo.toString())).then((_){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã sao chép số điện thoại")));
                        });
                        // copied successfully
                      },
                      // child: SelectableText.rich(TextSpan(
                      // // text: 'He thrusts his fists ',
                      // // style: TextStyle(fontSize: 12),
                      //   children: [
                      //     WidgetSpan(
                      //       child: Container(
                      //         padding: EdgeInsets.only(right:5.0),
                      //         child: Icon(Icons.phone,size: 18.0,),
                      //       ),
                      //     ),
                      //     TextSpan(
                      //       text: vandon.contactPhoneNo.toString(),
                      //       // style: TextStyle(color: Colors.red)
                      //     )
                      //   ]
                      // )),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 50,
                            // child: Icon(
                            //   Icons.monetization_on_outlined,
                            //   color: vandon.commissionPaid.toString()=="true" ? Colors.blue : Colors.red,
                            // ),
                            child: Icon(Icons.phone,size: 16.0,),
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: " ${vandon.contactPhoneNo.toString()}",
                                style: TextStyle(
                                  // fontSize: 16,
                                  // color: Colors.deepPurple,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height:30,
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Expanded(
                    flex: 3,
                    child: SelectableText.rich(TextSpan(
                      // text: 'He thrusts his fists ',
                      // style: TextStyle(fontSize: 12),
                        children: [
                          WidgetSpan(
                            child: Container(
                              padding: EdgeInsets.only(right:5.0),
                              child: Icon(Icons.select_all_rounded,size: 18.0,),
                            ),
                          ),
                          TextSpan(
                            text:  vandon.serialNo.toString(),
                            style: TextStyle(fontSize: 14),
                            // style: TextStyle(color: Colors.red)
                          )
                        ]
                    )
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        children: [
                          WidgetSpan(
                            child: Container(
                              padding: EdgeInsets.only(right:5.0),
                              child: Icon(Icons.date_range,size: 18.0,),
                            ),
                          ),
                          TextSpan(
                            children: [
                              TextSpan(
                                //text: "${DateFormat('dd/MM/y').format(DateTime.parse(_posts[index]['manufacturedDate']).toLocal()).toString()}",
                                text: "${vandon.warrantyActiveDate!= null? DateFormat('dd/MM/y').format(vandon.warrantyActiveDate.toLocal()).toString() : ''}",
                                // style: TextStyle(fontSize: 14.0,color: Colors.redAccent,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //DISABLE ADDRESS TN => giam SIZE
            // SizedBox(
            //   width: double.infinity,
            //   height: 35,
            //   child:Row(
            //     children: <Widget>[
            //       Padding(
            //         padding: EdgeInsets.all(3.0),
            //       ),
            //       Expanded(
            //         child:
            //         Row(
            //           children: <Widget>[
            //             SizedBox(
            //               width: 20.0,
            //               height: 50,
            //               // child: Icon(
            //               //   Icons.monetization_on_outlined,
            //               //   color: vandon.commissionPaid.toString()=="true" ? Colors.blue : Colors.red,
            //               // ),
            //               child: Icon(Icons.location_on_outlined,size: 16.0,),
            //             ),
            //             Expanded(
            //               child: Text.rich(
            //                 TextSpan(
            //                   style: TextStyle(
            //                     fontSize: 14,
            //                   ),
            //                   children: [
            //                     // WidgetSpan(
            //                     //   child: Icon(Icons.phone),
            //                     // ),
            //                     WidgetSpan(
            //                       child: Container(
            //                         padding: EdgeInsets.only(right:8.0),
            //                         child: Text(''),
            //                       ),
            //                     ),
            //                     vandon.commissionPaid.toString()=="true"
            //                         ?
            //                     TextSpan(
            //                       text: "Hoàn thành: +${vandon.commissionPaidAmount}",
            //                       style: TextStyle(
            //                         fontSize: 14,
            //                         color: Colors.green,
            //                         // fontWeight: FontWeight.bold,
            //                       ),
            //                     )
            //                         :
            //                     TextSpan(
            //                       text: "${vandon.contactAddress}, ${vandon.contactDistrict}",
            //                       style: TextStyle(
            //                         fontSize: 12,
            //                         // color: Colors.redAccent,
            //                         // fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            //END DISABLE ADDRESS TN
            Container(
              height: 65,//80 no row last
              //color: Colors.pink,
              //margin: const EdgeInsets.all(30.0),
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(width: 1,color: Colors.grey))
              ),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch, //=>button detail size
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            // If you don't have the height you can expanded with flex
                            flex: 1,
                            child: Container(
                              height: 20,
                              // color: Colors.grey,
                              child:Text.rich(
                                TextSpan(
                                  text: '${vandon.modelNo.toString()}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: hist.color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 20,
                              // color: Colors.pink,
                              //child: const Text('TH01AC . 14-12-2021'),
                              child:Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    // WidgetSpan(
                                    //   child: Icon(Icons.person),
                                    // ),
                                    TextSpan(
                                      text: 'Phải thu: ${vandon.productGroup.id}',
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        child: Container(
                          height: 25,
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Expanded(
                              //   flex: 1,
                              //   child: Text("Dang giao"),
                              // ),
                              vandon.status < 4
                                  ?
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    (vandon.status < 4 && vandon.status != 1 ) ? IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 16.0,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => WebViewEdit(recordObject: vandon.id) ));
                                      },
                                    ) : Text(''),
                                    (vandon?.status.toInt() ==1 ) ? IconButton(
                                        icon: Icon(
                                          Icons.dangerous,
                                          size: 16.0,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          // setState(() {
                                          //   showAlertDialog(context, 'Are you sure you want to delete?', "AppName" , "Ok", "Cancel", vandons[index].id);
                                          //   vandons.removeAt(index);
                                          // });
                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return AlertDialog(
                                                  title: const Text('Xóa vận đơn này?'),
                                                  actions: [
                                                    TextButton(
                                                      // onPressed: (_) => Navigator.pop(context, true), // passing true
                                                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
                                                      child: const Text('Xóa',style: TextStyle(color: Colors.red)),
                                                    ),
                                                    TextButton(
                                                      // onPressed: () => Navigator.pop(context, false),
                                                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
                                                      child: const Text('Không'),
                                                    ),

                                                  ],
                                                );
                                              }).then((exit) {
                                            // if (exit == null) return;
                                            if (exit) {
                                              // user pressed Yes button
                                              // print("yes");
                                              // setState(() {
                                              deleteVandonxx(vandon.id).then((isSuccess) {
                                                if (isSuccess) {
                                                  print("Đã xóa");
                                                  // _onRefresh();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Đã xóa'),
                                                    ),
                                                  );
                                                  setState(() {});
                                                } else {
                                                  print("Không thành công");
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Không thành công'),
                                                    ),
                                                  );
                                                }
                                              });
                                              // });
                                            } else {
                                              print("no.................");
                                              // user pressed No button
                                            }
                                          });
                                        }
                                    ) : Text("")
                                  ]
                              )
                                  :
                              Text("")
                            ],
                          ),
                        )
                    ),
                    (vandon?.status.toInt() > 1) ?
                    SizedBox(
                      // width: 100, // <-- Your width
                      height: 25,
                      child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(30.0),
                        //   ),
                        // ),
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.primaries[_random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 100],
                          primary:Colors.blueGrey,
                          // onPrimary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () {
                          print("Press Yep");
                          // Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailSerialX(vandon)));
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailTrack(vandon.id)));
                        },
                        child: Text('hành trình',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(125, 0, 0, 255),
                              ),
                            ],
                          ),
                        ),
                      ),

                    )
                        :
                    Text(""),
                    SizedBox(
                      // width: 100, // <-- Your width
                      height: 25,
                      child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(30.0),
                        //   ),
                        // ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          // primary:Colors.lightBlue[100],
                          onPrimary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () {
                          print("Press Yep");
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailSerialXTN(vandon.id)));
                        },
                        child: Text('chi tiết',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(125, 0, 0, 255),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            // https://stackoverflow.com/questions/49713189/how-to-use-conditional-statement-within-child-attribute-of-a-flutter-widget-cen
            if (int.parse(globals["roles"])>0)...[Container(
              width: double.infinity,
              // height:20,
              // color: Colors.red,
              child:Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        children: [
                          WidgetSpan(
                            child: Container(
                              padding: EdgeInsets.only(right:5.0),
                              child: Icon(Icons.co_present,size: 18.0,),
                            ),
                          ),
                          TextSpan(
                            children: [
                              TextSpan(
                                text: vandon.description.toString(),
                                // style: TextStyle(decoration: TextDecoration.lineThrough),
                                // style: TextStyle(fontSize: 14.0,color: Colors.redAccent,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // textAlign: TextAlign.justify,//not help
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    // SelectableText.rich
                    child: GestureDetector(
                      // onTap: () {
                      //   var _launched = _makePhoneCall('tel:${vandon.productGroupCode.toString()}');
                      // },
                      // onLongPress: () async {
                      //   // open dialog OR navigate OR do what you want
                      //   await Clipboard.setData(ClipboardData(text: vandon.productGroupCode.toString())).then((_){
                      //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã sao chép số điện thoại")));
                      //   });
                      //   // copied successfully
                      // },
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 14,
                            // child: Icon(
                            //   Icons.monetization_on_outlined,
                            //   color: vandon.commissionPaid.toString()=="true" ? Colors.blue : Colors.red,
                            // ),
                            child: Icon(Icons.delivery_dining_outlined,size: 16.0,),
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: " ${vandon.productGroupCode.toString()}",
                                style: TextStyle(
                                  // fontSize: 16,
                                  // color: Colors.deepPurple,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )]
          ],
        ),
      ),
    );

  }

  // void setState(Null Function() param0) {}

  Future<bool> deleteVandonxx(int id) async {
    const storage = FlutterSecureStorage();
    var client = http.Client();
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    print("DeleteVandonPage: $yourApiTokenHere #'https://gtnexpress.vn/api/vandon_delete/${id}'");
    http.Response response = await client.put(
      Uri.parse('https://gtnexpress.vn/api/vandon_delete/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $yourApiTokenHere',"content-type": "application/json"
      },
    );
    print("DeleteVandonPage: $response #'https://gtnexpress.vn/api/vandon_delete/${id}'");
    print(response.toString());
    // final response = await client.put(
    //   "https://gtnexpress.vn/api/vandon_delete/${id}",
    //   headers: {"content-type": "application/json"}
    // );

    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  void setState(Null Function() param0) {}
}
class VideoDescriptionX extends StatelessWidget {
  VideoDescriptionX({
    Key key,
    this.vandon
  }) : super(key: key);
  SerialModal vandon;
  // Used to generate random integers
  final _random = Random();

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Hist hist = Hist(status: vandon.status);
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child:  SizedBox(
        //width: 400,
        height: (int.parse(globals["roles"])>0) ? 185 : 165,//159 ok
        child:
        Column(
          children:[
            Container(
              width: double.infinity,
              height:34,
              // color: Colors.red,
              child:Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top:5.0),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        children: [
                          WidgetSpan(
                            child: Container(
                              padding: EdgeInsets.only(right:5.0),
                              child: Icon(Icons.person,size: 18.0,),
                            ),
                          ),
                          TextSpan(
                            children: [
                              TextSpan(
                                text: vandon.contactName.toString(),
                                // style: TextStyle(decoration: TextDecoration.lineThrough),
                                // style: TextStyle(fontSize: 14.0,color: Colors.redAccent,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // textAlign: TextAlign.justify,//not help
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    // SelectableText.rich
                    child: GestureDetector(
                      onTap: () {
                        var _launched = _makePhoneCall('tel:${vandon.contactPhoneNo.toString()}');
                      },
                      onLongPress: () async {
                        // open dialog OR navigate OR do what you want
                        await Clipboard.setData(ClipboardData(text: vandon.contactPhoneNo.toString())).then((_){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã sao chép số điện thoại")));
                        });
                        // copied successfully
                      },
                      // child: SelectableText.rich(TextSpan(
                      // // text: 'He thrusts his fists ',
                      // // style: TextStyle(fontSize: 12),
                      //   children: [
                      //     WidgetSpan(
                      //       child: Container(
                      //         padding: EdgeInsets.only(right:5.0),
                      //         child: Icon(Icons.phone,size: 18.0,),
                      //       ),
                      //     ),
                      //     TextSpan(
                      //       text: vandon.contactPhoneNo.toString(),
                      //       // style: TextStyle(color: Colors.red)
                      //     )
                      //   ]
                      // )),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 50,
                            // child: Icon(
                            //   Icons.monetization_on_outlined,
                            //   color: vandon.commissionPaid.toString()=="true" ? Colors.blue : Colors.red,
                            // ),
                            child: Icon(Icons.phone,size: 16.0,),
                          ),
                          Expanded(
                            child: Text.rich(
                                    TextSpan(
                                      text: " ${vandon.contactPhoneNo.toString()}",
                                      style: TextStyle(
                                        // fontSize: 16,
                                        // color: Colors.deepPurple,
                                        // fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height:30,
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Expanded(
                    flex: 3,
                    child: SelectableText.rich(TextSpan(
                      // text: 'He thrusts his fists ',
                      // style: TextStyle(fontSize: 12),
                        children: [
                          WidgetSpan(
                            child: Container(
                              padding: EdgeInsets.only(right:5.0),
                              child: Icon(Icons.select_all_rounded,size: 18.0,),
                            ),
                          ),
                          TextSpan(
                            text:  vandon.serialNo.toString(),
                            style: TextStyle(fontSize: 14),
                            // style: TextStyle(color: Colors.red)
                          )
                        ]
                    )
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        children: [
                          WidgetSpan(
                            child: Container(
                              padding: EdgeInsets.only(right:5.0),
                              child: Icon(Icons.date_range,size: 18.0,),
                            ),
                          ),
                          TextSpan(
                            children: [
                              TextSpan(
                                //text: "${DateFormat('dd/MM/y').format(DateTime.parse(_posts[index]['manufacturedDate']).toLocal()).toString()}",
                                text: "${vandon.warrantyActiveDate!= null? DateFormat('dd/MM/y').format(vandon.warrantyActiveDate.toLocal()).toString() : ''}",
                                // style: TextStyle(fontSize: 14.0,color: Colors.redAccent,),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 35,
              child:Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Expanded(
                    child:
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: 20.0,
                          height: 50,
                          // child: Icon(
                          //   Icons.monetization_on_outlined,
                          //   color: vandon.commissionPaid.toString()=="true" ? Colors.blue : Colors.red,
                          // ),
                          child: Icon(Icons.location_on_outlined,size: 16.0,),
                        ),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                              ),
                              children: [
                                // WidgetSpan(
                                //   child: Icon(Icons.phone),
                                // ),
                                WidgetSpan(
                                  child: Container(
                                    padding: EdgeInsets.only(right:8.0),
                                    child: Text(''),
                                  ),
                                ),
                                vandon.commissionPaid.toString()=="true"
                                    ?
                                TextSpan(
                                  text: "Hoàn thành: +${vandon.commissionPaidAmount}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.green,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                )
                                    :
                                TextSpan(
                                  text: "${vandon.contactAddress}, ${vandon.contactDistrict}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    // color: Colors.redAccent,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
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
            Container(
              height: 65,//80 no row last
              //color: Colors.pink,
              //margin: const EdgeInsets.all(30.0),
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                  border: Border(top: BorderSide(width: 1,color: Colors.grey))
              ),
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.stretch, //=>button detail size
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            // If you don't have the height you can expanded with flex
                            flex: 1,
                            child: Container(
                              height: 20,
                              // color: Colors.grey,
                              child:Text.rich(
                                TextSpan(
                                  text: '${vandon.modelNo.toString()}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: hist.color,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 20,
                              // color: Colors.pink,
                              //child: const Text('TH01AC . 14-12-2021'),
                              child:Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    // WidgetSpan(
                                    //   child: Icon(Icons.person),
                                    // ),
                                    TextSpan(
                                      text: 'Phải thu: ${vandon.productGroup.id}',
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        child: Container(
                          height: 25,
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              // Expanded(
                              //   flex: 1,
                              //   child: Text("Dang giao"),
                              // ),
                              vandon.status < 4
                                  ?
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    (vandon.status < 4 && vandon.status != 1 ) ? IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: 16.0,
                                        color: Colors.blueAccent,
                                      ),
                                      onPressed: () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context) => WebViewEdit(recordObject: vandon.id) ));
                                      },
                                    ) : Text(''),
                                    (vandon?.status.toInt() ==1 ) ? IconButton(
                                        icon: Icon(
                                          Icons.dangerous,
                                          size: 16.0,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          // setState(() {
                                          //   showAlertDialog(context, 'Are you sure you want to delete?', "AppName" , "Ok", "Cancel", vandons[index].id);
                                          //   vandons.removeAt(index);
                                          // });
                                          showDialog(
                                              context: context,
                                              builder: (_) {
                                                return AlertDialog(
                                                  title: const Text('Xóa vận đơn này?'),
                                                  actions: [
                                                    TextButton(
                                                      // onPressed: (_) => Navigator.pop(context, true), // passing true
                                                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(true),
                                                      child: const Text('Xóa',style: TextStyle(color: Colors.red)),
                                                    ),
                                                    TextButton(
                                                      // onPressed: () => Navigator.pop(context, false),
                                                      onPressed: () => Navigator.of(context, rootNavigator: true).pop(false),
                                                      child: const Text('Không'),
                                                    ),

                                                  ],
                                                );
                                              }).then((exit) {
                                            // if (exit == null) return;
                                            if (exit) {
                                              // user pressed Yes button
                                              // print("yes");
                                              // setState(() {
                                              deleteVandonxx(vandon.id).then((isSuccess) {
                                                if (isSuccess) {
                                                  print("Đã xóa");
                                                  // _onRefresh();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Đã xóa'),
                                                    ),
                                                  );
                                                  setState(() {});
                                                } else {
                                                  print("Không thành công");
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    const SnackBar(
                                                      content: Text('Không thành công'),
                                                    ),
                                                  );
                                                }
                                              });
                                              // });
                                            } else {
                                              print("no.................");
                                              // user pressed No button
                                            }
                                          });
                                        }
                                    ) : Text("")
                                  ]
                              )
                                  :
                              Text("")
                            ],
                          ),
                        )
                    ),
                    (vandon?.status.toInt() > 1) ?
                      SizedBox(
                      // width: 100, // <-- Your width
                      height: 25,
                      child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(30.0),
                        //   ),
                        // ),
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.primaries[_random.nextInt(Colors.primaries.length)][_random.nextInt(9) * 100],
                          primary:Colors.blueGrey,
                          // onPrimary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () {
                          print("Press Yep");
                          // Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailSerialX(vandon)));
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailTrack(vandon.id)));
                        },
                        child: Text('hành trình',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(125, 0, 0, 255),
                              ),
                            ],
                          ),
                        ),
                      ),

                    )
                        :
                      Text(""),
                    SizedBox(
                      // width: 100, // <-- Your width
                      height: 25,
                      child: ElevatedButton(
                        // style: ElevatedButton.styleFrom(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(30.0),
                        //   ),
                        // ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          // primary:Colors.lightBlue[100],
                          onPrimary: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                        onPressed: () {
                          print("Press Yep DetailSerial");
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>DetailSerialX(vandon)));
                        },
                        child: Text('chi tiết',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(125, 0, 0, 255),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ]
              ),
            ),
            // https://stackoverflow.com/questions/49713189/how-to-use-conditional-statement-within-child-attribute-of-a-flutter-widget-cen
            if (int.parse(globals["roles"])>0)...[Container(
              width: double.infinity,
              // height:20,
              // color: Colors.red,
              child:Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        children: [
                          WidgetSpan(
                            child: Container(
                              padding: EdgeInsets.only(right:5.0),
                              child: Icon(Icons.co_present,size: 18.0,),
                            ),
                          ),
                          TextSpan(
                            children: [
                              TextSpan(
                                text: vandon.description.toString(),
                                // style: TextStyle(decoration: TextDecoration.lineThrough),
                                // style: TextStyle(fontSize: 14.0,color: Colors.redAccent,),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // textAlign: TextAlign.justify,//not help
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    // SelectableText.rich
                    child: GestureDetector(
                      onTap: () {
                        var _launched = _makePhoneCall('tel:${vandon.productGroupCode.toString()}');
                      },
                      onLongPress: () async {
                        // open dialog OR navigate OR do what you want
                        await Clipboard.setData(ClipboardData(text: vandon.productGroupCode.toString())).then((_){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Đã sao chép số điện thoại")));
                        });
                        // copied successfully
                      },
                      // child: SelectableText.rich(TextSpan(
                      // // text: 'He thrusts his fists ',
                      // // style: TextStyle(fontSize: 12),
                      //   children: [
                      //     WidgetSpan(
                      //       child: Container(
                      //         padding: EdgeInsets.only(right:5.0),
                      //         child: Icon(Icons.phone,size: 18.0,),
                      //       ),
                      //     ),
                      //     TextSpan(
                      //       text: vandon.contactPhoneNo.toString(),
                      //       // style: TextStyle(color: Colors.red)
                      //     )
                      //   ]
                      // )),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 20.0,
                            height: 14,
                            // child: Icon(
                            //   Icons.monetization_on_outlined,
                            //   color: vandon.commissionPaid.toString()=="true" ? Colors.blue : Colors.red,
                            // ),
                            child: Icon(Icons.phone,size: 16.0,),
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text: " ${vandon.productGroupCode.toString()}",
                                style: TextStyle(
                                  // fontSize: 16,
                                  // color: Colors.deepPurple,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )]
          ],
        ),
      ),
    );

  }

  // void setState(Null Function() param0) {}

  Future<bool> deleteVandonxx(int id) async {
    const storage = FlutterSecureStorage();
    var client = http.Client();
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    print("DeleteVandonPage: $yourApiTokenHere #'https://gtnexpress.vn/api/vandon_delete/${id}'");
    http.Response response = await client.put(
      Uri.parse('https://gtnexpress.vn/api/vandon_delete/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $yourApiTokenHere',"content-type": "application/json"
      },
    );
    print("DeleteVandonPage: $response #'https://gtnexpress.vn/api/vandon_delete/${id}'");
    print(response.toString());
    // final response = await client.put(
    //   "https://gtnexpress.vn/api/vandon_delete/${id}",
    //   headers: {"content-type": "application/json"}
    // );

    if (response.statusCode == 201) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }

  void setState(Null Function() param0) {}
}

class DetailSerialX extends StatefulWidget {
  SerialModal vandon;
  // ignore: use_key_in_widget_constructors
  DetailSerialX(this.vandon);

  @override
  State<DetailSerialX> createState() => DetailSerialStateX();
}
class DetailSerialStateX extends State<DetailSerialX> {

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

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
          child: Scaffold(
            appBar: AppBar(
              title: Text('${widget.vandon.serialNo}'),
            ),
            // body: PackageDeliveryTrackingPage(),
            body: SingleChildScrollView(
              // color: Colors.white,
              // elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Row(children: const <Widget>[
                  //   Padding(padding: EdgeInsets.only(left: 12)),
                  //   Text("Thông tin lap dat",
                  //       style: TextStyle(fontSize: 18.0, color: Colors.blue)),
                  // ]),
                  // const Divider(),
                  Container(
                    color: Colors.grey,
                    padding: EdgeInsets.only(top:15,left:0,bottom: 15),
                    child: Row(children: <Widget>[
                      const Padding(padding: EdgeInsets.only(left: 12)),
                      Text("Thông tin đơn",
                        // style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.bold)
                        style: TextStyle(
                          fontFamily:
                          FitnessAppTheme.fontName,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.0,
                          color: FitnessAppTheme.darkText,
                        ),
                      ),
                    ]),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container (
                            // padding: const EdgeInsets.all(0.0),
                            // width: MediaQuery.of(context).size.width*0.45,
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.shield_outlined,size: 18,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Người gửi: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SelectableText.rich(
                                  TextSpan(
                                    text:'${widget.vandon.description.toString()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      // color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container (
                            // padding: const EdgeInsets.all(0.0),
                            // width: MediaQuery.of(context).size.width*0.45,
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.select_all_rounded,size: 18,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Mã đơn: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SelectableText.rich(
                                  TextSpan(
                                    text:'${widget.vandon.serialNo.toString()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      // color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Container (
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.label_important_outline,size: 18,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Dịch vụ: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${widget.vandon.serviceGroup.code.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    // color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Container (
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.monetization_on,size: 18,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Thu COD:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${widget.vandon.serviceGroup.name.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    // color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Container (
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.workspaces,size: 18,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Trọng lượng: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${widget.vandon.serviceGroup.id.toString()} kg',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    // color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Container (
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.monetization_on_outlined,size: 18,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Cước phí: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${widget.vandon.productGroup.code.toString()} - ${widget.vandon.productGroup.serviceGroupCode.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    // color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  // const Divider(height: 0,),
                  // Material(
                  //   color: Colors.transparent,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //         left: 0, right: 0, top: 10, bottom: 10),
                  //     child: Column(
                  //       children: <Widget>[
                  //         Container (
                  //           child: Row (
                  //             children: <Widget>[
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 5.0,right: 5),
                  //                 child: Icon(Icons.person,size: 18.0,),
                  //               ),
                  //               Text(
                  //                 // '1 Room - 2 Adults',
                  //                 'Người trả cước: ',
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: 16,
                  //                 ),
                  //               ),
                  //               Text(
                  //                 '${widget.vandon.productGroup.serviceGroupCode.toString()}',
                  //                 style: TextStyle(
                  //                   fontWeight: FontWeight.w400,
                  //                   fontSize: 16,
                  //                   // color: Colors.red,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Container (
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.receipt,size: 18.0,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Yêu cầu: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${widget.vandon.productGroup.name.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    // color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Container (
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.monetization_on_outlined,size: 18.0,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Phải thu: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${widget.vandon.productGroup.id.toString()}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    // color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        children: <Widget>[
                          Container (
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.date_range,size: 18.0,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Ngày tạo: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${widget.vandon.manufacturedDate != null ? DateFormat('dd/MM/y').format(widget.vandon.manufacturedDate.toLocal()).toString() : ''}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    // color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container (
                            // padding: const EdgeInsets.all(0.0),
                            // width: MediaQuery.of(context).size.width*0.45,
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.delivery_dining,size: 18,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Hành trình: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SelectableText.rich(
                                  TextSpan(
                                    text:'${widget.vandon.modelNo.toString()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      // color: Colors.red,
                                    ),),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  // Material(
                  //   color: Colors.transparent,
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //         left: 2, right: 0, top: 10, bottom: 10),
                  //     child: Column(
                  //       // mainAxisAlignment: MainAxisAlignment.center,
                  //       // crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[
                  //         Container (
                  //           // padding: const EdgeInsets.all(0.0),
                  //           // width: MediaQuery.of(context).size.width*0.45,
                  //           child: Column (
                  //             children: <Widget>[
                  //               Column(children: <Widget>[
                  //                 // const Padding(padding: EdgeInsets.only(left: 5)),
                  //                 SelectableText.rich(
                  //                   TextSpan(
                  //                       text: ' ',
                  //                       // style: TextStyle(fontSize: 12),
                  //                       children: [
                  //                         WidgetSpan(
                  //                           child: Container(
                  //                             padding: EdgeInsets.only(right:5.0),
                  //                             child: Icon(Icons.date_range,size: 16.0,),
                  //                           ),
                  //                         ),
                  //                         TextSpan(
                  //                           text: "Thời gian giao: ",
                  //                           style: TextStyle(
                  //                             fontFamily:
                  //                             FitnessAppTheme.fontName,
                  //                             fontWeight: FontWeight.bold,
                  //                             fontSize: 16,
                  //                             letterSpacing: 0.0,
                  //                             color: FitnessAppTheme.darkText,
                  //                           ),
                  //                         ),
                  //                         TextSpan(
                  //                           text: "${DateFormat('dd/MM/y').format(widget.vandon.warrantyActiveDate.toLocal()).toString()} - ${DateFormat('dd/MM/y').format(widget.vandon.warrantyEndDate.toLocal()).toString()}",
                  //                           style: TextStyle(
                  //                             fontFamily:
                  //                             FitnessAppTheme.fontName,
                  //                             fontWeight: FontWeight.w500,
                  //                             fontSize: 16,
                  //                             letterSpacing: 0.0,
                  //                             color: FitnessAppTheme.darkText,
                  //                           ),
                  //                           // style: TextStyle(color: Colors.red)
                  //                         ),
                  //                       ]
                  //                   ),
                  //                 ),
                  //               ]),
                  //             ],
                  //           ),
                  //         ),
                  //
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // const Divider(height: 0,),
                  Container(
                    color: Colors.grey,
                    padding: EdgeInsets.only(top:15,left:0,bottom: 15),
                    child: Row(children: <Widget>[
                      const Padding(padding: EdgeInsets.only(left: 12)),
                      Text("Thông tin khách hàng",
                        // style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.bold)
                        style: TextStyle(
                          fontFamily:
                          FitnessAppTheme.fontName,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.0,
                          color: FitnessAppTheme.darkText,
                        ),
                      ),
                    ]),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container (
                            // padding: const EdgeInsets.all(0.0),
                            // width: MediaQuery.of(context).size.width*0.45,
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.person,size: 18,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Tên: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${widget.vandon.contactName}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    // color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, top: 10, bottom: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container (
                            // padding: const EdgeInsets.all(0.0),
                            // width: MediaQuery.of(context).size.width*0.45,
                            child: Row (
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0,right: 5),
                                  child: Icon(Icons.phone,size: 18,),
                                ),
                                Text(
                                  // '1 Room - 2 Adults',
                                  'Điện thoại: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SelectableText.rich(
                                  TextSpan(
                                    text:'${widget.vandon.contactPhoneNo}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      // color: Colors.red,
                                    ),),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 0,),
                  Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 2, right: 0, top: 10, bottom: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container (
                            // padding: const EdgeInsets.all(0.0),
                            // width: MediaQuery.of(context).size.width*0.45,
                            child: Column (
                              children: <Widget>[
                                Column(children: <Widget>[
                                  // const Padding(padding: EdgeInsets.only(left: 5)),
                                  Text.rich(
                                    TextSpan(
                                        text: ' ',
                                        // style: TextStyle(fontSize: 12),
                                        children: [
                                          WidgetSpan(
                                            child: Container(
                                              padding: EdgeInsets.only(right:5.0),
                                              child: Icon(Icons.location_on_outlined,size: 16.0,),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "Địa chỉ: ",
                                            style: TextStyle(
                                              fontFamily:
                                              FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              letterSpacing: 0.0,
                                              color: FitnessAppTheme.darkText,
                                            ),
                                          ),
                                          TextSpan(
                                            text: "${widget.vandon.contactAddress} , ${widget.vandon.contactDistrict.toString() != "null" ? widget.vandon.contactDistrict : 'NA' }, ${
                                                cities.firstWhere(
                                                      (city) => city.id == widget.vandon.contactCity.toString(),
                                                  orElse: () => null,
                                                )
                                            }",
                                            style: TextStyle(
                                              fontFamily:
                                              FitnessAppTheme.fontName,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: 0.0,
                                              color: FitnessAppTheme.darkText,
                                            ),
                                            // style: TextStyle(color: Colors.red)
                                          ),
                                        ]
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('${widget.vandon.serialNo}'),
    //   ),
    //   // body: PackageDeliveryTrackingPage(),
    //   body: Card(
    //       child: Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               "Họ và tên: ${widget.vandon.dealer.code}",
    //               // style: Theme.of(context).textTheme.title,
    //             ),
    //             Text(
    //               "Điện thoại: ${(widget.vandon.serviceGroup.name)}",
    //               // style: Theme.of(context).textTheme.title,
    //             ),
    //             Text("Email: ${widget.vandon.serialNo}"),
    //             Text(
    //               "Địa chỉ: ${widget.vandon.serialNo}",
    //               // style: Theme.of(context).textTheme.title,
    //             ),
    //             Text(
    //               "Ngân Hàng: ${widget.vandon.serialNo}",
    //               // style: Theme.of(context).textTheme.title,
    //             ),
    //             Text(
    //               "Số Tài khoản: ${widget.vandon.serialNo}",
    //               // style: Theme.of(context).textTheme.title,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: const <Widget>[
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    // );


  }
}

class DetailSerialXTN extends StatefulWidget {
  // SerialModal vandon;
  int vandon;
  // ignore: use_key_in_widget_constructors
  DetailSerialXTN(this.vandon);

  @override
  State<DetailSerialXTN> createState() => DetailSerialStateXTN();
}
class DetailSerialStateXTN extends State<DetailSerialXTN> {

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
  Future<Vandon> futureVandon;
  final storage = FlutterSecureStorage();
  var client = http.Client();

  Future<Vandon> fetchVandon(id) async {
    String your_api_token_here = await storage.read(key: "storagetoken");
    http.Response response = await client.get(
      Uri.parse(
          'https://gtnexpress.vn/api/vdapiquerythunhap/$id'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $your_api_token_here',
      },
    );
    // final response = await http.get(Uri.parse('https://gtnexpress.vn/vdapiquery/2899'));
    print(response.body.toString());
    if (response.statusCode == 200) {
      print("Test track vandon realtime==convert to Vandon realtime $id");
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Vandon.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }

  methodname(num radians) {
    // you can adjust this values according to your accuracy requirements
    // const myPI = 3142;
    int r = radians;
    switch (r) {
      case 0:
        return "Upload Error";
        break;
      case 1:
        return "Mới tạo";
        break;
      case 2:
        return "Đang nhận";
        break;
      case 3:
        return "Hủy";
        break;
      case 4:
        return "Đã nhận";
        break;
      case 5:
        return "Đang giao";
        break;
      case 6:
        return "Chờ xử lý";
        break;
      case 7:
        return "Đã giao";
        break;
      case 8:
        return "Chờ trả";
        break;
      case 9:
        return "Đã trả hàng";
        break;
      case 10:
        return "Chờ chuyển COD";
        break;
      case 11:
        return "Đã chuyển COD";
        break;
      case 12:
        return "Hoàn tất";
        break;
      case 13:
        return "Lưu kho";
        break;
      case 14:
        return "Đã chấp nhận";
        break;
      default:
        return "Khác!!";
    }
  }

  @override
  void initState() {
    super.initState();
    futureVandon = fetchVandon(widget.vandon);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Chi tiết đơn'),
          ),
          // body: PackageDeliveryTrackingPage(),
          body: SingleChildScrollView(


            child: FutureBuilder<Vandon>(
              future: futureVandon,
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  return

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // Row(children: const <Widget>[
                        //   Padding(padding: EdgeInsets.only(left: 12)),
                        //   Text("Thông tin lap dat",
                        //       style: TextStyle(fontSize: 18.0, color: Colors.blue)),
                        // ]),
                        // const Divider(),
                        Container(
                          color: Colors.grey,
                          padding: EdgeInsets.only(top:15,left:0,bottom: 15),
                          child: Row(children: <Widget>[
                            const Padding(padding: EdgeInsets.only(left: 12)),
                            Text("Thông tin đơn",
                              // style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.bold)
                              style: TextStyle(
                                fontFamily:
                                FitnessAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.0,
                                color: FitnessAppTheme.darkText,
                              ),
                            ),
                          ]),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container (
                                  // padding: const EdgeInsets.all(0.0),
                                  // width: MediaQuery.of(context).size.width*0.45,
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.shield_outlined,size: 18,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Người gửi: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SelectableText.rich(
                                        TextSpan(
                                          text:'${snapshot.data.senderName.toString()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            // color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container (
                                  // padding: const EdgeInsets.all(0.0),
                                  // width: MediaQuery.of(context).size.width*0.45,
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.select_all_rounded,size: 18,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Mã đơn: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SelectableText.rich(
                                        TextSpan(
                                          text:'${snapshot.data.trackid.toString()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            // color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container (
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.label_important_outline,size: 18,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Dịch vụ: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data.service.toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          // color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container (
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.monetization_on,size: 18,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Thu COD:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data.priceCod.toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          // color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container (
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.workspaces,size: 18,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Trọng lượng: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data.kg.toString()} kg',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          // color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container (
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.monetization_on_outlined,size: 18,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Cước phí:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data.priceFee.toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          // color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        ' ${snapshot.data.tt.toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          // color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        // const Divider(height: 0,),
                        // Material(
                        //   color: Colors.transparent,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         left: 0, right: 0, top: 10, bottom: 10),
                        //     child: Column(
                        //       children: <Widget>[
                        //         Container (
                        //           child: Row (
                        //             children: <Widget>[
                        //               Padding(
                        //                 padding: const EdgeInsets.only(left: 5.0,right: 5),
                        //                 child: Icon(Icons.person,size: 18.0,),
                        //               ),
                        //               Text(
                        //                 // '1 Room - 2 Adults',
                        //                 'Người trả cước: ',
                        //                 style: TextStyle(
                        //                   fontWeight: FontWeight.bold,
                        //                   fontSize: 16,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 '${widget.vandon.productGroup.serviceGroupCode.toString()}',
                        //                 style: TextStyle(
                        //                   fontWeight: FontWeight.w400,
                        //                   fontSize: 16,
                        //                   // color: Colors.red,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container (
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.receipt,size: 18.0,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Yêu cầu: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data.yckp.toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          // color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container (
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.monetization_on_outlined,size: 18.0,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Phải thu: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data.ptkh.toString()}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          // color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              children: <Widget>[
                                Container (
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.date_range,size: 18.0,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Ngày tạo: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        // "${snapshot.data.dateFilter}",//fixfixfix
                                        "${snapshot.data.dateFilter.day}/${snapshot.data.dateFilter.month}/${snapshot.data.dateFilter.year}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          // color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container (
                                  // padding: const EdgeInsets.all(0.0),
                                  // width: MediaQuery.of(context).size.width*0.45,
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.delivery_dining,size: 18,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Hành trình: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SelectableText.rich(
                                        TextSpan(
                                          text:'${methodname(snapshot.data.statusFilter)}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            // color: Colors.red,
                                          ),),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        // Material(
                        //   color: Colors.transparent,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(
                        //         left: 2, right: 0, top: 10, bottom: 10),
                        //     child: Column(
                        //       // mainAxisAlignment: MainAxisAlignment.center,
                        //       // crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: <Widget>[
                        //         Container (
                        //           // padding: const EdgeInsets.all(0.0),
                        //           // width: MediaQuery.of(context).size.width*0.45,
                        //           child: Column (
                        //             children: <Widget>[
                        //               Column(children: <Widget>[
                        //                 // const Padding(padding: EdgeInsets.only(left: 5)),
                        //                 SelectableText.rich(
                        //                   TextSpan(
                        //                       text: ' ',
                        //                       // style: TextStyle(fontSize: 12),
                        //                       children: [
                        //                         WidgetSpan(
                        //                           child: Container(
                        //                             padding: EdgeInsets.only(right:5.0),
                        //                             child: Icon(Icons.date_range,size: 16.0,),
                        //                           ),
                        //                         ),
                        //                         TextSpan(
                        //                           text: "Thời gian giao: ",
                        //                           style: TextStyle(
                        //                             fontFamily:
                        //                             FitnessAppTheme.fontName,
                        //                             fontWeight: FontWeight.bold,
                        //                             fontSize: 16,
                        //                             letterSpacing: 0.0,
                        //                             color: FitnessAppTheme.darkText,
                        //                           ),
                        //                         ),
                        //                         TextSpan(
                        //                           text: "${DateFormat('dd/MM/y').format(widget.vandon.warrantyActiveDate.toLocal()).toString()} - ${DateFormat('dd/MM/y').format(widget.vandon.warrantyEndDate.toLocal()).toString()}",
                        //                           style: TextStyle(
                        //                             fontFamily:
                        //                             FitnessAppTheme.fontName,
                        //                             fontWeight: FontWeight.w500,
                        //                             fontSize: 16,
                        //                             letterSpacing: 0.0,
                        //                             color: FitnessAppTheme.darkText,
                        //                           ),
                        //                           // style: TextStyle(color: Colors.red)
                        //                         ),
                        //                       ]
                        //                   ),
                        //                 ),
                        //               ]),
                        //             ],
                        //           ),
                        //         ),
                        //
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const Divider(height: 0,),
                        Container(
                          color: Colors.grey,
                          padding: EdgeInsets.only(top:15,left:0,bottom: 15),
                          child: Row(children: <Widget>[
                            const Padding(padding: EdgeInsets.only(left: 12)),
                            Text("Thông tin khách hàng",
                              // style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.bold)
                              style: TextStyle(
                                fontFamily:
                                FitnessAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.0,
                                color: FitnessAppTheme.darkText,
                              ),
                            ),
                          ]),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container (
                                  // padding: const EdgeInsets.all(0.0),
                                  // width: MediaQuery.of(context).size.width*0.45,
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.person,size: 18,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Tên: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data.receiverName}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          // color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 10, bottom: 10),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container (
                                  // padding: const EdgeInsets.all(0.0),
                                  // width: MediaQuery.of(context).size.width*0.45,
                                  child: Row (
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0,right: 5),
                                        child: Icon(Icons.phone,size: 18,),
                                      ),
                                      Text(
                                        // '1 Room - 2 Adults',
                                        'Điện thoại: ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SelectableText.rich(
                                        TextSpan(
                                          text:'${snapshot.data.receiverPhone}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            // color: Colors.red,
                                          ),),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 0,),
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 2, right: 0, top: 10, bottom: 10),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container (
                                  // padding: const EdgeInsets.all(0.0),
                                  // width: MediaQuery.of(context).size.width*0.45,
                                  child: Column (
                                    children: <Widget>[
                                      Column(children: <Widget>[
                                        // const Padding(padding: EdgeInsets.only(left: 5)),
                                        Text.rich(
                                          TextSpan(
                                              text: ' ',
                                              // style: TextStyle(fontSize: 12),
                                              children: [
                                                WidgetSpan(
                                                  child: Container(
                                                    padding: EdgeInsets.only(right:5.0),
                                                    child: Icon(Icons.location_on_outlined,size: 16.0,),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "Địa chỉ: ",
                                                  style: TextStyle(
                                                    fontFamily:
                                                    FitnessAppTheme.fontName,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    letterSpacing: 0.0,
                                                    color: FitnessAppTheme.darkText,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "${snapshot.data.receiverAddress}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                    FitnessAppTheme.fontName,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    letterSpacing: 0.0,
                                                    color: FitnessAppTheme.darkText,
                                                  ),
                                                  // style: TextStyle(color: Colors.red)
                                                ),
                                              ]
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    );


                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),



          ),),
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('${widget.vandon.serialNo}'),
    //   ),
    //   // body: PackageDeliveryTrackingPage(),
    //   body: Card(
    //       child: Padding(
    //         padding: const EdgeInsets.all(16.0),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               "Họ và tên: ${widget.vandon.dealer.code}",
    //               // style: Theme.of(context).textTheme.title,
    //             ),
    //             Text(
    //               "Điện thoại: ${(widget.vandon.serviceGroup.name)}",
    //               // style: Theme.of(context).textTheme.title,
    //             ),
    //             Text("Email: ${widget.vandon.serialNo}"),
    //             Text(
    //               "Địa chỉ: ${widget.vandon.serialNo}",
    //               // style: Theme.of(context).textTheme.title,
    //             ),
    //             Text(
    //               "Ngân Hàng: ${widget.vandon.serialNo}",
    //               // style: Theme.of(context).textTheme.title,
    //             ),
    //             Text(
    //               "Số Tài khoản: ${widget.vandon.serialNo}",
    //               // style: Theme.of(context).textTheme.title,
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: const <Widget>[
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    // );


  }
}

class DetailPageX extends StatefulWidget {
  Profile vandon;
  // ignore: use_key_in_widget_constructors
  DetailPageX(this.vandon);

  @override
  State<DetailPageX> createState() => _DetailPageStateX();
}
class _DetailPageStateX extends State<DetailPageX> {
  Future<SerialModal> futureVandon;
  final storage = FlutterSecureStorage();
  var client = http.Client();
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

  Future<SerialModal> fetchVandon(id) async {
    // http.Response response = await client.get(
    //   Uri.parse(
    //       'http://service-item/get/by-model-serial?serialNo=$id'),
    //   headers: {
    //     HttpHeaders.authorizationHeader: 'Bearer $your_api_token_here',
    //   },
    // );
    // final response = await http.get(Uri.parse('https://gtnexpress.vn/vdapiquery/2899'));
    String yourApiTokenHere = await storage.read(key: "storagetoken");
    Map<String,String> headers = {
      'Content-Type':'application/json',
      'Authorization':'$yourApiTokenHere',
      'Tenant' :'pna'
    };
    var bodyx = jsonEncode({
      "includeTotal":true,
      "filter": {
        "warrantyStatus": "registered",
        "serviceGroupCode": null,
        "productGroupCode": null,
        "modelNo": null,
        "dealerId": null,
        "comissionStatus": null,
        "manufacturedDate": {
          "from": null,
          "to": null
        },
        "warrantyActiveDate": {
          "from": null,
          "to": null
        },
        "warrantyEndDate": {
          "from": null,
          "to": null
        },
        "returnedDate": {
          "from": null,
          "to": null
        }
      },
      "select":"",
      "search":"${id}",
      "skip":0,
      "take":2,
      // "skip":_page,
      // "take":_limit,
      "sort":{"serialNo":1}
    });
    // print(yourApiTokenHere);
    final response = await http.post(
      Uri.parse("https://pna-api.akino.vn/service-items/search"),
      headers: headers,
      body: bodyx,
    );
    if (response.statusCode == 200) {
      // _total = json.decode(response.body)['total'];
      // _posts = json.decode(response.body)['data'];
      print("Chi tiet Serial ${json.decode(response.body)['data']}");
      List responseJson = json.decode(response.body)['data'];
      if(responseJson.length>0){
        return SerialModal.fromJson(responseJson[0]);
      }
      throw Exception('Failed to load Serial');
      // print("Ket Qua: "+items.length.toString());
    } else {
      print("End detail error");
      throw Exception('Failed to load Serial');
    }
    // if (response.statusCode == 200) {
    //   print("Test track vandon realtime $id");
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    //   return Vandon.fromJson(jsonDecode(response.body));
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
  }
  @override
  void initState() {
    super.initState();
    futureVandon = fetchVandon(widget.vandon.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vandon.email),
      ),
      // body: SingleChildScrollView(
      //   // color: Colors.white,
      //   // elevation: 5,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: <Widget>[
      //       const Padding(padding: EdgeInsets.only(top: 15)),
      //       Row(children: const <Widget>[
      //         Padding(padding: EdgeInsets.only(left: 12)),
      //         Text("Thông tin hàng hóa",
      //             style: TextStyle(fontSize: 18.0, color: Colors.blue)),
      //       ]),
      //
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 12)),
      //         Text("Dịch vụ",
      //             style: TextStyle(
      //                 fontSize: 16.0, color: Colors.lightBlue[900])),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Loại dịch vụ:',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Text(
      //           widget.vandon.service,
      //           style: const TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         //Padding(padding: EdgeInsets.only(left: 5)),
      //         const Padding(padding: EdgeInsets.only(bottom: 5)),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Nội dung:',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Expanded(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Container(
      //                 margin: const EdgeInsets.only(top: 5.0),
      //                 child: Text(widget.vandon.productContent),
      //               ),
      //             ],
      //           ),
      //         ),
      //         // Flexible(
      //         //   child: Text('${vandon.productContent}'),
      //         // ),
      //         //Padding(padding: EdgeInsets.only(left: 5)),
      //       ]),
      //       // Padding(padding: EdgeInsets.all(3)),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Tiền COD: ',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Text(
      //           '${widget.vandon.priceCod}',
      //           style: const TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         //Padding(padding: EdgeInsets.only(left: 5)),
      //         const Padding(padding: EdgeInsets.only(bottom: 5)),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Yêu cầu: ',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Text(
      //           widget.vandon.yckp,
      //           style: const TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         //Padding(padding: EdgeInsets.only(left: 5)),
      //         const Padding(padding: EdgeInsets.only(bottom: 5)),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 12)),
      //         Text("Cước phí",
      //             style: TextStyle(
      //                 fontSize: 16.0, color: Colors.lightBlue[900])),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Trọng lượng: ',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Text(
      //           '${widget.vandon.kg} kg',
      //           style: const TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Tổng cước:',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Text(
      //           '${widget.vandon.priceFee}',
      //           style: const TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Người trả cước:',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Text(
      //           widget.vandon.tt,
      //           style: const TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //       ]),
      //       const Divider(),
      //       const Padding(padding: EdgeInsets.only(top: 15)),
      //       Row(children: const <Widget>[
      //         Padding(padding: EdgeInsets.only(left: 12)),
      //         Text("Thông tin đơn hàng",
      //             style: TextStyle(fontSize: 18.0, color: Colors.blue)),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 12)),
      //         Text("Người nhận",
      //             style: TextStyle(
      //                 fontSize: 16.0, color: Colors.lightBlue[900])),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Họ tên: ',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Text(
      //           widget.vandon.receiverName,
      //           style: const TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         //Padding(padding: EdgeInsets.only(left: 5)),
      //         const Padding(padding: EdgeInsets.only(bottom: 5)),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Số điện thoại: ',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Text(
      //           widget.vandon.receiverPhone,
      //           style: const TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //       ]),
      //       // Padding(padding: EdgeInsets.all(3)),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Địa chỉ: ',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Expanded(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Container(
      //                 margin: const EdgeInsets.only(top: 5.0),
      //                 child: Text(widget.vandon.receiverAddress),
      //               ),
      //             ],
      //           ),
      //         ),
      //         const Padding(padding: EdgeInsets.only(bottom: 5)),
      //       ]),
      //
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 12)),
      //         Text("Người gửi",
      //             style: TextStyle(
      //                 fontSize: 16.0, color: Colors.lightBlue[900])),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Họ tên: ',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Text(
      //           widget.vandon.senderName,
      //           style: const TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         //Padding(padding: EdgeInsets.only(left: 5)),
      //         const Padding(padding: EdgeInsets.only(bottom: 5)),
      //       ]),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Số điện thoại: ',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         Text(
      //           widget.vandon.senderPhone,
      //           style: const TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //       ]),
      //       // Padding(padding: EdgeInsets.all(3)),
      //       const Divider(),
      //       Row(children: <Widget>[
      //         const Padding(padding: EdgeInsets.only(left: 10)),
      //         const Text(
      //           'Địa chỉ: ',
      //           style: TextStyle(color: Colors.grey, fontSize: 16),
      //         ),
      //         Expanded(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Container(
      //                 margin: const EdgeInsets.only(top: 5.0),
      //                 child: Text(widget.vandon.senderAddress),
      //               ),
      //             ],
      //           ),
      //         ),
      //         const Padding(padding: EdgeInsets.only(bottom: 5)),
      //       ]),
      //       const Divider(),
      //     ],
      //   ),
      // ));
      body: SingleChildScrollView(
        // color: Colors.white,
        // elevation: 5,
        child: Center(
          child: FutureBuilder<SerialModal>(
            future: futureVandon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Row(children: const <Widget>[
                    //   Padding(padding: EdgeInsets.only(left: 12)),
                    //   Text("Thông tin lap dat",
                    //       style: TextStyle(fontSize: 18.0, color: Colors.blue)),
                    // ]),
                    // const Divider(),
                    Container(
                      color: Colors.grey,
                      padding: EdgeInsets.only(top:15,left:0,bottom: 15),
                      child: Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 12)),
                        Text("Thông tin lắp đặt",
                          // style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.bold)
                          style: TextStyle(
                            fontFamily:
                            FitnessAppTheme.fontName,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.darkText,
                          ),
                        ),
                      ]),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Container (
                              child: Row (
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                                    child: Icon(Icons.label_important_outline,size: 18,),
                                  ),
                                  Text(
                                    // '1 Room - 2 Adults',
                                    'Sản phẩm: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data.productGroup.name.toString()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      // color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 0,),
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container (
                              // padding: const EdgeInsets.all(0.0),
                              // width: MediaQuery.of(context).size.width*0.45,
                              child: Row (
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                                    child: Icon(Icons.category,size: 18,),
                                  ),
                                  Text(
                                    // '1 Room - 2 Adults',
                                    'Model: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SelectableText.rich(
                                    TextSpan(
                                      text:'${snapshot.data.modelNo.toString()}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        // color: Colors.red,
                                      ),),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 0,),
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container (
                              // padding: const EdgeInsets.all(0.0),
                              // width: MediaQuery.of(context).size.width*0.45,
                              child: Row (
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                                    child: Icon(Icons.select_all_rounded,size: 18,),
                                  ),
                                  Text(
                                    // '1 Room - 2 Adults',
                                    'Serial: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SelectableText.rich(
                                    TextSpan(
                                      text:'${snapshot.data.serialNo.toString()}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        // color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 0,),
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        child: Column(
                          children: <Widget>[
                            Container (
                              child: Row (
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                                    child: Icon(Icons.label_important_outline,size: 18,),
                                  ),
                                  Text(
                                    // '1 Room - 2 Adults',
                                    'Ngày xuất kho: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "${snapshot.data.manufacturedDate != null ? DateFormat('dd/MM/y').format(snapshot.data.manufacturedDate.toLocal()).toString() : ''}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      // color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 0,),
                    // Material(
                    //   color: Colors.transparent,
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //         left: 0, right: 0, top: 10, bottom: 10),
                    //     child: Column(
                    //       children: <Widget>[
                    //         Container (
                    //           child: Row (
                    //             children: <Widget>[
                    //               Padding(
                    //                 padding: const EdgeInsets.only(left: 5.0,right: 5),
                    //                 child: Icon(Icons.date_range,size: 18,),
                    //               ),
                    //               Text(
                    //                 // '1 Room - 2 Adults',
                    //                 'Thời gian bảo hành: ',
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.bold,
                    //                   fontSize: 16,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 '${DateFormat('dd/MM/y').format(widget.vandon.warrantyActiveDate.toLocal()).toString()} - ${DateFormat('dd/MM/y').format(widget.vandon.warrantyEndDate.toLocal()).toString()}',
                    //                 style: TextStyle(
                    //                   fontWeight: FontWeight.w400,
                    //                   fontSize: 16,
                    //                   // color: Colors.red,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 0, top: 10, bottom: 10),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container (
                              // padding: const EdgeInsets.all(0.0),
                              // width: MediaQuery.of(context).size.width*0.45,
                              child: Column (
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    // const Padding(padding: EdgeInsets.only(left: 5)),
                                    SelectableText.rich(
                                      TextSpan(
                                          text: ' ',
                                          // style: TextStyle(fontSize: 12),
                                          children: [
                                            WidgetSpan(
                                              child: Container(
                                                padding: EdgeInsets.only(right:5.0),
                                                child: Icon(Icons.date_range,size: 16.0,),
                                              ),
                                            ),
                                            TextSpan(
                                              text: "Thời gian bảo hành: ",
                                              style: TextStyle(
                                                fontFamily:
                                                FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 0.0,
                                                color: FitnessAppTheme.darkText,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "${DateFormat('dd/MM/y').format(snapshot.data.warrantyActiveDate.toLocal()).toString()} - ${DateFormat('dd/MM/y').format(snapshot.data.warrantyEndDate.toLocal()).toString()}",
                                              style: TextStyle(
                                                fontFamily:
                                                FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                letterSpacing: 0.0,
                                                color: FitnessAppTheme.darkText,
                                              ),
                                              // style: TextStyle(color: Colors.red)
                                            ),
                                          ]
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    const Divider(height: 0,),
                    Container(
                      color: Colors.grey,
                      padding: EdgeInsets.only(top:15,left:0,bottom: 15),
                      child: Row(children: <Widget>[
                        const Padding(padding: EdgeInsets.only(left: 12)),
                        Text("Thông tin khách hàng",
                          // style: TextStyle(fontSize: 16.0, color: Colors.black,fontWeight: FontWeight.bold)
                          style: TextStyle(
                            fontFamily:
                            FitnessAppTheme.fontName,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: 0.0,
                            color: FitnessAppTheme.darkText,
                          ),
                        ),
                      ]),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container (
                              // padding: const EdgeInsets.all(0.0),
                              // width: MediaQuery.of(context).size.width*0.45,
                              child: Row (
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                                    child: Icon(Icons.person,size: 18,),
                                  ),
                                  Text(
                                    // '1 Room - 2 Adults',
                                    'Tên khách: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '${snapshot.data.contactName}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      // color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 0,),
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container (
                              // padding: const EdgeInsets.all(0.0),
                              // width: MediaQuery.of(context).size.width*0.45,
                              child: Row (
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0,right: 5),
                                    child: Icon(Icons.phone,size: 18,),
                                  ),
                                  Text(
                                    // '1 Room - 2 Adults',
                                    'Điện thoại: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SelectableText.rich(
                                    TextSpan(
                                      text:'${snapshot.data.contactPhoneNo}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        // color: Colors.red,
                                      ),),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const Divider(height: 0,),
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 2, right: 0, top: 10, bottom: 10),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container (
                              // padding: const EdgeInsets.all(0.0),
                              // width: MediaQuery.of(context).size.width*0.45,
                              child: Column (
                                children: <Widget>[
                                  Column(children: <Widget>[
                                    // const Padding(padding: EdgeInsets.only(left: 5)),
                                    Text.rich(
                                      TextSpan(
                                          text: ' ',
                                          // style: TextStyle(fontSize: 12),
                                          children: [
                                            WidgetSpan(
                                              child: Container(
                                                padding: EdgeInsets.only(right:5.0),
                                                child: Icon(Icons.location_on_outlined,size: 16.0,),
                                              ),
                                            ),
                                            TextSpan(
                                              text: "Địa chỉ: ",
                                              style: TextStyle(
                                                fontFamily:
                                                FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 0.0,
                                                color: FitnessAppTheme.darkText,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "${snapshot.data.contactAddress} , ${snapshot.data.contactDistrict.toString() != "null" ? snapshot.data.contactDistrict : 'NA' }, ${
                                                  cities.firstWhere(
                                                        (city) => city.id == snapshot.data.contactCity.toString(),
                                                    orElse: () => null,
                                                  )
                                              }",
                                              style: TextStyle(
                                                fontFamily:
                                                FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                letterSpacing: 0.0,
                                                color: FitnessAppTheme.darkText,
                                              ),
                                              // style: TextStyle(color: Colors.red)
                                            ),
                                          ]
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}



