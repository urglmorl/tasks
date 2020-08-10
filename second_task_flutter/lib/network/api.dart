import 'package:second_task_flutter/improvisation_state.dart';
import 'package:http/http.dart' as http;
import 'package:second_task_flutter/models/city.dart';

const String _api = "localhost:8080";

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

Future<String> Auth() async {
  var user = ImprovisationState.currentUser;

  var responseBody;
  try {
    var response = await http.post('$_api/auth', body: user);
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

Future<List<City>> getCities() async {
  return await ajaxGet('/cities');
}

Future<City> getCityById(int id) async {
  return await ajaxGet('/cities/$id');
}
