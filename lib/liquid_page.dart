import 'package:ben_n_liq_app/liquid.dart';
import 'package:flutter/material.dart';

class LiquidPage extends StatefulWidget {
  final Liquid _liquid;

  LiquidPage(this._liquid, Key key) : super(key: key);

  @override
  _LiquidPageState createState() => _LiquidPageState();
}

class _LiquidPageState extends State<LiquidPage> {
  Widget buildName() {
    return Text(
      widget._liquid.name,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.indigo),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildName(),
        ],
      ),
    );
  }
}
