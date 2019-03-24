import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_page.dart';
import 'package:flutter/material.dart';

class LiquidList extends StatefulWidget {
  final List<Liquid> _liquids;

  LiquidList(this._liquids);

  @override
  _LiquidListState createState() => _LiquidListState();
}

class _LiquidListState extends State<LiquidList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._liquids.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          key: Key(widget._liquids[index].name),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => LiquidPage(widget._liquids[index],
                      Key(widget._liquids[index].name))),
            );
          },
          title: buildTitle(index, context),
          subtitle: buildSubtitle(index, context),
        );
      },
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
}
