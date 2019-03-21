class Liquid {
  final String _name;
  int _remainingQuantity;
  String _pathImage;

  Liquid(this._name, [this._remainingQuantity = 3, this._pathImage]);

  String get name => this._name;

  String get pathImage => this._pathImage;

  int get remainingQuantity => this._remainingQuantity;

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
}
