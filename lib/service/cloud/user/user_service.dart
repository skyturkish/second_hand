import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/cloud/base-service/base-service.dart';
import 'package:uuid/uuid.dart';

class UserCloudFireStoreService extends CloudFireStoreBaseService {
  static UserCloudFireStoreService get instance {
    _instance ??= UserCloudFireStoreService._init(collectionName: 'users');
    return _instance!;
  }

  UserCloudFireStoreService._init({required super.collectionName});

  static UserCloudFireStoreService? _instance;

  Future<void> createUserIfNotExist({required String userId, String? name}) async {
    bool userExist = await isUserExist(userId: userId);
    if (userExist == true) return;
    await collection.doc(userId).set(UserInformation(userId: userId, name: 'User-${const Uuid().v4()}').toMap());
  }

  Future<void> deleteUser({required String userId}) async {
    bool userExist = await isUserExist(userId: userId);
    if (userExist == true) {
      await collection.doc(userId).delete();
    }
  }

  Future<bool> isUserExist({required String userId}) async {
    var docRef = collection.doc(userId);
    final doc = await docRef.get();
    return doc.data() == null ? false : true;
  }

  Future<UserInformation?> getUserInformationById({required String userId}) async {
    bool userExist = await isUserExist(userId: userId);
    if (userExist == false) return null;
    var docRef = collection.doc(userId);
    final doc = await docRef.get();

    return UserInformation.fromMap(doc.data()!);
  }

  // TODO bu burada mı olması lazım ? producta mı ? yoksa ayrı bir serviste mi ?
  Future<void> addProductToFavorites({required String userId, required String productId}) async {
    collection.doc(userId).update({
      "favoriteAds": FieldValue.arrayUnion([productId])
    });
  }

  Future<void> removeProductToFavorites({required String userId, required String productId}) async {
    collection.doc(userId).update({
      "favoriteAds": FieldValue.arrayRemove([productId])
    });
  }

  Future<void> updateUserInformation({required String userId, required String name, required String aboutYou}) async {
    bool userExist = await isUserExist(userId: userId);
    if (userExist == false) return;
    await collection.doc(userId).update({'name': name, 'aboutYou': aboutYou});
  }
}
