import 'package:ben_n_liq_app/liquid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

import 'liquid_form.dart';

class LiquidPage extends StatefulWidget {
  final Liquid _liquid;
  final VoidCallback saveLiquids;

  LiquidPage(this._liquid, Key key, {this.saveLiquids}) : super(key: key);

  @override
  _LiquidPageState createState() => _LiquidPageState();
}

class _LiquidPageState extends State<LiquidPage> {
  String quantity;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _buttonAddPressed = false;
  bool _buttonDecreasePressed = false;
  bool _loopAddActive = false;
  bool _loopDecreaseActive = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      quantity = widget._liquid.remainingQuantity.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('${widget._liquid.name}',
            style: Theme.of(context).appBarTheme.textTheme.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _showDialogAddLiquid(context);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[_buildName(), _buildBrand(), _buildPrice()],
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      _buildButtons(),
                      _buildStars(),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildName() {
    return Center(
      child: Text(
        widget._liquid.name,
        style: Theme.of(context).primaryTextTheme.title,
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  _showDialogAddLiquid(BuildContext context) async {
    Liquid liquid = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LiquidForm(widget._liquid)),
    );

    if (liquid != null) {
      widget._liquid.name = liquid.name;
      widget._liquid.price = liquid.price;
      widget._liquid.bottle = liquid.bottle;
      widget._liquid.remainingQuantity = liquid.remainingQuantity;
      widget._liquid.brand = liquid.brand;
      widget.saveLiquids();
      setState(() {
        quantity = widget._liquid.remainingQuantity.toString();
      });
    }
  }

  Widget _buildBrand() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget._liquid.brand,
          style: Theme.of(context).primaryTextTheme.overline,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return Center(
      child: Text(
        widget._liquid.price.toString() + "€",
        style: Theme.of(context).primaryTextTheme.overline,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildQuantity() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Center(
        child: Text(
          quantity,
          style: Theme.of(context).primaryTextTheme.overline,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButtonMinus(),
        _buildQuantity(),
        _buildButtonAdd(),
      ],
    );
  }

  Widget _buildButtonAdd() {
    return Container(
        margin: EdgeInsets.all(10),
        child: Listener(
          onPointerDown: (details) {
            print("appuyer");
            _buttonAddPressed = true;
            _onAddQuantityWhilePressed();
          },
          onPointerUp: (details) {
            print("relacher");
            _buttonAddPressed = false;
          },
          child: FloatingActionButton(
            heroTag: 0,
            child: Icon(Icons.plus_one),
            backgroundColor: Theme.of(context).buttonColor,
            onPressed: null,
          ),
        ));
  }

  void _onAddQuantityWhilePressed() async {
    if (_loopAddActive) return;

    _loopAddActive = true;

    while (_buttonAddPressed) {
      widget._liquid.addOneQuantity();
      setState(() {
        quantity = widget._liquid.remainingQuantity.toString();
      });

      await Future.delayed(Duration(milliseconds: 200));
    }
    widget.saveLiquids();

    _loopAddActive = false;
  }

  Widget _buildButtonMinus() {
    return Container(
        margin: EdgeInsets.all(10),
        child: Listener(
          onPointerDown: (details) {
            print("appuyer");
            _buttonDecreasePressed = true;
            _onDecreaseQuantityWhilePressed();
          },
          onPointerUp: (details) {
            print("relacher");
            _buttonDecreasePressed = false;
          },
          child: FloatingActionButton(
            heroTag: 1,
            child: Icon(Icons.exposure_neg_1),
            onPressed: null,
            backgroundColor: Colors.grey,
          ),
        ));
  }

  void _onDecreaseQuantityWhilePressed() async {
    if (_loopDecreaseActive) return;

    _loopDecreaseActive = true;

    while (_buttonDecreasePressed) {
      widget._liquid.removeOneQuantity();
      setState(() {
        quantity = widget._liquid.remainingQuantity.toString();
      });

      await Future.delayed(Duration(milliseconds: 200));
    }
    widget.saveLiquids();

    _loopDecreaseActive = false;
  }

  Widget _buildStars() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          StarRating(
            size: 25.0,
            rating: widget._liquid.rating,
            color: Colors.orange,
            borderColor: Colors.grey,
            starCount: 5,
            onRatingChanged: (rating) {
              setState(
                () {
                  widget._liquid.rating = rating;
                },
              );
              widget.saveLiquids();
            },
          ),
        ],
      ),
    );
  }
}
