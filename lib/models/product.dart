class Product {
  String productId;
  String ownerId;
  String state;
  String title;
  String description;
  List<String> images;
  int price;
  //  final String location; // TODO

  Product({
    required this.productId,
    required this.ownerId,
    required this.state,
    required this.title,
    required this.description,
    required this.price,
    this.images = const [],
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'productId': productId});
    result.addAll({'ownerId': ownerId});
    result.addAll({'state': state});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'images': images});
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
      images: List<String>.from(map['images']),
      price: map['price']?.toInt() ?? 0,
    );
  }
}
