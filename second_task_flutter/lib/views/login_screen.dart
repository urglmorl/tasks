import 'package:flutter/material.dart';
import 'package:second_task_flutter/improvisation_state.dart';
import 'package:second_task_flutter/network/api.dart';
import 'package:second_task_flutter/views/main_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<StatefulWidget> createState() => new _LoginState();
}

class _LoginState extends State<LoginScreen> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            isError
                ? Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'wrong credentials',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  )
                : Container(),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: loginController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'login',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: RaisedButton(
                textColor: Colors.white,
                color: Colors.blue,
                child: Text('Login'),
                onPressed: () async {
                  /*var user = ImprovisationState.currentUser;
                  user.login = loginController.text;
                  user.password = passwordController.text;
                  ImprovisationState.currentUser = user;

                  Auth().then((value) {
                    user.token = value;
                    ImprovisationState.currentUser = user;*/
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                  /*}, onError: (error) {
                    setState(() {
                      isError = true;
                    });
                  });*/
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
