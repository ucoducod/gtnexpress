import 'package:GTNexpress/login/bloc/login_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:GTNexpress/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GTNexpress/login/bloc/login_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool isChecked = false;

  bool _isFieldUsernameValid;
  bool _isFieldPasswordValid;

  final double circleRadius = 20.0;
  final _key1 = GlobalKey<State<StatefulWidget>>();
  final dataKey = new GlobalKey();
  // @override
  // void initState() {
  //   _passwordVisible = false;
  // }
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    // _usernameController.addListener(() {
    //   print(_usernameController.text);
    // });
    // _passwordController.addListener(() {
    //   print(_passwordController.text);
    // });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> ensureVisibleOnTextArea({GlobalKey textfieldKey}) async {
    final keyContext = textfieldKey.currentContext;
    if (keyContext != null) {
      await Future.delayed(const Duration(milliseconds: 500)).then(
            (value) => Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 200),
          curve: Curves.decelerate,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      print("_onLoginButtonPressed");
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ));
    }

    // final datapassKey = new GlobalKey();

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {

          return Scaffold(
            // backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              // image: AssetImage('assets/images/logo.png'),
                              image: AssetImage('assets/images/gtnlogo.jpg'),
                              fit: BoxFit.scaleDown
                            )
                        ),
                        child: Stack(
                          children: <Widget>[
                            // Positioned(
                            //     // top: 30.0,
                            //     bottom: 0.0,
                            //     right: 0.0,
                            //     left: 0.0,
                            //     child: Padding(
                            //       padding:
                            //       const EdgeInsets.symmetric(horizontal: 8.0),
                            //       child: Container(
                            //         // color: Colors.blue,
                            //           child: const Center(
                            //             child: Text(
                            //               'Đăng nhập tài khoản',
                            //               style: TextStyle(
                            //                 // color: Color(0xffF6C37F),
                            //                   color: Colors.black,
                            //                   fontSize: 16,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           )),
                            //     )),



                            // Align(
                            //   alignment: AlignmentDirectional.topCenter, // <-- SEE HERE
                            //   child: Container(
                            //     width: 200,
                            //     height: 200,
                            //     // color: Colors.redAccent,
                            //     child: FadeInUp(duration: Duration(milliseconds: 1200), child: Container(
                            //       decoration: BoxDecoration(
                            //           image: DecorationImage(
                            //               image: AssetImage('assets/images/logo.png')
                            //           )
                            //       ),
                            //     ),),
                            //   ),
                            // ),

                            // Positioned(
                            //   left: 70,
                            //   width: 220,
                            //   height: 220,
                            //   child: FadeInUp(duration: Duration(milliseconds: 1200), child: Container(
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //             image: AssetImage('assets/images/logo.png')
                            //         )
                            //     ),
                            //   )),
                            // ),
                            // Positioned(
                            //   right: 40,
                            //   top: 40,
                            //   width: 80,
                            //   height: 150,
                            //   child: FadeInUp(duration: Duration(milliseconds: 1300), child: Container(
                            //     decoration: BoxDecoration(
                            //         image: DecorationImage(
                            //             image: AssetImage('assets/images/logo.png')
                            //         )
                            //     ),
                            //   )),
                            // ),
                            // Positioned(
                            //   child: FadeInUp(duration: Duration(milliseconds: 1600), child: Container(
                            //     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.40),
                            //     child: Center(
                            //       child: Text("Login", style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),),
                            //     ),
                            //   )),
                            // )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Column(
                          children: <Widget>[
                            // FadeInUp(duration: Duration(milliseconds: 1800), child: Container(
                            //   padding: EdgeInsets.all(35),
                            //   decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       // borderRadius: BorderRadius.circular(10),
                            //       // border: Border.all(color: Color.fromRGBO(143, 148, 251, 1)),
                            //       // boxShadow: [
                            //       //   BoxShadow(
                            //       //       color: Color.fromRGBO(143, 148, 251, .2),
                            //       //       blurRadius: 20.0,
                            //       //       offset: Offset(0, 10)
                            //       //   )
                            //       // ]
                            //   ),
                            //   child: Column(
                            //     children: <Widget>[
                            //       // Container(
                            //       //   padding: EdgeInsets.all(8.0),
                            //       //   decoration: BoxDecoration(
                            //       //       border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
                            //       //   ),
                            //       //   child: TextField(
                            //       //     decoration: InputDecoration(
                            //       //         border: InputBorder.none,
                            //       //         hintText: "Email or Phone number",
                            //       //         hintStyle: TextStyle(color: Colors.grey[700])
                            //       //     ),
                            //       //   ),
                            //       // ),
                            //
                            //       // Container(
                            //       //   padding: EdgeInsets.all(8.0),
                            //       //   // decoration: BoxDecoration(
                            //       //   //     border: Border(bottom: BorderSide(color:  Color.fromRGBO(143, 148, 251, 1)))
                            //       //   // ),
                            //       //   child: TextFormField(
                            //       //     controller: _passwordController,
                            //       //     // obscureText: true,
                            //       //     obscureText: !_passwordVisible,//This will obscure text dynamically
                            //       //
                            //       //     // style: theme.textTheme.bodyText2,
                            //       //     // keyboardType: TextInputType.text,
                            //       //     // enableInteractiveSelection: false,
                            //       //     decoration: InputDecoration(
                            //       //       // enabledBorder: OutlineInputBorder(
                            //       //       //   borderSide: BorderSide(color: Colors.yellow,width: 3),
                            //       //       // ),
                            //       //       enabledBorder: OutlineInputBorder(
                            //       //         borderRadius: BorderRadius.circular(25.0),
                            //       //         borderSide:  BorderSide(color: Colors.grey,width: 2),
                            //       //       ),
                            //       //       focusedBorder: OutlineInputBorder(
                            //       //         borderRadius: BorderRadius.circular(25.0),
                            //       //         borderSide:  BorderSide(color: const Color(0xFFc7a500),width: 2),
                            //       //       ),
                            //       //       labelText: "Mật khẩu",
                            //       //       labelStyle: TextStyle(
                            //       //         // color: const Color(0xFFc7a500),
                            //       //         color: Colors.black,
                            //       //         fontSize: 18.0,
                            //       //         fontWeight: FontWeight.bold,
                            //       //       ),
                            //       //       // labelStyle: theme.textTheme.headline6,
                            //       //       // suffixText: suffixText ?? '',
                            //       //       hintText: '',
                            //       //       floatingLabelBehavior: FloatingLabelBehavior.always,
                            //       //       // Here is key idea
                            //       //       suffixIcon: IconButton(
                            //       //         icon: Icon(
                            //       //           // Based on passwordVisible state choose the icon
                            //       //           _passwordVisible
                            //       //               ? Icons.visibility
                            //       //               : Icons.visibility_off,
                            //       //           color: Theme.of(context).primaryColorDark,
                            //       //         ),
                            //       //         onPressed: () {
                            //       //           // Update the state i.e. toogle the state of passwordVisible variable
                            //       //           setState(() {
                            //       //             _passwordVisible = !_passwordVisible;
                            //       //           });
                            //       //         },
                            //       //       ),
                            //       //     ),
                            //       //   ),
                            //       // ),
                            //       // Container(
                            //       //   padding: EdgeInsets.all(8.0),
                            //       //   child: TextField(
                            //       //     obscureText: true,
                            //       //     decoration: InputDecoration(
                            //       //         border: InputBorder.none,
                            //       //         hintText: "Password",
                            //       //         hintStyle: TextStyle(color: Colors.grey[700])
                            //       //     ),
                            //       //   ),
                            //       // )
                            //       // Container(
                            //       // margin: EdgeInsets.only(top: 0.0, bottom:0.0),
                            //       // child: Center(
                            //       //   child:
                            //       //   Row(
                            //       //       mainAxisAlignment: MainAxisAlignment.start,
                            //       //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       //       children: <Widget>[
                            //       //         Checkbox(
                            //       //           checkColor: Colors.white,
                            //       //           value: isChecked,
                            //       //           onChanged: (bool value) {
                            //       //             setState(() {
                            //       //               isChecked = value;
                            //       //               // if (isChecked==true) {
                            //       //               //   isChecked = false;
                            //       //               // } else {
                            //       //               //   isChecked = true;
                            //       //               // }
                            //       //             });
                            //       //           },
                            //       //         ),
                            //       //         const Text(
                            //       //           'Remmeber me',
                            //       //           style: TextStyle(fontSize: 16.0),
                            //       //         ),
                            //       //         // const Text(
                            //       //         //   'Forget pass',
                            //       //         //   style: TextStyle(fontSize: 16.0),
                            //       //         // ),
                            //       //       ]),
                            //       //     ),
                            //       // ),
                            //     ],
                            //   ),
                            // )),
                            Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    // margin: EdgeInsets.only(top: 0),
                                    height: 300,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(16.0),
                                      // border: Border.all(color: Colors.blueAccent),
                                    ),
                                    child: Align(
                                      alignment: Alignment(-1, -1),
                                      // child:Text(
                                      //   "username",
                                      //   style: TextStyle(
                                      //     fontSize: 15.0,
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.red,
                                      //   ),
                                      // ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:70.0,right: 70.0,top:0.0),
                                        child: TextFormField(
                                          controller: _usernameController,
                                          // style: theme.textTheme.bodyText2,
                                          keyboardType: TextInputType.text,
                                          // enableInteractiveSelection: false,
                                          decoration: InputDecoration(
                                            // enabledBorder: OutlineInputBorder(
                                            //   borderSide: BorderSide(color: Colors.yellow,width: 3),
                                            // ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(45.0),
                                                borderSide:  BorderSide(color: (_isFieldUsernameValid == null || _isFieldUsernameValid)?Colors.grey:Colors.red,width: 2),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(45.0),
                                                borderSide:  BorderSide(color: Color(0xFFc7a500),width: 2),
                                              ),
                                              labelText: "Tên đăng nhập",
                                              labelStyle: TextStyle(
                                                // color: const Color(0xFFc7a500),
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              // labelStyle: theme.textTheme.headline6,
                                              suffixText: '',
                                              // errorText: _isFieldUsernameValid == null || _isFieldUsernameValid
                                              //     ? null
                                              //     : "Nhập tên đăng nhập",
                                              hintText: '',
                                              isDense: true, // important line
                                              floatingLabelBehavior: FloatingLabelBehavior.always
                                          ),

                                          onTap: () async {
                                            ensureVisibleOnTextArea(textfieldKey: dataKey);
                                            Scrollable.ensureVisible(
                                              dataKey.currentContext,
                                              duration: const Duration(milliseconds: 200),
                                              curve: Curves.decelerate,
                                            );
                                          },

                                          onChanged: (value) {
                                            // print("username valid?");
                                            bool isFieldValid = value.trim().isNotEmpty;
                                            if (isFieldValid != _isFieldUsernameValid) {
                                              setState(() => _isFieldUsernameValid = isFieldValid);
                                            }
                                          },

                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // margin: EdgeInsets.only(top: 18),
                                    height: 170,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // borderRadius: BorderRadius.circular(16.0),
                                      // border: Border.all(color: Colors.blueAccent),
                                    ),
                                    child: Align(
                                      alignment: Alignment(-1, -1),
                                      // child:Text(
                                      //   "username",
                                      //   style: TextStyle(
                                      //     fontSize: 15.0,
                                      //     fontWeight: FontWeight.bold,
                                      //     color: Colors.red,
                                      //   ),
                                      // ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left:70.0,right: 70.0,top:10.0),
                                        child: TextFormField(
                                          controller: _passwordController,
                                          // obscureText: true,
                                          obscureText: !_passwordVisible,//This will obscure text dynamically
                                          // style: theme.textTheme.bodyText2,
                                          // keyboardType: TextInputType.text,
                                          // enableInteractiveSelection: false,
                                          decoration: InputDecoration(
                                            // enabledBorder: OutlineInputBorder(
                                            //   borderSide: BorderSide(color: Colors.yellow,width: 3),
                                            // ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(45.0),
                                              // borderSide:  BorderSide(color: Colors.grey,width: 2),
                                              borderSide:  BorderSide(color: (_isFieldPasswordValid == null || _isFieldPasswordValid)?Colors.grey:Colors.red,width: 2),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(45.0),
                                              borderSide:  BorderSide(color: const Color(0xFFc7a500),width: 2),
                                            ),
                                            labelText: "Mật khẩu",
                                            labelStyle: TextStyle(
                                              // color: const Color(0xFFc7a500),
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            // labelStyle: theme.textTheme.headline6,
                                            // suffixText: suffixText ?? '',
                                            // errorText: _isFieldPasswordValid == null || _isFieldPasswordValid
                                            //     ? null
                                            //     : "Nhập tên đăng nhập",//Work but faile UI
                                            hintText: '',
                                            floatingLabelBehavior: FloatingLabelBehavior.always,
                                            isDense: true, // important line
                                            // Here is key idea
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                // Based on passwordVisible state choose the icon
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: Theme.of(context).primaryColorDark,
                                              ),
                                              onPressed: () {
                                                // Update the state i.e. toogle the state of passwordVisible variable
                                                setState(() {
                                                  _passwordVisible = !_passwordVisible;
                                                });
                                              },
                                            ),


                                          ),
                                          onChanged: (value) {
                                            bool isFieldValid = value.trim().isNotEmpty;
                                            if (isFieldValid != _isFieldPasswordValid) {
                                              setState(() => _isFieldPasswordValid = isFieldValid);
                                            }
                                          },
                                          onTap: () async {
                                            ensureVisibleOnTextArea(textfieldKey: dataKey);
                                            Scrollable.ensureVisible(
                                              dataKey.currentContext,
                                              duration: const Duration(milliseconds: 200),
                                              curve: Curves.decelerate,
                                            );
                                          },
                                          // onTap: () async {
                                          //   ensureVisibleOnTextArea(textfieldKey: datapassKey);
                                          //   Scrollable.ensureVisible(
                                          //     datapassKey.currentContext,
                                          //     duration: const Duration(milliseconds: 200),
                                          //     curve: Curves.decelerate,);
                                          // },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0, right: 18.0 ,bottom: 30.0,),
                                    child: Container(
                                      key: dataKey,
                                      margin: EdgeInsets.only(top: 200),
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.teal,
                                        borderRadius: BorderRadius.all(Radius.circular(25)),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: 260,
                                    height: 70,
                                    // height: MediaQuery.of(context).size.width * 0.14,
                                    child: Padding(
                                      // key: datapassKey,
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.red,
                                            onPrimary: Colors.white,
                                            // side: BorderSide(
                                            //     width: 1,
                                            //     color: primaryBlue),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                  20,
                                                ))),
                                        // style: ElevatedButton.styleFrom(
                                        //   primary: Colors.red, // background
                                        //   onPrimary: Colors.white, // foreground
                                        // ),


                                        // onPressed: state is! LoginLoading ? _onLoginButtonPressed : null,
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          if (
                                          _usernameController.text == "" ||
                                              _passwordController.text == "" ||
                                              !_isFieldUsernameValid ||
                                              !_isFieldPasswordValid
                                          ) {
                                            setState(() {
                                              if (_usernameController.text == "" || !_isFieldUsernameValid){
                                                _isFieldUsernameValid = false;
                                              }
                                              if (_passwordController.text == "" || !_isFieldPasswordValid){
                                                _isFieldPasswordValid = false;
                                              }
                                            });
                                            Scaffold.of(context).showSnackBar(SnackBar(
                                              content: Text("Vui lòng nhập thông tin đăng nhập"),
                                              backgroundColor: Colors.red,
                                            ));
                                            return;
                                          } else {
                                            _onLoginButtonPressed();
                                          }
                                          //setState(() => _isLoading = true);
                                        },

                                        child: const Text(
                                          'Đăng nhập',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        // shape: const StadiumBorder(
                                        //   side: BorderSide(
                                        //     color: Colors.blue,
                                        //     width: 2,
                                        //   ),
                                        // ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    width: 260,
                                    height: 180,
                                    // height: MediaQuery.of(context).size.width * 0.14,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 135.0),
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          // ElevatedButton(
                                          //   style: ElevatedButton.styleFrom(
                                          //       primary: Colors.blueGrey,
                                          //       onPrimary: Colors.white,
                                          //       // side: BorderSide(
                                          //       //     width: 1,
                                          //       //     color: primaryBlue),
                                          //       shape: RoundedRectangleBorder(
                                          //           borderRadius:
                                          //           BorderRadius.circular(
                                          //             20,
                                          //           ))),
                                          //   onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreenX(),)); },
                                          //   child: const Text(
                                          //     'Bỏ qua',
                                          //     style: TextStyle(
                                          //       fontSize: 14.0,
                                          //     ),
                                          //   ),
                                          // ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.amber,
                                                onPrimary: Colors.black,
                                                // side: BorderSide(
                                                //     width: 1,
                                                //     color: primaryBlue),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                      20,
                                                    ))),
                                            onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormRegister(),)); },
                                            child: const Text(
                                              'Đăng ký',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Positioned(
                                    // right: 160.0,
                                    top: 285.0,
                                    // bottom: 80,
                                    child: GestureDetector(
                                      onTap: (){
                                        // print("Phone");
                                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreenX(),));
                                        // launch("tel://214324234");
                                        // String telephoneNumber = '+2347012345678';
                                        // String telephoneUrl = "tel:$telephoneNumber";
                                        // void _launchURL() async {
                                        //   if (await canLaunch(_url)) {
                                        //     await launch(_url);
                                        //   } else {
                                        //     throw 'could not launch $_url';
                                        //   }
                                        // }
                                      },
                                      child: Container(
                                        // color: Colors.pink,
                                        height: 50.0,
                                        // width: 100.0,
                                        child:Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            // Icon(Icons.phone,color: Colors.yellowAccent,),
                                            Align(
                                              alignment: Alignment.center,
                                              // child: Text(
                                              //   'Hotline: 0975330531',
                                              //   style: TextStyle(
                                              //     fontSize: 15.0,
                                              //     fontWeight: FontWeight.bold,
                                              //     color: Colors.white,
                                              //   ),
                                              // ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  var _launched = _makePhoneCall('tel:0975330531');
                                                },
                                                child: new Text("0975330531",
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              // child: RaisedButton(
                                              //   onPressed: () => setState(() {
                                              //     var _launched = _makePhoneCall('tel:0975330531');
                                              //   }),
                                              //   child: const Text('Make phone call'),
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // SizedBox(
                                  //   // width: 260,
                                  //   height: 370,
                                  //   // height: MediaQuery.of(context).size.width * 0.14,
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.only(top: 355.0),
                                  //     child: GestureDetector(
                                  //       onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainScreenX(),));},
                                  //       child: const Text(
                                  //         'Bỏ qua',
                                  //         style: TextStyle(
                                  //             fontSize: 14.0,
                                  //             color: Colors.black,
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),

                                  // Container(
                                  //   child: state is LoginLoading
                                  //       ? const CircularProgressIndicator()
                                  //       : null,
                                  // ),
                                  Container(
                                    child: state is LoginLoading
                                        ? const Positioned(child: const CircularProgressIndicator(),)
                                        : null,
                                  ),
                                ]
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
          );


        },
      ),
    );
  }

  bottomModel(String msg) {
    return showModalBottomSheet<void>(context: context, builder: (BuildContext context) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.pink
          ),
          child: Padding(
              padding: const EdgeInsets.all(
                  18.0),
              child: Text(msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0
                  )
              )
          )
      );
    });
  }

}
