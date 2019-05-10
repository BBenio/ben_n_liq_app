import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:ben_n_liq_app/list_liquid_page.dart';
import 'package:ben_n_liq_app/parser.dart';
import 'package:flutter/material.dart';

enum DrawerActions {
  AllLiquids,
  LiquidsEmpty,
  LiquidsNotEmpty,
}

class DrawerLiquids extends StatelessWidget {
  final LiquidService liquidService;

  DrawerLiquids(this.liquidService);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          _buildHeader(context),
          _buildButtonHome(context),
          _buildButtonToBuy(context),
          _buildButtonAllLiquids(context),
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

  ListTile _buildButtonHome(BuildContext context) {
    return ListTile(
      title: Text(
        'All You Want',
        style: Theme.of(context).textTheme.overline,
      ),
      leading: Icon(Icons.home),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ListLiquidsPage(
              liquidService, DrawerActions.LiquidsNotEmpty, "Liquid's Ben"),
        ));
      },
    );
  }

  ListTile _buildButtonAllLiquids(BuildContext context) {
    return ListTile(
      title: Text(
        'Useless but Cool',
        style: Theme.of(context).textTheme.overline,
      ),
      leading: Icon(Icons.all_inclusive),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ListLiquidsPage(
                  liquidService, DrawerActions.AllLiquids, "All Liquids")),
        );
      },
    );
  }

  ListTile _buildButtonToBuy(BuildContext context) {
    return ListTile(
      title: Text('Oh no !', style: Theme.of(context).textTheme.overline),
      leading: Icon(Icons.thumb_down),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ListLiquidsPage(
                  liquidService, DrawerActions.LiquidsEmpty, "To buy, Bro")),
        );
      },
    );
  }

  ListTile _buildButtonTemp(BuildContext context) {
    return ListTile(
      title: Text("temp"),
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => FlutterDemo(storage: CounterStorage())),
        );
      },
    );
  }
}
