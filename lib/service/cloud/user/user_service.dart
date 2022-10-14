import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/cloud/user/abstract_user_service.dart';
import 'package:uuid/uuid.dart';

@immutable
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

    await _collection.doc(userId).set(UserInformation(userId: userId, name: 'User-${const Uuid().v4()}').toMap());
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
      'favoriteProducts': FieldValue.arrayUnion([productId])
    });
  }

  @override
  Future<void> removeProductToFavorites({required String userId, required String productId}) async {
    await _collection.doc(userId).update({
      'favoriteProducts': FieldValue.arrayRemove([productId])
    });
  }

  @override
  Future<void> followUser({required String userIdWhichOneWillFollow, required String followerId}) async {
    await _collection.doc(followerId).update({
      'following': FieldValue.arrayUnion([userIdWhichOneWillFollow])
    });

    await _collection.doc(userIdWhichOneWillFollow).update({
      'followers': FieldValue.arrayUnion([followerId])
    });
  }

  @override
  Future<void> breakFollowUser({required String userIdWhichOneWillFollow, required String followerId}) async {
    await _collection.doc(followerId).update({
      'following': FieldValue.arrayRemove([userIdWhichOneWillFollow])
    });

    await _collection.doc(userIdWhichOneWillFollow).update({
      'followers': FieldValue.arrayRemove([followerId])
    });
  }

  @override
  Future<List<UserInformation>?> getUsersByFollowers({required List<String> followList}) async {
    final querySnapShot = await _collection.where('userId', whereIn: followList).get();
    final users =
        querySnapShot.docs.map((queryDocumentSnapshot) => UserInformation.fromMap(queryDocumentSnapshot.data()));
    return users.toList();
  }

  @override
  Future<List<UserInformation>?> getUsersByFollowings({required List<String> followList}) async {
    final querySnapShot = await _collection.where('userId', whereIn: followList).get();
    final users =
        querySnapShot.docs.map((queryDocumentSnapshot) => UserInformation.fromMap(queryDocumentSnapshot.data()));
    return users.toList();
  }
}
