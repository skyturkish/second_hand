import 'package:second_hand/service/cloud/base-service.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class GroupCloudFireStoreService extends CloudFireStoreBaseService {
  static GroupCloudFireStoreService get instance {
    _instance ??= GroupCloudFireStoreService._init(collectionName: 'products');
    return _instance!;
  }

  GroupCloudFireStoreService._init({required super.collectionName});

  static GroupCloudFireStoreService? _instance;

  // Future<void> createProduct({required Product product}) async {
  //   await collection.doc().set(
  //         product.toMap(),
  //       );

  //   for (var image in product.images) {
  //     await uploadProductPhoto(
  //       file: image,
  //       productId: product.productId,
  //     );
  //   }
  // }

  // Future<List<Product>> getAllProductsWithoutImages() async {
  //   final storageRef = FirebaseStorage.instance.ref('products');

  //   final documents = await collection.get();

  //   Iterable<Product> products = documents.docs.map(
  //     (product) => Product.fromFirestore(
  //       product,
  //       null,
  //     ),
  //   );

  //   final productsList = products.toList();

  // for (var product in productsList) {
  //   final images = await getImages(product.productId);
  //   for (var image in images) {
  //     final uint8List = await image.getData();
  //     final file = File.fromRawPath(uint8List!);

  //     product.images.add(file);
  //     product.images.length.log();
  //   }
  // }
  // productsList[0].title.log();
  // productsList[0].images.length.log();

  //   return productsList.toList();
  // }

  // Future<List<Product>> getAllProducts() async {
  //   final storageRef = FirebaseStorage.instance.ref('products');

  //   final documents = await collection.get();

  //   final products = documents.docs.map(
  //     (product) => Product.fromFirestore(
  //       product,
  //       null,
  //     ),
  //   );

  //   for (var i = 0; i < products.length; i++) {
  //     final references = await getImages(products.toList()[i].productId);
  //     for (var c = 0; c < references.length; c++) {
  //       final uint8List = await references.toList()[c].getData();
  //       final file = File.fromRawPath(uint8List!);
  //       products.toList()[i].images.add(file);
  //     }
  //   }

  //   return products.toList();
  // }
}
