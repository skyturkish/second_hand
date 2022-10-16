import 'package:second_hand/models/user.dart';

abstract class IUserCloudFireStoreService {
  Future<void> createUserIfNotExist({required String userId, String? name}); // Create
  Future<UserInformation?> getUserInformationById({required String userId}); // Read
  Future<void> updateUserInformation(
      {required String userId, required String name, required String aboutYou}); // Update
  Future<void> deleteUserById({required String userId}); // Delete
  Future<void> updateUserProfilePhotoPath({required String userId, required String profilePhotoURL}); // Update
  Future<bool> isUserExist({required String userId}); // Check
  Future<void> addProductToFavorites({required String userId, required String productId}); // Update
  Future<void> removeProductToFavorites({required String userId, required String productId}); // Update
  Future<void> followUser({required String userIdWhichOneWillFollow, required String followerId}); // update
  Future<void> breakFollowUser({required String userIdWhichOneWillFollow, required String followerId});
  Future<List<UserInformation>?> getUsersByFollowers({required List<String> followList}); // read
  Future<List<UserInformation>?> getUsersByFollowings({required List<String> followList}); // read

}
