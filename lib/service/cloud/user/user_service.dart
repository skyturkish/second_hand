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

  Future<void> createUser({required String userId, String? name}) async {
    bool userExist = await isUserExist(userId: userId);
    if (userExist == true) {}
    await collection.doc(userId).set(UserInformation(userId: userId, name: 'User-${const Uuid().v4()}').toMap());
  }

  Future<bool> isUserExist({required String userId}) async {
    var docRef = collection.doc(userId);
    final doc = await docRef.get();
    return doc.data() == null ? false : true;
  }

  Future<Map<String, dynamic>?> getUserInformationById({required String id}) async {
    var docRef = collection.doc(id);
    final doc = await docRef.get();
    return doc.data();
  }
}
