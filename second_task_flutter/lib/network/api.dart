import 'dart:convert';

import 'package:second_task_flutter/improvisation_state.dart';
import 'package:http/http.dart' as http;
import 'package:second_task_flutter/models/city.dart';
import 'package:second_task_flutter/models/user.dart';

const String _api = "https://my-json-server.typicode.com/urglmorl/demo";

/// Здесь подкладываем header с "токеном"
Future<dynamic> ajaxGet(String serviceName) async {
  var responseBody;
  try {
    var response = await http.get('$_api$serviceName', headers: {
      'WWW-Authenticate': ImprovisationState.currentUser.token,
    });

    if (response.statusCode == 200) {
      responseBody = response.body;
    } else if (response.statusCode > 200) {
      return Future.error(response.body);
    }
  } catch (e) {
    throw new Exception("AJAX ERROR");
  }
  return responseBody;
}

Future<User> Auth() async {
  var responseBody;
  try {
    /// По науке нужно использовать это:
    //var response = await http.post('$_api/user', body: user);
    /// Но сервер импровизированный и не даст использовать post метод
    var response = await http.get('$_api/user');
    if (response.statusCode == 200) {
      final decode = json.decode(response.body) as dynamic;
      responseBody = User.fromJson(decode);
    } else if (response.statusCode > 200) {
      return Future.error(response.body);
    }
  } catch (e) {
    throw new Exception("AJAX ERROR");
  }
  return responseBody;
}

Future<List<City>> getCities() async {
  List<City> data = List();
  try {
    var decode = json.decode(await ajaxGet('/cities')) as List<dynamic>;
    decode.forEach((element) {
      data.add(City.fromJson(element));
    });
  } catch (e) {
    return List();
  }
  return data;
}

Future<City> getCityById(int id) async {
  City data = City();
  try {
    var decode = json.decode(await ajaxGet('/cities/$id'));
    data = City.fromJson(decode);
  } catch (e) {
    return City();
  }
  return data;
}
