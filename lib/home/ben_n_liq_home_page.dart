import 'package:ben_n_liq_app/drawer/drawer.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:ben_n_liq_app/list_liquid/list_liquid_page.dart';
import 'package:flutter/material.dart';

class BenNLiqApp extends StatelessWidget {
  final LiquidService _liquidService;

  BenNLiqApp(this._liquidService);

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
              color: Colors.grey, fontFamily: 'Raleway', fontSize: 25.0),
          subhead: TextStyle(
              color: Colors.black, fontFamily: 'Raleway', fontSize: 20.0),
          subtitle: TextStyle(
              color: Colors.grey, fontFamily: 'Raleway', fontSize: 15.0),
          button: TextStyle(
              color: Colors.white, fontFamily: 'Raleway', fontSize: 20.0),
          title: TextStyle(
              color: Colors.black, fontFamily: 'Raleway', fontSize: 50.0),
          overline: TextStyle(
              color: Colors.black, fontFamily: 'Raleway', fontSize: 20.0),
        ),
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(
            title: TextStyle(
                color: Colors.white, fontFamily: 'Raleway', fontSize: 25.0),
          ),
          color: Colors.red,
        ),
        primaryTextTheme: TextTheme(
          title: TextStyle(
              color: Colors.black, fontFamily: 'Raleway', fontSize: 50.0),
          subtitle: TextStyle(
              color: Colors.black, fontFamily: 'Raleway', fontSize: 40.0),
          overline: TextStyle(
              color: Colors.grey, fontFamily: 'Raleway', fontSize: 25.0),
        ),
        buttonColor: Colors.red,
        disabledColor: Color.fromRGBO(223, 177, 180, 0.0),
      ),
      home: BenNLiqHome(this._liquidService),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BenNLiqHome extends StatefulWidget {
  final LiquidService _liquidService;

  BenNLiqHome(this._liquidService, {Key key}) : super(key: key);

  @override
  _BenNLiqHomeState createState() => _BenNLiqHomeState();
}

class _BenNLiqHomeState extends State<BenNLiqHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListLiquidsPage(
          widget._liquidService, DrawerActions.LiquidsNotEmpty, "Liquid's Ben"),
    );
  }
}
