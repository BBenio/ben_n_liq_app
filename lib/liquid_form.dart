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
  TextEditingController _controllerPrice;
  bool nameValidator = false;
  bool quantityValidator = false;
  bool priceValidator = false;
  FocusNode _nameFocus = FocusNode();
  FocusNode _quantityFocus = FocusNode();
  FocusNode _brandFocus = FocusNode();
  FocusNode _priceFocus = FocusNode();

  @override
  initState() {
    super.initState();
    _controllerName = TextEditingController();
    _controllerBrand = TextEditingController();
    _controllerQuantity = TextEditingController();
    _controllerPrice = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
    );
  }

  SingleChildScrollView _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
      reverse: true,
      child: Column(
        children: <Widget>[
          _buildNameField(),
          _buildBrandField(),
          _buildQuantityField(),
          _buildPriceField(),
          _buildButton(),
        ],
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
          if (nameValidator && quantityValidator && priceValidator) {
            int quantity = int.tryParse(_controllerQuantity.text);
            double priceParse = double.tryParse(_controllerPrice.text);
            double goodPrice = priceParse != null ? priceParse :  double.tryParse(_controllerPrice.text.replaceAll(',', '.'));
            if (_controllerBrand.text == "")
              _controllerBrand.text = "A&L";

            Liquid liquid =
                Liquid(_controllerName.text, _controllerBrand.text, quantity, 0, goodPrice);

            setState(() {
              _controllerName.clear();
              _controllerBrand.clear();
              _controllerQuantity.clear();
              _controllerPrice.clear();
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
      focusNode: _quantityFocus,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _quantityFocus, _priceFocus);
      },
      keyboardType: TextInputType.number,
      validator: (String txt) {
        if (int.tryParse(txt) != null) {
          quantityValidator = true;
          return null;
        }
        return "Il faut un nombre";
      },
    );
  }

  TextFormField _buildPriceField() {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(hintText: "Prix d'un flacon :"),
      controller: _controllerPrice,
      autovalidate: true,
      focusNode: _priceFocus,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (term){
        _priceFocus.unfocus();
      },
      keyboardType: TextInputType.number,
      validator: (String txt) {
        if (double.tryParse(txt) != null || double.tryParse(txt.replaceAll(',', '.')) != null) {
          priceValidator = true;
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
      focusNode: _brandFocus,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _brandFocus, _quantityFocus);
      },
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
      focusNode: _nameFocus,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term){
        _fieldFocusChange(context, _nameFocus, _brandFocus);
      },
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
      title: Text("Ajouter un produit",
          style: Theme.of(context).appBarTheme.textTheme.title),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
}
