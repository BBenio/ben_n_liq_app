import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ErrorPermissionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ben\'n\'Liq',
      theme: ThemeData(
        textTheme: TextTheme(
          subhead: TextStyle(
              color: Colors.black, fontFamily: 'Raleway', fontSize: 20.0),
          subtitle: TextStyle(
              color: Colors.grey, fontFamily: 'Raleway', fontSize: 15.0),
          title: TextStyle(
              color: Colors.black, fontFamily: 'Raleway', fontSize: 40.0),
        ),
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
          title: new Text(
            "Merci d'autoriser le stockage",
            style: Theme.of(context).textTheme.title,
          ),
          content: new Text("Autoriser le stockage dans les parametres",
              style: Theme.of(context).textTheme.subhead),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Fermer",
                style: Theme.of(context).textTheme.subtitle,
              ),
              onPressed: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
            )
          ],
        ));
  }
}
