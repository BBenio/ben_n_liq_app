import 'package:ben_n_liq_app/liquid.dart';
import 'package:flutter/material.dart';

class LiquidForm extends StatefulWidget {
  @override
  _LiquidFormState createState() => _LiquidFormState();
}

class _LiquidFormState extends State<LiquidForm> {
  TextEditingController _controllerName;
  TextEditingController _controllerBrand;
  TextEditingController _controllerQuantity;
  bool nameValidator = false;
  bool quantityValidator = false;

  @override
  initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerBrand = TextEditingController();
    _controllerQuantity = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      resizeToAvoidBottomPadding: false,
      body: _buildBody(),
    );
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            _buildNameField(),
            _buildBrandField(),
            _buildQuantityField(),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Container _buildButton() {
    return Container(
      margin: EdgeInsets.all(10),
      child: RaisedButton(
        child: Text(
          "Créer un produit",
          style: Theme.of(context).textTheme.button,
        ),
        padding: EdgeInsets.all(10),
        color: Theme.of(context).buttonColor,
        disabledColor: Colors.black,
        onPressed: () {
          if (nameValidator && quantityValidator) {
            int quantity = int.tryParse(_controllerQuantity.text);

            Liquid liquid =
                Liquid(_controllerName.text, _controllerBrand.text, quantity);

            setState(() {
              _controllerName.clear();
              _controllerBrand.clear();
              _controllerQuantity.clear();
            });
            Navigator.pop(context, liquid);
          }
        },
      ),
    );
  }

  TextFormField _buildQuantityField() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(hintText: "Quantité :"),
      controller: _controllerQuantity,
      autovalidate: true,
      validator: (String txt) {
        if (int.tryParse(txt) != null) {
          quantityValidator = true;
          return null;
        }
        return "Il faut un nombre";
      },
    );
  }

  TextFormField _buildBrandField() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(hintText: "Marque :"),
      controller: _controllerBrand,
      autovalidate: true,
      validator: (String txt) {
        if (txt.isNotEmpty) {
          return null;
        }
        return "Par défaut, A&L";
      },
    );
  }

  TextFormField _buildNameField() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(hintText: "Nom :"),
      controller: _controllerName,
      autovalidate: true,
      validator: (String txt) {
        if (txt.isNotEmpty) {
          nameValidator = true;
          return null;
        }
        return "Il faut un nom.";
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Ajouter un produit"),
    );
  }
}
