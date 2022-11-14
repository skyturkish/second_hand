// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['productId'] as String,
      ownerId: json['ownerId'] as String,
      condition: json['condition'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imagesUrl: (json['imagesUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      price: json['price'] as int,
      productSellState: json['productSellState'] as String? ?? 'sell',
      locateCountry:
          json['locateCountry'] as String? ?? 'locateCountry Unknown',
      locateCity: json['locateCity'] as String? ?? 'locateCity Unknown',
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'productId': instance.productId,
      'ownerId': instance.ownerId,
      'condition': instance.condition,
      'title': instance.title,
      'description': instance.description,
      'imagesUrl': instance.imagesUrl,
      'price': instance.price,
      'productSellState': instance.productSellState,
      'locateCountry': instance.locateCountry,
      'locateCity': instance.locateCity,
    };
