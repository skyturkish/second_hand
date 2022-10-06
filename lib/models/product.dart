import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String productId;
  String ownerId;
  String state;
  String title;
  String description;
  List<String> imagesPath;
  int price;
  String documentId;
  //  final String location; // TODO

  Product({
    required this.productId,
    required this.ownerId,
    required this.state,
    required this.title,
    required this.description,
    required this.price,
    this.documentId = '',
    this.imagesPath = const [],
  });

  Product.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        productId = snapshot.data()['productId'] as String,
        ownerId = snapshot.data()['ownerId'] as String,
        state = snapshot.data()['state'] as String,
        title = snapshot.data()['title'] as String,
        description = snapshot.data()['description'] as String,
        imagesPath = List<String>.from(snapshot.data()['imagesPath']),
        price = snapshot.data()['price'] as int;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    //  cascade consecutive method
    // https://dart.dev/guides/language/language-tour#cascade-notation

    result
      ..addAll({'productId': productId})
      ..addAll({'ownerId': ownerId})
      ..addAll({'state': state})
      ..addAll({'title': title})
      ..addAll({'description': description})
      ..addAll({'imagesPath': imagesPath})
      ..addAll({'price': price})
      ..addAll({'documentId': documentId});

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
      documentId: map['documentId'] ?? '',
    );
  }
}
