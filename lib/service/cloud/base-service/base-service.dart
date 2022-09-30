import 'package:cloud_firestore/cloud_firestore.dart';

// TODO
// T alsın içinde de T model olabilir BUndan türettiğin şeylere bir model ver o modelde fromfirebase, to firebase gibi methodları olsun onlardan türemiş olsun

class CloudFireStoreBaseService {
  final String collectionName;
  late final CollectionReference<Map<String, dynamic>> collection;

  CloudFireStoreBaseService({
    required this.collectionName,
  }) {
    collection = FirebaseFirestore.instance.collection(collectionName);
  }

  Future<void> addData({String? docName, required Map<String, dynamic> data}) async {
    await collection.doc(docName).set(data);
  }

  Future<void> deleteDocument({required String docName}) async {
    await collection.doc(docName).delete();
  }

  Future<Map<String, dynamic>?> getDocument({required String docName}) async {
    // Burayı daha generic hale getirebilirsin T al ve T.fromFirebase() ile döndür
    // ama null dönme ihtimali var, yani düşün bunu bi
    DocumentSnapshot<Object> doc = await collection.doc(docName).get();
    if (doc.data() == null) return null;
    final data = doc.data() as Map<String, dynamic>;
    return data;
  }

  Future<List<Map<String, dynamic>?>> getAllDocuments() async {
    QuerySnapshot documents = await collection.get();
    return documents.docs.map(
      (doc) {
        final adana = doc.data() as Map<String, dynamic>;
        return adana;
      },
    ).toList();
  }

  // bu hayvan gibi genişletilmesi gereken bir yapı, ama galiba her service kendi içinde genişletecek bunu
  // ama yinede bir tane aşırı dynamic&generic bir function bulunmalı base-serviceda
  Future<List<Map<String, dynamic>?>> getAllDocumentsFilter({required String filterBy, required String filter}) async {
    QuerySnapshot documents = await collection.where(filterBy, isEqualTo: filter).get();
    return documents.docs.map(
      (doc) {
        final adana = doc.data() as Map<String, dynamic>;
        return adana;
      },
    ).toList();
  }
}
