import 'package:ben_n_liq_app/drawer.dart';
import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_form.dart';
import 'package:ben_n_liq_app/liquid_page.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListLiquidsPage extends StatefulWidget {
  final LiquidService _liquidService;
  final DrawerActions _actions;
  final textAppBar;

  ListLiquidsPage(this._liquidService, this._actions, this.textAppBar);

  @override
  _ListLiquidsPageState createState() => _ListLiquidsPageState();
}

class _ListLiquidsPageState extends State<ListLiquidsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Liquid> _liquidsToShow = [];
  final List<Liquid> _allLiquids = [];

  @override
  void initState() {
    super.initState();
    _buildList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: DrawerLiquids(widget._liquidService),
      floatingActionButton: _buildFloatingActionButton(context),
      body: _buildBody(),
    );
  }

  _buildList() {
    widget._liquidService.loadLiquidsDirectory().then((List<Liquid> l) {
      setState(() {
        _allLiquids.addAll(l);
        if (widget._actions == DrawerActions.AllLiquids) {
          _liquidsToShow.addAll(_allLiquids);
        }
        if (widget._actions == DrawerActions.LiquidsEmpty) {
          _allLiquids.forEach((Liquid liquid) {
            if (liquid.quantity == 0) {
              _liquidsToShow.add(liquid);
            }
          });
        }
        if (widget._actions == DrawerActions.LiquidsNotEmpty) {
          _allLiquids.forEach((Liquid liquid) {
            if (liquid.quantity > 0) {
              _liquidsToShow.add(liquid);
            }
          });
        }
      });
    });
  }

  _showDialogAddLiquid(BuildContext context) async {
    Liquid liquid = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LiquidForm()),
    );

    if (liquid != null) {
      setState(() {
        _allLiquids.add(liquid);
        if (widget._actions == DrawerActions.AllLiquids ||
            (widget._actions == DrawerActions.LiquidsNotEmpty &&
                liquid.quantity > 0) ||
            (widget._actions == DrawerActions.LiquidsEmpty &&
                liquid.quantity == 0)) {
          _liquidsToShow.add(liquid);
        }
      });
      widget._liquidService
          .saveLiquids(_allLiquids)
          .then((f) => _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Enregistrés !'),
                duration: Duration(seconds: 1),
              )));
    }
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        _showDialogAddLiquid(context);
      },
      backgroundColor: Theme.of(context).buttonColor,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.textAppBar,
        style: Theme.of(context).appBarTheme.textTheme.title,
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: _liquidsToShow.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          closeOnScroll: true,
          key: Key(_liquidsToShow[index].name + _liquidsToShow[index].brand),
          child: _buildLiquidTile(index, context),
          delegate: SlidableDrawerDelegate(),
          actionExtentRatio: 0.25,
          actions: <Widget>[
            IconSlideAction(
              icon: Icons.delete_forever,
              onTap: () => _deleteLiquid(index),
              color: Colors.redAccent,
              closeOnTap: true,
            ),
          ],
        );
      },
    );
  }

  ListTile _buildLiquidTile(int index, BuildContext context) {
    return ListTile(
      key: Key(_liquidsToShow[index].name),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LiquidPage(
                _liquidsToShow[index],
                Key(_liquidsToShow[index].name),
                saveLiquids: () {
                  _saveLiquids();
                },
              ),
        ));
      },
      title: _buildTitle(index, context),
      subtitle: _buildSubtitle(index, context),
      trailing: _buildRate(index, context),
    );
  }

  Text _buildTitle(int index, BuildContext context) {
    return Text(
      _liquidsToShow[index].name,
      style: Theme.of(context).textTheme.subhead,
    );
  }

  Text _buildSubtitle(int index, BuildContext context) {
    return Text(
      _liquidsToShow[index].quantity.toString(),
      style: Theme.of(context).textTheme.subtitle,
    );
  }

  Text _buildRate(int index, BuildContext context) {
    return Text(
      _liquidsToShow[index].rating.toString(),
      style: Theme.of(context).textTheme.subtitle,
    );
  }

  _deleteLiquid(int index) {
    setState(() {
      _allLiquids.remove(_liquidsToShow.elementAt(index));
      _liquidsToShow.removeAt(index);
    });
    widget._liquidService
        .saveLiquids(_allLiquids)
        .then((f) => _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Supprimé !'),
              duration: Duration(seconds: 1),
            )));
  }

  _saveLiquids() {
    widget._liquidService
        .saveLiquids(_allLiquids)
        .then((f) => print("enregistré"));
  }
}
