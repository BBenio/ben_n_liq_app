import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_form.dart';
import 'package:ben_n_liq_app/liquid_list.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:ben_n_liq_app/main.dart';
import 'package:flutter/material.dart';

class ListLiquidsPage extends StatefulWidget {
  final List<Liquid> _liquids;
  final LiquidService liquidService;
  final textAppBar;

  ListLiquidsPage(this._liquids, this.liquidService, this.textAppBar);

  @override
  _ListLiquidsPageState createState() => _ListLiquidsPageState();
}

class _ListLiquidsPageState extends State<ListLiquidsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      drawer: DrawerLiquids(widget.liquidService),
      floatingActionButton: buildFloatingActionButton(context),
      body: LiquidList(widget._liquids, widget.liquidService, _scaffoldKey),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.textAppBar,
        style: Theme.of(context).appBarTheme.textTheme.title,
      ),
    );
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

  _showDialogAddLiquid(BuildContext context) async {
    Liquid liquid = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LiquidForm()),
    );

    if (liquid != null) {
      setState(() {
        widget._liquids.add(liquid);
      });
      widget.liquidService
          .saveLiquids(widget._liquids)
          .then((f) => _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Enregistrés !'),
        duration: Duration(seconds: 1),
      )));
    }
  }
}
