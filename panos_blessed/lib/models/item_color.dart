class ItemColor {

  ItemColor({this.name, this.price, this.stock});

  ItemColor.fromMap(Map<String, dynamic> map){
    name = map['name'] as String;
    price = map['price'] as num;
    stock = map['stock'] as int;
  }

  String name;
  num price;
  int stock;

  bool get hasStock => stock > 0;

  ItemColor clone(){
    return ItemColor(
      name: name,
      price: price,
      stock: stock
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'price': price,
      'stock': stock
    };
  }

  @override
  String toString() {
    return 'ItemColor{name: $name, price: $price, stock: $stock}';
  }
}