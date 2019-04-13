class Liquid {
  String _name;
  String _brand;
  int _remainingQuantity;
  double _note;

  Liquid(this._name, this._brand,
      [this._remainingQuantity = 3, this._note = 0]);

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
        'note': _note,
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
  double get note => this._note;
  set note(double newNote) => this._note = newNote;
  String get brand => this._brand;
  int get quantity => this._remainingQuantity;
}
