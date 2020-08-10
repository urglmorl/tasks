import 'package:flutter/material.dart';
import 'package:second_task_flutter/views/edit_screen.dart';
import 'package:second_task_flutter/views/login_screen.dart';
import 'package:second_task_flutter/views/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        LoginScreen.routeName: (BuildContext context) => LoginScreen(),
        MainScreen.routeName: (BuildContext context) => MainScreen(),
        EditScreen.routeName: (BuildContext context) => EditScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == EditScreen.routeName) {
          final id = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return id;
            },
          );
        }
      },
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
