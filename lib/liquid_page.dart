import 'package:ben_n_liq_app/liquid.dart';
import 'package:flutter/material.dart';

class LiquidPage extends StatefulWidget {
  final Liquid _liquid;
  final VoidCallback saveLiquids;

  LiquidPage(this._liquid, Key key, {this.saveLiquids}) : super(key: key);

  @override
  _LiquidPageState createState() => _LiquidPageState();
}

class _LiquidPageState extends State<LiquidPage> {
  String quan;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      quan = widget._liquid.quantity.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('${widget._liquid.name}',
              style: Theme.of(context).appBarTheme.textTheme.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_buildName(), _buildBrand(), _buildQuantity(), _buildButtons()],
          ),
        ));
  }

  Widget _buildName() {
    return Center(
      child: Text(
        widget._liquid.name,
        style: Theme.of(context).primaryTextTheme.title,
      ),
    );
  }

  Widget _buildBrand() {
    return Center(
      child: Text(
        widget._liquid.brand,
        style: Theme.of(context).primaryTextTheme.overline,
      ),
    );
  }

  Widget _buildQuantity() {
    return Center(
      child: Text(
        quan,
        style: Theme.of(context).primaryTextTheme.subtitle,
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButtonMinus(),
        _buildButtonAdd(),
      ],
    );
  }

  Widget _buildButtonAdd() {
    return Container(
      margin: EdgeInsets.all(10),
      child: FloatingActionButton(
        heroTag: 0,
        child: Icon(Icons.plus_one),
        onPressed: _onAddQuantity,
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }

  void _onAddQuantity() {
    widget._liquid.addOneQuantity();
    widget.saveLiquids();
    setState(() {
      quan = widget._liquid.quantity.toString();
    });
  }

  Widget _buildButtonMinus() {
    return Container(
      margin: EdgeInsets.all(10),
      child: FloatingActionButton(
        heroTag: 1,
        child: Icon(Icons.exposure_neg_1),
        onPressed: _onMinusQuantity,
        backgroundColor: Colors.grey,
      ),
    );
  }

  void _onMinusQuantity() {
    widget._liquid.removeOneQuantity();
    widget.saveLiquids();
    setState(() {
      quan = widget._liquid.quantity.toString();
    });
  }
}
