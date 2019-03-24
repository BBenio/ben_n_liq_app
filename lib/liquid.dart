class Liquid {
  String _name;
  String _brand;
  int _remainingQuantity;
  String _pathImage;

  Liquid(this._name, this._brand,
      [this._remainingQuantity = 3, this._pathImage]);

  factory Liquid.fromJson(Map<String, dynamic> parsedJson) {
    return Liquid(
      parsedJson['name'],
      parsedJson['brand'],
      parsedJson['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': _name,
        'brand': _brand,
        'quantity': quantity,
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

  String get brand => this._brand;

  String get pathImage => this._pathImage;

  int get quantity => this._remainingQuantity;
}
