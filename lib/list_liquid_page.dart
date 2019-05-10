import 'package:ben_n_liq_app/drawer.dart';
import 'package:ben_n_liq_app/liquid.dart';
import 'package:ben_n_liq_app/liquid_form.dart';
import 'package:ben_n_liq_app/liquid_page.dart';
import 'package:ben_n_liq_app/liquid_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:clipboard_plugin/clipboard_plugin.dart';

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
  bool show = true;
  final List<Liquid> _liquidsToShow = [];
  final List<Liquid> _allLiquids = [];
  ScrollController _scrollController = ScrollController();
  Icon iconSearching = Icon(Icons.search);
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching = false;
  List<Liquid> _searchResults = new List<Liquid>();
  Widget appBarTitle;

  @override
  void initState() {
    new Future.delayed(Duration.zero, () {
      appBarTitle = Text(
        widget.textAppBar,
        style: Theme.of(context).appBarTheme.textTheme.title,
      );
    });
    _scrollController.addListener(listener);
    super.initState();
    _buildList();
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      drawer: DrawerLiquids(widget._liquidService),
      floatingActionButton:
          show ? _buildFloatingActionButton(context) : Container(),
      body: _buildBody(),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      if (_controller.text.isEmpty) {
        _searchResults.clear();
        this.iconSearching = new Icon(
          Icons.search,
          color: Colors.white,
        );
        this.appBarTitle = Text(
          widget.textAppBar,
          style: Theme.of(context).appBarTheme.textTheme.title,
        );
        _isSearching = false;
        _controller.clear();
      } else {
        _searchResults.clear();
        _controller.clear();
      }
    });
  }

  void _onSearchingOperation(String searchText) {
    _searchResults.clear();
    if (_isSearching != null) {
      for (int i = 0; i < _liquidsToShow.length; i++) {
        String data = _liquidsToShow[i].name;
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          _searchResults.add(_liquidsToShow[i]);
        }
      }
    }
  }

  Widget _buildSearchButton() {
    return IconButton(
      icon: iconSearching,
      onPressed: () {
        setState(() {
          if (iconSearching.icon == Icons.search) {
            iconSearching = Icon(
              Icons.close,
              color: Colors.white,
            );
            this.appBarTitle = TextField(
              controller: _controller,
              style: Theme.of(context).textTheme.button,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.white)),
              onChanged: _onSearchingOperation,
              autofocus: true,
            );
            _handleSearchStart();
          } else {
            _handleSearchEnd();
          }
        });
      },
    );
  }

  Widget _buildCopyButton() {
    return IconButton(
      icon: Icon(Icons.content_copy),
      onPressed: _handleCopy,
    );
  }

  _handleCopy() {
    _liquidsToString(_liquidsToShow).then((String stringResult) {
      ClipboardPlugin.copyToClipBoard(stringResult).then((result) {
        final snackBar = SnackBar(
          content: Text('Copié'),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {},
          ),
        );
        _scaffoldKey.currentState..showSnackBar(snackBar);
//        Scaffold.of(context).showSnackBar(snackBar);
      });
    });
  }

  Future<String> _liquidsToString(List<Liquid> liquids) async {
    String liquidsString = "";
    liquids.forEach((liquid) {
      liquidsString += "${liquid.toString()}\n";
    });
    return liquidsString;
  }

  _buildList() {
    widget._liquidService.loadLiquidsDirectory().then((List<Liquid> l) {
      setState(() {
        _allLiquids.addAll(l);
        _allLiquids.sort((Liquid a, Liquid b) =>
            a.name.toLowerCase().compareTo(b.name.toLowerCase()));
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
      title: appBarTitle,
      actions: <Widget>[_buildCopyButton(), _buildSearchButton()],
    );
  }

  Widget _buildBody() {
    if (_isSearching &&
        (_searchResults.length != 0 || _controller.text.isNotEmpty)) {
      return ListView.builder(
        controller: _scrollController,
        itemCount: _searchResults.length,
        itemBuilder: (BuildContext context, int index) {
          return Slidable(
            closeOnScroll: true,
            key: Key(_searchResults[index].name + _searchResults[index].brand),
            child: _buildLiquidTile(_searchResults, index, context),
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

    return ListView.builder(
      controller: _scrollController,
      itemCount: _liquidsToShow.length,
      itemBuilder: (BuildContext context, int index) {
        return Slidable(
          closeOnScroll: true,
          key: Key(_liquidsToShow[index].name + _liquidsToShow[index].brand),
          child: _buildLiquidTile(_liquidsToShow, index, context),
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

  ListTile _buildLiquidTile(
      List<Liquid> liquids, int index, BuildContext context) {
    return ListTile(
      key: Key(liquids[index].name),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LiquidPage(
                liquids[index],
                Key(liquids[index].name),
                saveLiquids: () {
                  _saveLiquids();
                },
              ),
        ));
      },
      title: _buildTitle(liquids[index], index, context),
      subtitle: _buildSubtitle(liquids[index], index, context),
      trailing: _buildRate(liquids[index], index, context),
    );
  }

  Text _buildTitle(Liquid liquid, int index, BuildContext context) {
    return Text(
      liquid.name,
      style: Theme.of(context).textTheme.subhead,
    );
  }

  Text _buildSubtitle(Liquid liquid, int index, BuildContext context) {
    return Text(
      liquid.quantity.toString(),
      style: Theme.of(context).textTheme.subtitle,
    );
  }

  Widget _buildRate(Liquid liquid, int index, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          liquid.rating.toString(),
          style: Theme.of(context).textTheme.subtitle,
        ),
        Icon(
          Icons.star,
          color: Colors.orange,
          size: 15.0,
        )
      ],
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

  void listener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward)
      show = true;
    else
      show = false;

    setState(() {});
  }
}
