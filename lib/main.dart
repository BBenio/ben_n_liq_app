import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_list.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:ben_n_liq_app/parser.dart';
import 'package:flutter/material.dart';

Future main() async {
  LiquidService liquidService = LiquidService();

  List<Liquid> liquids = List<Liquid>();

//  liquids = await liquidService.loadLiquidsAssets();
//
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
          )),
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
      appBar: AppBar(
        title: Text(
          'Liquid\'s Ben',
          style: Theme.of(context).textTheme.title,
        ),
      ),
      drawer: buildDrawer(context),
      body: _liquids.length > 0
          ? LiquidList(_liquids)
          : Center(
              child: CircularProgressIndicator(),
            ),
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
        style: Theme.of(context).textTheme.button,
      ),
      leading: Icon(Icons.all_inclusive),
    );
  }

  ListTile buildButtonToBuy(BuildContext context) {
    return ListTile(
      title: Text('A acheter', style: Theme.of(context).textTheme.button),
      leading: Icon(Icons.exposure_zero),
    );
  }

  List<Liquid> buildLiquidsTemp() {
    List<Liquid> liquids = List<Liquid>();
    liquids.add(Liquid("one", "j"));
    liquids.add(Liquid("two", "a"));
    liquids.add(Liquid("three", "r"));
    liquids.add(Liquid("for", "t"));
    liquids.add(Liquid("five", "j"));
    liquids.add(Liquid("six", "k"));
    liquids.add(Liquid("seven", "l"));

    return liquids;
  }
}
