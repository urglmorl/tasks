import 'package:flutter/material.dart';
import 'package:second_task_flutter/models/city.dart';
import 'package:second_task_flutter/network/api.dart';

class EditScreen extends StatelessWidget {
  static const routeName = '/edit';

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final Future<City> city =
        getCityById(ModalRoute.of(context).settings.arguments);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<City>(
          future: city,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final city = snapshot.data;
              nameController.text = city.name;
              return ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: city.postcode,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Image.network(city.emblem),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
