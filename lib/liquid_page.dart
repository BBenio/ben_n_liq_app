import 'package:ben_n_liq_app/liquid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';

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
  bool _buttonPressed = false;
  bool _buttonAddPressed = false;
  bool _buttonDecreasePressed = false;
  bool _loopActive = false;
  bool _loopAddActive = false;
  bool _loopDecreaseActive = false;
  int _counter = 0;

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

  Widget testbutton() {
    return Listener(
      onPointerDown: (details) {
        print("appuyer");
        _buttonPressed = true;
        _increaseCounterWhilePressed();
      },
      onPointerUp: (details) {
        print("relacher");
        _buttonPressed = false;
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.orange, border: Border.all()),
        padding: EdgeInsets.all(16.0),
        child: Text('Value: $_counter'),
      ),
    );
  }

  void _increaseCounterWhilePressed() async {
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      setState(() {
        _counter++;
      });

      await Future.delayed(Duration(milliseconds: 200));
    }

    _loopActive = false;
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

  _onAddQuantity() {
    widget._liquid.addOneQuantity();
    widget.saveLiquids();
    setState(() {
      quantity = widget._liquid.remainingQuantity.toString();
    });
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
