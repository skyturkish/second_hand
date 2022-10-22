import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String productId;
  String ownerId;
  String condition;
  String title;
  String description;
  List<String> imagesUrl;
  int price;
  String documentId;
  // TODO final String location

  Product({
    required this.productId,
    required this.ownerId,
    required this.condition,
    required this.title,
    required this.description,
    required this.price,
    this.documentId = '',
    this.imagesUrl = const [],
  });

  Product.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        productId = snapshot.data()['productId'] as String,
        ownerId = snapshot.data()['ownerId'] as String,
        condition = snapshot.data()['condition'] as String,
        title = snapshot.data()['title'] as String,
        description = snapshot.data()['description'] as String,
        imagesUrl = List<String>.from(snapshot.data()['imagesUrl']),
        price = snapshot.data()['price'] as int;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    // cascade consecutive method
    // https://dart.dev/guides/language/language-tour#cascade-notation
    result
      ..addAll({'productId': productId})
      ..addAll({'ownerId': ownerId})
      ..addAll({'condition': condition})
      ..addAll({'title': title})
      ..addAll({'description': description})
      ..addAll({'imagesUrl': imagesUrl})
      ..addAll({'price': price})
      ..addAll({'documentId': documentId});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'] ?? '',
      ownerId: map['ownerId'] ?? '',
      condition: map['condition'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      imagesUrl: List<String>.from(map['imagesUrl']),
      price: map['price']?.toInt() ?? 0,
      documentId: map['documentId'] ?? '',
    );
  }
}
