import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bloc/authentication_bloc.dart';

import 'package:dio/dio.dart';
import 'package:GTNexpress/main_screen.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Drawer(
    //   child: ListView(
    //     children: [
    //       new DrawerHeader(
    //         child: Image.asset("assets/images/logo.png"),
    //         decoration: new BoxDecoration(color: Colors.orange),
    //       ),
    //       SizedBox(
    //           // height: 120.0,
    //           child: DrawerHeader(
    //             child: Image.asset("assets/images/logo.png"),
    //             // decoration: BoxDecoration(color: Colors.greenAccent),
    //             margin: const EdgeInsets.all(5.0),
    //             padding: const EdgeInsets.all(5.0),
    //           ),
    //       ),
    //       // DrawerListTile(
    //       //   title: "KHBH",
    //       //   svgSrc: "assets/icons/menu_tran.svg",
    //       //   // press: () {},
    //       //   press: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormAddScreen(),));},
    //       //
    //       // ),
    //       DrawerListTile(
    //         title: "Tài khoản",
    //         svgSrc: "assets/icons/menu_profile.svg",
    //         // press: () {},
    //         press: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormRegister(),));},
    //
    //       ),
    //       // DrawerListTile(
    //       //   title: "Tài khoản",
    //       //   svgSrc: "assets/icons/menu_profile.svg",
    //       //   // press: () {},
    //       //   press: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePageXZA(),));},
    //       //
    //       // ),
    //       // DrawerListTile(
    //       //   title: "Add TK",
    //       //   svgSrc: "assets/icons/menu_profile.svg",
    //       //   // press: () {},
    //       //   press: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormAddScreen(),));},
    //       //
    //       // ),
    //       DrawerListTile(
    //         title: "Logout",
    //         svgSrc: "assets/icons/menu_setting.svg",
    //         press: () {
    //           BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
    //         },
    //       ),
    //     ],
    //   ),
    // );

    return ListView(
      children: [
        new DrawerHeader(
          child: Image.asset("assets/images/gtnlogo.jpg"),
          // decoration: new BoxDecoration(color: Colors.orange),
        ),
        //   SizedBox(
        //   height: 64.0,
        //   child: DrawerHeader(
        //     child: Image.asset("assets/images/logo.png"),
        //     // decoration: BoxDecoration(color: Colors.greenAccent),
        //     margin: const EdgeInsets.all(0.0),
        //     padding: const EdgeInsets.all(0.0),
        //   ),
        // ),
        DrawerListTile(
          title: "Tài khoản",
          svgSrc: "assets/icons/menu_profile.svg",
          // press: () {},
          press: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(),));},
        ),
        DrawerListTile(
          title: "Đăng xuất",
          svgSrc: "assets/icons/menu_setting.svg",
          press: () {
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          },
        ),
      ],
    );

  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    this.title,
    this.svgSrc,
    this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.blueAccent,
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.blueGrey),
      ),
    );
  }
}
