class Liquid {
  String _name;
  String _brand;
  int _remainingQuantity;
  double _rate;

  Liquid(this._name, this._brand,
      [this._remainingQuantity = 3, this._rate = 0]);

  factory Liquid.fromJson(Map<String, dynamic> parsedJson) {
    double rate = 0;
    print("ntmp 1");
    print(parsedJson['rate']);
    if (parsedJson['rate'] != null) {
      print("et la tu passes fdp");
      rate = parsedJson['rate'];
    }
    print("ntmp4");
    return Liquid(
      parsedJson['name'],
      parsedJson['brand'],
      parsedJson['quantity'],
      rate
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': _name,
        'brand': _brand,
        'quantity': quantity,
        'rate': _rate,
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

  bool removeQuantity(int quantity) {
    if (this._remainingQuantity - quantity >= 0) {
      this._remainingQuantity -= quantity;
      return true;
    }
    return false;
  }

  String get name => this._name;

  double get rating => this._rate;

  set rating(double newRate) {
    if (newRate >= 0 && newRate <= 5) this._rate = newRate;
  }

  String get brand => this._brand;

  int get quantity => this._remainingQuantity;
}
