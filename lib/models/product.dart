import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String productId;
  String documentId;
  String ownerId;
  String condition;
  String title;
  String description;
  List<String> imagesUrl;
  int price;
  String productSellState;
  String locateCountry;
  String locateCity;

  Product({
    required this.productId,
    this.documentId = '',
    required this.ownerId,
    required this.condition,
    required this.title,
    required this.description,
    this.imagesUrl = const [],
    required this.price,
    this.productSellState = 'sell',
    this.locateCountry = 'locateCountry Unknown',
    this.locateCity = 'locateCity Unknown',
  });

  Product.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        productId = snapshot.data()['productId'] as String,
        ownerId = snapshot.data()['ownerId'] as String,
        condition = snapshot.data()['condition'] as String,
        title = snapshot.data()['title'] as String,
        description = snapshot.data()['description'] as String,
        imagesUrl = List<String>.from(snapshot.data()['imagesUrl']),
        price = snapshot.data()['price'] as int,
        productSellState = snapshot.data()['productSellState'] as String,
        locateCountry = snapshot.data()['locateCountry'] as String,
        locateCity = snapshot.data()['locateCity'] as String;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'productId': productId});
    result.addAll({'documentId': documentId});
    result.addAll({'ownerId': ownerId});
    result.addAll({'condition': condition});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'imagesUrl': imagesUrl});
    result.addAll({'price': price});
    result.addAll({'productSellState': productSellState});
    result.addAll({'locateCountry': locateCountry});
    result.addAll({'locateCity': locateCity});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'] ?? '',
      documentId: map['documentId'] ?? '',
      ownerId: map['ownerId'] ?? '',
      condition: map['condition'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imagesUrl: List<String>.from(map['imagesUrl']),
      price: map['price']?.toInt() ?? 0,
      productSellState: map['productSellState'] ?? '',
      locateCountry: map['locateCountry'] ?? '',
      locateCity: map['locateCity'] ?? '',
    );
  }
}
