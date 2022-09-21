import 'package:second_hand/models/product.dart';
import 'package:second_hand/service/cloud/base-service.dart';
import 'package:second_hand/service/storage/upload_image.dart';

class GroupCloudFireStoreService extends CloudFireStoreBaseService {
  static GroupCloudFireStoreService get instance {
    _instance ??= GroupCloudFireStoreService._init(collectionName: 'products');
    return _instance!;
  }

  GroupCloudFireStoreService._init({required super.collectionName});

  static GroupCloudFireStoreService? _instance;

  // TODO prodcut'ın altında topla fotoğrafları
  Future<void> createProduct({required Product product}) async {
    await collection.doc().set(
          product.toMap(),
        );

    for (var image in product.images) {
      await uploadProductPhoto(
        file: image,
        productId: product.productId,
      );
    }
  }
}
