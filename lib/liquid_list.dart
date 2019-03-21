import 'package:ben_n_liq_app/liquid.dart';
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(widget._liquids[index].name, style: Theme.of(context).textTheme.body1,),
            Text(widget._liquids[index].remainingQuantity.toString(), style: Theme.of(context).textTheme.body2,)
          ],
        );
      },
    );
  }
}
