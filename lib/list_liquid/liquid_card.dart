import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../liquid.dart';
import '../liquid_page.dart';

class LiquidCard extends StatefulWidget {
  final Liquid _liquid;
  final VoidCallback _saveLiquids;

  LiquidCard(this._liquid, this._saveLiquids);

  @override
  _LiquidCardState createState() => _LiquidCardState();
}

class _LiquidCardState extends State<LiquidCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(widget._liquid.name),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LiquidPage(
            widget._liquid,
            Key(widget._liquid.name),
            saveLiquids: () {
              widget._saveLiquids();
            },
          ),
        ));
      },
      title: _buildTitle(widget._liquid, context),
      subtitle: _buildSubtitle(widget._liquid, context),
      trailing: _buildRate(widget._liquid, context),
    );
  }


  Text _buildTitle(Liquid liquid, BuildContext context) {
    return Text(liquid.name,
        style: Theme.of(context).textTheme.subhead,
        maxLines: 1,
        overflow: TextOverflow.ellipsis);
  }

  Text _buildSubtitle(Liquid liquid, BuildContext context) {
    return Text(
      liquid.remainingQuantity.toString(),
      style: Theme.of(context).textTheme.subtitle,
    );
  }

  Widget _buildRate(Liquid liquid, BuildContext context) {
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
}