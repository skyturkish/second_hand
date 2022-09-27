class Product {
  String productId;
  String ownerId;
  String state;
  String title;
  String description;
  List<String> imagesPath; // referans'lara kolay erişebilmen için tutacaksın, referans path'lerini
  int price;
  //  final String location; // TODO

  Product({
    required this.productId,
    required this.ownerId,
    required this.state,
    required this.title,
    required this.description,
    required this.price,
    this.imagesPath = const [],
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'productId': productId});
    result.addAll({'ownerId': ownerId});
    result.addAll({'state': state});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'imagesPath': imagesPath});
    result.addAll({'price': price});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'] ?? '',
      ownerId: map['ownerId'] ?? '',
      state: map['state'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imagesPath: List<String>.from(map['imagesPath']),
      price: map['price']?.toInt() ?? 0,
    );
  }
}
