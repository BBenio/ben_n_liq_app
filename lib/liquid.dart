class Liquid {
  String _name, _brand;
  int _remainingQuantity, _bottle, _quantityPerBottle;
  double _rate, _price;

  Liquid(this._name, this._brand,
      [this._remainingQuantity = 3,
      this._rate = 0,
      this._price = 0,
      this._bottle = 0,
      this._quantityPerBottle]);

  factory Liquid.fromJson(Map<String, dynamic> parsedJson) {
    double _rateParsed, _priseParsed = 0;
    int _bottleParsed, _quantityPerBottleParsed, _quantityParsed = 0;

    if (parsedJson['rate'] != null) {
      _rateParsed = parsedJson['rate'].toDouble();
    }

    if (parsedJson['price'] != null) {
      _priseParsed = parsedJson['price'].toDouble();
    }

    if (parsedJson['bottle'] != null) {
      _bottleParsed = parsedJson['bottle'];
    }

    if (parsedJson['quantity_bottle'] != null) {
      _quantityPerBottleParsed = parsedJson['quantity_bottle'];
    }

    if (parsedJson['quantity'] != null) {
      _quantityParsed = parsedJson['quantity'];
    } else if (parsedJson['remaining_quantity'] != null) {
      _quantityParsed = parsedJson['remaining_quantity'];
    }

    return Liquid(parsedJson['name'], parsedJson['brand'], _quantityParsed,
        _rateParsed, _priseParsed, _bottleParsed, _quantityPerBottleParsed);
  }

  Map<String, dynamic> toJson() => {
        'name': _name,
        'brand': _brand,
        'remaining_quantity': _remainingQuantity,
        'rate': _rate,
        'price': _price,
        'bottle': _bottle,
        'quantity_bottle': _quantityPerBottle
      };

  void addOneQuantity() => this._remainingQuantity++;

  void addQuantity(int quantity) => this._remainingQuantity += quantity;

  removeOneQuantity() {
    if (this._remainingQuantity > 0) {
      this._remainingQuantity--;

      if (this._remainingQuantity == 0) {
        removeOneBottle();
      }
    }
  }

  removeOneBottle() {
    if (this._bottle > 0) {
      this._bottle--;
    }
  }

  String toString() {
    return "$name, $_rate/5★";
  }

  String get name => this._name;

  set name(String newName) => this._name = newName;

  double get rating => this._rate;

  set rating(double newRate) {
    if (newRate >= 0 && newRate <= 5) this._rate = newRate;
  }

  double get price => this._price;

  set price(double newPrice) {
    if (newPrice >= 0) this._price = newPrice;
  }

  int get bottle => this._bottle;

  set bottle(int newNumber) {
    if (newNumber >= 0) this._bottle = newNumber;
  }

  String get brand => this._brand;

  set brand(String newBrand) => this._brand = newBrand;

  int get remainingQuantity => this._remainingQuantity;

  int get quantityPerBottle => this._quantityPerBottle;

  set quantityPerBottle(int newNumber) {
    if (newNumber >= 0) this._quantityPerBottle = newNumber;
  }
}
