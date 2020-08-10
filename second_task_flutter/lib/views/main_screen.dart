import 'package:flutter/material.dart';
import 'package:second_task_flutter/models/city.dart';
import 'package:second_task_flutter/network/api.dart';
import 'package:second_task_flutter/views/edit_screen.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main';

  @override
  State<StatefulWidget> createState() => new _MainState();
}

class _MainState extends State<MainScreen> {
  Future<List<City>> futureCities;

  @override
  void initState() {
    super.initState();
    futureCities = getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cities'),
      ),
      body: _getListView(),
    );
  }

  Widget _getListView() {
    return FutureBuilder<List<City>>(
      future: futureCities,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final cities = snapshot.data;
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            itemBuilder: (BuildContext _context, int i) {
              return _getRowFromCity(_context, cities[i]);
            },
            itemCount: cities.length,
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }

  Widget _getRowFromCity(BuildContext context, City city) {
    return ListTile(
      title: Text(
        city.name,
        style: TextStyle(fontSize: 18),
      ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          EditScreen.routeName,
          arguments: city.id,
        );
      },
    );
  }
}
