import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/user_information.dart';

class UserInformationNotifier extends ChangeNotifier {
  UserInformation? get userInformation => _userInformation;

  UserInformation? _userInformation;

  void updateUserInformation({
    String? userId,
    String? name,
    String? profilePhotoPath,
    String? phoneNumber,
    String? aboutYou,
    List<String>? myProducts,
    List<String>? favoriteProducts,
    List<String>? following,
    List<String>? followers,
  }) {
    if (_userInformation == null) return;

    _userInformation = _userInformation!.copyWith(
      userId: userId,
      name: name,
      profilePhotoPath: profilePhotoPath,
      phoneNumber: phoneNumber,
      aboutYou: aboutYou,
      myProducts: myProducts,
      favoriteProducts: favoriteProducts,
      following: following,
      followers: followers,
    );
    notifyListeners();
  }

  void setAllUserInformation({required UserInformation userInformation}) {
    _userInformation = userInformation;
    notifyListeners();
  }

  void clearUserInformationsLocal() {
    _userInformation = null;
    notifyListeners();
  }

  bool isProductInFavoriteProducts({required String productId}) {
    if (_userInformation == null) return false;
    return userInformation!.favoriteProducts.contains(productId);
  }

  Future<void> addFavoriteProductLocal({required String productId}) async {
    if (_userInformation == null) return;
    _userInformation!.favoriteProducts.add(productId);
    notifyListeners();
  }

  Future<void> removeFavoriteProductLocal({required String productId}) async {
    if (_userInformation == null) return;
    _userInformation!.favoriteProducts.remove(productId);
    notifyListeners();
  }

  Future<void> followUserLocal({required String userIdWhichOneWillFollow}) async {
    if (_userInformation == null) return;
    _userInformation!.following.add(userIdWhichOneWillFollow);
    notifyListeners();
  }

  Future<void> breakFollowUserLocal({required String userIdWhichOneWillFollow}) async {
    if (_userInformation == null) return;
    _userInformation!.following.remove(userIdWhichOneWillFollow);
    notifyListeners();
  }
}
