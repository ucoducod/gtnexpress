import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:GTNexpress/user_repository.dart';

import 'package:GTNexpress/bloc/authentication_bloc.dart';
import 'package:GTNexpress/splash/splash.dart';
import 'package:GTNexpress/login/login_page.dart';
import 'package:GTNexpress/common.dart';

// #copy
import 'package:GTNexpress/constants.dart';
import 'package:GTNexpress/MenuController.dart';
import 'package:GTNexpress/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


void main() {
  final userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted());
    },
    child: App(userRepository: userRepository),
  ));
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  int currentPage = 0;

  GlobalKey bottomNavigationKey = GlobalKey();

  App({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   brightness: Brightness.light,
      // ),
      // title: 'GTNexpress',
      // localizationsDelegates: [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: [
      //   Locale('en', ''), // English, no country code
      //   Locale('vi', ''), // Spanish, no country code
      // ],
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.blue),
        canvasColor: secondaryColor,
      ),
      // home: ContactsPage()
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUninitialized) {
            return const SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            // return HomePageA();
            // return JsonApiPhp();
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => MenuController(),
                ),
              ],
              child: MainScreenX(),
            );
            // return DashboardScreen();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(
              userRepository: userRepository,
            );
          }
          return LoadingIndicator();
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
