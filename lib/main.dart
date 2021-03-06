import 'package:flutter/material.dart';
import 'package:todo_app/utilities/utils.dart';
import 'package:todo_app/views/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: customBlue),
          subtitle1: TextStyle(color: Colors.grey),
        ),
        shadowColor: Colors.white38,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: const Color.fromRGBO(249, 251, 255, 1),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: customBlue),
            titleTextStyle: TextStyle(
                color: customBlue, fontSize: 21, fontWeight: FontWeight.w600),
            actionsIconTheme: IconThemeData(color: customBlue)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey.shade300,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            subtitle1: TextStyle(color: Colors.grey),
          ),
          shadowColor: Colors.black38,
          primaryColor: Colors.black,
          appBarTheme: const AppBarTheme(
              //backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w600),
              actionsIconTheme: IconThemeData(color: Colors.white)),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(229, 232, 249, 5),
          ),
          floatingActionButtonTheme:
              const FloatingActionButtonThemeData(backgroundColor: Colors.grey)),
      themeMode: ThemeMode.system,
      home:  HomeView(),
    );
  }
}
