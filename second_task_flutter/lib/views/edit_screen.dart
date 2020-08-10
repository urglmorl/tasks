import 'package:flutter/material.dart';
import 'package:second_task_flutter/models/city.dart';
import 'package:second_task_flutter/network/api.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/edit';
  final int id;

  const EditScreen({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _EditState();
}

class _EditState extends State<EditScreen> {
  TextEditingController nameController = TextEditingController();
  Future<City> city;

  @override
  void initState() {
    super.initState();
    city = getCityById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
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
