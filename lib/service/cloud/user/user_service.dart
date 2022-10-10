import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/cloud/user/abstract_user_service.dart';
import 'package:uuid/uuid.dart';

class UserCloudFireStoreService implements IUserCloudFireStoreService {
  UserCloudFireStoreService._init();

  static UserCloudFireStoreService get instance {
    _instance ??= UserCloudFireStoreService._init();
    return _instance!;
  }

  static UserCloudFireStoreService? _instance;

  final _collection = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> createUserIfNotExist({required String userId, String? name}) async {
    final userExist = await isUserExist(userId: userId);
    if (userExist == true) return;
    await _collection.doc(userId).set(UserInformation(
            profilePhotoPath:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSI64fYIV7EMYQ8XUYQ4_QrZM0YxY353PQI1yNYuaXbb_YbTJGwozRe6ru-RIsWTjGE8ZQ&usqp=CAU',
            userId: userId,
            name: 'User-${const Uuid().v4()}')
        .toMap());
  }

  @override
  Future<void> deleteUserById({required String userId}) async {
    final userExist = await isUserExist(userId: userId);
    if (userExist == true) {
      await _collection.doc(userId).delete();
    }
  }

  @override
  Future<void> updateUserInformation({required String userId, required String name, required String aboutYou}) async {
    final userExist = await isUserExist(userId: userId);
    if (userExist == false) return;
    await _collection.doc(userId).update({'name': name, 'aboutYou': aboutYou});
  }

  @override
  Future<void> updateUserProfilePhotoPath({required String userId, required String profilePhotoURL}) async {
    final userExist = await isUserExist(userId: userId);
    if (userExist == false) return;
    await _collection.doc(userId).update({'profilePhotoPath': profilePhotoURL});
  }

  @override
  Future<bool> isUserExist({required String userId}) async {
    final docRef = _collection.doc(userId);
    final doc = await docRef.get();
    return doc.data() != null;
  }

  @override
  Future<UserInformation?> getUserInformationById({required String userId}) async {
    final userExist = await isUserExist(userId: userId);

    if (userExist == false) return null;

    final docRef = _collection.doc(userId);

    final doc = await docRef.get();

    return UserInformation.fromMap(doc.data()!);
  }

  @override
  Future<void> addProductToFavorites({required String userId, required String productId}) async {
    await _collection.doc(userId).update({
      'favoriteAds': FieldValue.arrayUnion([productId])
    });
  }

  @override
  Future<void> removeProductToFavorites({required String userId, required String productId}) async {
    await _collection.doc(userId).update({
      'favoriteAds': FieldValue.arrayRemove([productId])
    });
  }
}
