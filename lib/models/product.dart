import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Product {
  String productId;
  String ownerId;
  String state;
  String title;
  String description;
  List<File> images;
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.productId == productId &&
        other.ownerId == ownerId &&
        other.state == state &&
        other.title == title &&
        other.description == description &&
        listEquals(other.images, images) &&
        other.price == price;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        ownerId.hashCode ^
        state.hashCode ^
        title.hashCode ^
        description.hashCode ^
        images.hashCode ^
        price.hashCode;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'productId': productId});
    result.addAll({'ownerId': ownerId});
    result.addAll({'state': state});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'images': []});
    result.addAll({'price': price});

    return result;
  }

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Product(
      productId: data?['productId'],
      ownerId: data?['ownerId'],
      state: data?['state'],
      title: data?['title'],
      description: data?['description'],
      images: [],
      price: data?['price'],
    );
  }

  Map<String, dynamic> toFirestore() {
    final result = <String, dynamic>{};

    result.addAll({'productId': productId});
    result.addAll({'ownerId': ownerId});
    result.addAll({'state': state});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'images': []});
    result.addAll({'price': price});

    return result;
  }
}
