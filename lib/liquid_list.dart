import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_page.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LiquidList extends StatefulWidget {
  final List<Liquid> _liquids;
  final LiquidService _liquidService;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  LiquidList(this._liquids, this._liquidService, this._scaffoldKey);

  @override
  _LiquidListState createState() => _LiquidListState();
}

class _LiquidListState extends State<LiquidList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._liquids.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          closeOnScroll: true,
          key: Key(widget._liquids[index].name + widget._liquids[index].brand),
          child: buildLiquidTile(index, context),
          delegate: SlidableDrawerDelegate(),
          actionExtentRatio: 0.25,
          secondaryActions: <Widget>[
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

  ListTile buildLiquidTile(int index, BuildContext context) {
    return ListTile(
      key: Key(widget._liquids[index].name),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LiquidPage(
                widget._liquids[index],
                Key(widget._liquids[index].name),
                saveLiquids: () {
                  _saveLiquids();
                },
              ),
        ));
      },
      title: buildTitle(index, context),
      subtitle: buildSubtitle(index, context),
    );
  }

  Text buildTitle(int index, BuildContext context) {
    return Text(
      widget._liquids[index].name,
      style: Theme.of(context).textTheme.subhead,
    );
  }

  Text buildSubtitle(int index, BuildContext context) {
    return Text(
      widget._liquids[index].quantity.toString(),
      style: Theme.of(context).textTheme.subtitle,
    );
  }

  _deleteLiquid(int index) {
    setState(() {
      widget._liquids.removeAt(index);
    });
    widget._liquidService
        .saveLiquids(widget._liquids)
        .then((f) => widget._scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text('Supprimé !'),
              duration: Duration(seconds: 1),
            )));
  }

  _saveLiquids() {
    widget._liquidService
        .saveLiquids(widget._liquids)
        .then((f) => print("enregistré"));
  }
}
