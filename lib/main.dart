import 'dart:io';

import 'package:ben_n_liq_app/drawer.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:ben_n_liq_app/list_liquid_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool launch = true;

  if (Platform.isAndroid) {
    PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    while(!(permission == PermissionStatus.granted) && permission != PermissionStatus.denied) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    }
    launch = permission != PermissionStatus.denied;
  }

  LiquidService liquidService = LiquidService();
//  List<Liquid> liquids = List<Liquid>();

//  liquids = await liquidService.loadLiquidsDirectory();
//  liquidService.saveLiquids(liquids);
//  liquidService.saveVisibleLiquids(liquids);
  if (!launch) {
    print("Merci d'autoriser le stockage de données");
    runApp(MyErrorPage());
  } else {
    runApp(MyApp(liquidService));
  }
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

class MyErrorPage extends StatelessWidget {

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
      home: ErrorStoragePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ErrorStoragePage extends StatefulWidget {
  ErrorStoragePage({Key key}) : super(key: key);

  @override
  _ErrorStoragePageState createState() => _ErrorStoragePageState();
}

class _ErrorStoragePageState extends State<ErrorStoragePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AlertDialog(
          title: new Text("Merci d'autoriser le stockage"),
          content: new Text("Autoriser le stockage dans les paramteres"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            )
        ],
    ));
  }
}
