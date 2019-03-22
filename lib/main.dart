import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_list.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ben\'n\'Liq',
      theme: ThemeData(
          backgroundColor: Colors.blueAccent,
          bottomAppBarColor: Colors.lightBlue,
          textTheme: TextTheme(
            body1: TextStyle(
                color: Colors.grey, fontFamily: 'IndieFlower', fontSize: 25.0),
            subhead: TextStyle(
                color: Colors.black, fontFamily: 'IndieFlower', fontSize: 20.0),
            subtitle: TextStyle(
                color: Colors.grey, fontFamily: 'IndieFlower', fontSize: 15.0),
            button: TextStyle(
                color: Colors.black, fontFamily: 'IndieFlower', fontSize: 20.0),
            title: TextStyle(
                color: Colors.white, fontFamily: 'IndieFlower', fontSize: 25.0),
          )
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }

  List<Liquid> buildLiquidsTemp() {
    List<Liquid> liquids = List<Liquid>();
    liquids.add(Liquid("ONE"));
    liquids.add(Liquid("tWo"));
    liquids.add(Liquid("thrEE"));
    liquids.add(Liquid("For"));
    liquids.add(Liquid("five"));
    liquids.add(Liquid("six"));
    liquids.add(Liquid("seven"));

    return liquids;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Liquid\'s Ben',
            style: Theme.of(context).textTheme.title,
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Container(
                  child: Text(
                    'Ben\'n\'Liq App',
                    style: Theme.of(context).textTheme.title,
                  ),
                  alignment: Alignment(0.0, 0.0),
                ),
                decoration:
                    BoxDecoration(color: Theme.of(context).backgroundColor),
              ),
              ListTile(
                title: Text(
                  'A acheter',
                  style: Theme.of(context).textTheme.button
                ),
                leading: Icon(Icons.exposure_zero),
              ),
              ListTile(
                title: Text(
                  'Liste complete',
                  style: Theme.of(context).textTheme.button,
                ),
                leading: Icon(Icons.all_inclusive),
              )
            ],
          ),
        ),
        body: LiquidList(buildLiquidsTemp()));
  }

  List<Liquid> buildLiquidsTemp() {
    List<Liquid> liquids = List<Liquid>();
    liquids.add(Liquid("one"));
    liquids.add(Liquid("two"));
    liquids.add(Liquid("three"));
    liquids.add(Liquid("for"));
    liquids.add(Liquid("five"));
    liquids.add(Liquid("six"));
    liquids.add(Liquid("seven"));

    return liquids;
  }
}
