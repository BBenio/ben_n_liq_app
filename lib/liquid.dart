class Liquid {
  String _name;
  String _brand;
  int _remainingQuantity;
  double _rate, _price;

  Liquid(this._name, this._brand,
      [this._remainingQuantity = 3, this._rate = 0, this._price = 0]);

  factory Liquid.fromJson(Map<String, dynamic> parsedJson) {
    double rate, price = 0;
    if (parsedJson['rate'] != null) {
      rate = parsedJson['rate'];
    }
    if (parsedJson['price'] != null) {
      price = parsedJson['price'];
    }
    return Liquid(
      parsedJson['name'],
      parsedJson['brand'],
      parsedJson['quantity'],
      rate,
      price
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': _name,
        'brand': _brand,
        'quantity': quantity,
        'rate': _rate,
        'price': _price
      };

  void addOneQuantity() => this._remainingQuantity++;

  void addQuantity(int quantity) => this._remainingQuantity += quantity;

  bool removeOneQuantity() {
    if (this._remainingQuantity > 0) {
      this._remainingQuantity--;
      return true;
    }
    return false;
  }

  String toString() {
    return "$name, $_rate/5★";
  }

  String get name => this._name;

  double get rating => this._rate;

  set rating(double newRate) {
    if (newRate >= 0 && newRate <= 5) this._rate = newRate;
  }

  double get price => this._price;

  set price(double newRate) {
    if (newRate >= 0) this._rate = newRate;
  }

  String get brand => this._brand;

  int get quantity => this._remainingQuantity;
}
