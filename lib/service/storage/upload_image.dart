

// TODO bunun serviste olması lazım aslında
// Future<bool> uploadProductPhoto({
//   required File file,
//   required String productId,
// }) =>
//     FirebaseStorage.instance
//         .ref('products')
//         .child(productId)
//         .child(const Uuid().v4())
//         .putFile(file)
//         .then((_) => true)
//         .catchError((_) => false);

// Future<Iterable<Reference>> getImages(String productId) =>
//     FirebaseStorage.instance.ref('products').child(productId).list().then((listResult) => listResult.items);
