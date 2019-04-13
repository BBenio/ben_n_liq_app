import 'package:ben_n_liq_app/drawer.dart';
import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:ben_n_liq_app/list_liquid_page.dart';
import 'package:flutter/material.dart';

Future main() async {
  LiquidService liquidService = LiquidService();
  List<Liquid> liquids = List<Liquid>();

//  liquids = await liquidService.loadLiquidsAssets();
//  liquids = await liquidService.loadLiquidsDirectory();
//  liquids = await liquidService.loadLiquidsHistory();
//  liquidService.saveLiquidsHistory(liquids);
//  liquidService.saveLiquids(liquids);

  runApp(MyApp(liquidService));
}

class MyApp extends StatelessWidget {
  final LiquidService liquidService;

  MyApp(this.liquidService);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ben\'n\'Liq',
      theme: ThemeData(
        primaryColor: Colors.red,
        textSelectionColor: Colors.red,
        backgroundColor: Colors.red,
        bottomAppBarColor: Colors.redAccent,
        textTheme: TextTheme(
          body1: TextStyle(
              color: Colors.grey, fontFamily: 'IndieFlower', fontSize: 25.0),
          subhead: TextStyle(
              color: Colors.black, fontFamily: 'IndieFlower', fontSize: 20.0),
          subtitle: TextStyle(
              color: Colors.grey, fontFamily: 'IndieFlower', fontSize: 15.0),
          button: TextStyle(
              color: Colors.white, fontFamily: 'IndieFlower', fontSize: 20.0),
          title: TextStyle(
              color: Colors.black, fontFamily: 'IndieFlower', fontSize: 50.0),
          overline: TextStyle(
              color: Colors.black, fontFamily: 'IndieFlower', fontSize: 20.0),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white, fontFamily: 'IndieFlower', fontSize: 25.0),
          ),
          color: Colors.red,
        ),
        primaryTextTheme: TextTheme(
          title: TextStyle(
              color: Colors.black, fontFamily: 'IndieFlower', fontSize: 50.0),
          subtitle: TextStyle(
              color: Colors.black, fontFamily: 'IndieFlower', fontSize: 40.0),
          overline: TextStyle(
              color: Colors.grey, fontFamily: 'IndieFlower', fontSize: 25.0),
        ),
        buttonColor: Colors.red,
        disabledColor: Color.fromRGBO(223, 177, 180, 0.0),
      ),
      home: MyHomePage(this.liquidService),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final LiquidService liquidService;

  MyHomePage(this.liquidService, {Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListLiquidsPage(
          widget.liquidService, DrawerActions.LiquidsNotEmpty, "Liquid's Ben"),
    );
  }
}
