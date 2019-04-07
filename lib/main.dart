import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_form.dart';
import 'package:ben_n_liq_app/liquid_list.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:ben_n_liq_app/list_liquid_page.dart';
import 'package:ben_n_liq_app/parser.dart';
import 'package:flutter/material.dart';

Future main() async {
  LiquidService liquidService = LiquidService();

  List<Liquid> liquids = List<Liquid>();
  liquids = await liquidService.loadLiquidsDirectory();
  liquidService.saveLiquidsHistory(liquids);
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
      drawer: DrawerLiquids(widget.liquidService),
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
        style: Theme.of(context).appBarTheme.textTheme.title,
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
}

class DrawerLiquids extends StatelessWidget {
  final List<Liquid> allLiquids = [];
  final LiquidService liquidService;
  final List<Liquid> liquidsNotEmpty = [];
  final List<Liquid> liquidsEmpty = [];

  DrawerLiquids(this.liquidService);

  @override
  Widget build(BuildContext context) {
    liquidService.loadLiquidsDirectory().then((List<Liquid> l) {
      allLiquids.addAll(l);
    });
    allLiquids.forEach((Liquid liquid) {
      if (liquid.quantity > 0) {
        liquidsNotEmpty.add(liquid);
      }
      if (liquid.quantity == 0) {
        liquidsEmpty.add(liquid);
      }
    });
    return Drawer(
      child: ListView(
        children: <Widget>[
          _buildHeader(context),
          _buildButtonHome(context),
          _buildButtonToBuy(context),
          _buildButtonAllLiquids(context),
          _buildButtonTemp(context)
        ],
      ),
    );
  }

  DrawerHeader _buildHeader(BuildContext context) {
    return DrawerHeader(
      child: Container(
        child: Text(
          'Ben\'n\'Liq App',
          style: Theme.of(context).appBarTheme.textTheme.title,
        ),
        alignment: Alignment(0.0, 0.0),
      ),
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
    );
  }

  ListTile _buildButtonTemp(BuildContext context) {
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

  ListTile _buildButtonHome(BuildContext context) {
    return ListTile(
//      title: Text(
//        'Liste complete',
//        style: Theme.of(context).textTheme.overline,
//      ),
      leading: Icon(Icons.home),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ListLiquidsPage(
                  liquidsNotEmpty, liquidService, "Liquid's Ben")),
        );
//        ListLiquidsPage(_liquids, liquidService, "Liquid's Ben");
//        Navigator.of(context).pop();
      },
    );
  }

  ListTile _buildButtonAllLiquids(BuildContext context) {
    return ListTile(
      title: Text(
        'Liste complete',
        style: Theme.of(context).textTheme.overline,
      ),
      leading: Icon(Icons.all_inclusive),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  ListLiquidsPage(allLiquids, liquidService, "Liquid's Ben")),
        );
      },
    );
  }

  ListTile _buildButtonToBuy(BuildContext context) {
    return ListTile(
      title: Text('A acheter', style: Theme.of(context).textTheme.overline),
      leading: Icon(Icons.exposure_zero),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) =>
                  ListLiquidsPage(liquidsEmpty, liquidService, "Liquid's Ben")),
        );
      },
    );
  }
}
