import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_form.dart';
import 'package:ben_n_liq_app/liquid_list.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:ben_n_liq_app/parser.dart';
import 'package:flutter/material.dart';

Future main() async {
  LiquidService liquidService = LiquidService();

//  List<Liquid> liquids = List<Liquid>();
//  liquids = await liquidService.loadLiquidsAssets();
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
              color: Colors.white, fontFamily: 'IndieFlower', fontSize: 25.0),
          overline: TextStyle(
              color: Colors.black, fontFamily: 'IndieFlower', fontSize: 20.0),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.red,
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
  List<Liquid> _liquids = List<Liquid>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    setState(() {
      _liquids.clear();
    });
    widget.liquidService.loadLiquidsDirectory().then((List<Liquid> l) {
      setState(() {
        _liquids.addAll(l);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      drawer: buildDrawer(context),
      floatingActionButton: buildFloatingActionButton(context),
      body: _liquids.length > 0
          ? LiquidList(_liquids, widget.liquidService, _scaffoldKey)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        'Liquid\'s Ben',
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  _showDialogAddLiquid(BuildContext context) async {
    Liquid liquid = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LiquidForm()),
    );

    if (liquid != null) {
      setState(() {
        _liquids.add(liquid);
      });
      widget.liquidService
          .saveLiquids(_liquids)
          .then((f) => _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Enregistrés !'),
                duration: Duration(seconds: 1),
              )));
    }
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        _showDialogAddLiquid(context);
      },
      backgroundColor: Theme.of(context).buttonColor,
    );
  }

  Drawer buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          buildHeader(context),
          buildButtonToBuy(context),
          buildButtonAllLiquids(context),
          buildButtonTemp(context)
        ],
      ),
    );
  }

  DrawerHeader buildHeader(BuildContext context) {
    return DrawerHeader(
      child: Container(
        child: Text(
          'Ben\'n\'Liq App',
          style: Theme.of(context).textTheme.title,
        ),
        alignment: Alignment(0.0, 0.0),
      ),
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
    );
  }

  ListTile buildButtonTemp(BuildContext context) {
    return ListTile(
      title: Text("temp"),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => FlutterDemo(storage: CounterStorage())),
        );
      },
    );
  }

  ListTile buildButtonAllLiquids(BuildContext context) {
    return ListTile(
      title: Text(
        'Liste complete',
        style: Theme.of(context).textTheme.overline,
      ),
      leading: Icon(Icons.all_inclusive),
    );
  }

  ListTile buildButtonToBuy(BuildContext context) {
    return ListTile(
      title: Text('A acheter', style: Theme.of(context).textTheme.overline),
      leading: Icon(Icons.exposure_zero),
    );
  }
}
