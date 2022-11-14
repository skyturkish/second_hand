import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final String productId;
  final String ownerId;
  final String condition;
  final String title;
  final String description;
  List<String> imagesUrl;
  final int price;
  final String productSellState;
  final String locateCountry;
  final String locateCity;

  Product({
    required this.productId,
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

  void addImages({required String downloadURL}) {
    imagesUrl.add(downloadURL);
  }

  Product.fromSnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : productId = snapshot.data()['productId'] as String,
        ownerId = snapshot.data()['ownerId'] as String,
        condition = snapshot.data()['condition'] as String,
        title = snapshot.data()['title'] as String,
        description = snapshot.data()['description'] as String,
        imagesUrl = List<String>.from(snapshot.data()['imagesUrl']),
        price = snapshot.data()['price'] as int,
        productSellState = snapshot.data()['productSellState'] as String,
        locateCountry = snapshot.data()['locateCountry'] as String,
        locateCity = snapshot.data()['locateCity'] as String;

  factory Product.fromMap(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? productId,
    String? ownerId,
    String? condition,
    String? title,
    String? description,
    List<String>? imagesUrl,
    int? price,
    String? productSellState,
    String? locateCountry,
    String? locateCity,
  }) {
    return Product(
      productId: productId ?? this.productId,
      ownerId: ownerId ?? this.ownerId,
      condition: condition ?? this.condition,
      title: title ?? this.title,
      description: description ?? this.description,
      imagesUrl: imagesUrl ?? this.imagesUrl,
      price: price ?? this.price,
      productSellState: productSellState ?? this.productSellState,
      locateCountry: locateCountry ?? this.locateCountry,
      locateCity: locateCity ?? this.locateCity,
    );
  }
}
