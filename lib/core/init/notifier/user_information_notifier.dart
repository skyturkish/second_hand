import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/services/cloud/user/user_service.dart';

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

  void clearUserInformationsLocal() {
    updateUserInformation(
      userId: 'default user name',
      name: 'default name',
      profilePhotoPath: 'default profile photo path',
      phoneNumber: 'default phone number',
      aboutYou: 'Hi I am here new',
      myProducts: [],
      favoriteProducts: [],
      following: [],
      followers: [],
    );
    notifyListeners();
  }

  // bu da buraya ait değil, set fonksiyonu gibi bir şey olması lazım değil mi
  Future<void> getUserInformationById({required String userId}) async {
    final userInformationFromFirebase = await UserCloudFireStoreService.instance.getUserInformationById(userId: userId);
    if (userInformationFromFirebase == null) return;
    _userInformation = userInformationFromFirebase;
    // we added this because, when list is empty firebase throw crash ?
    _userInformation!.favoriteProducts.add('value');

    notifyListeners();
  }

  bool isProductInFavoriteProducts({required String productId}) {
    if (_userInformation == null) return false;

    return userInformation!.favoriteProducts.contains(productId);
  }

  // şöyle yapabiliriz eğerki oradaki uzunluk halen buradaki uzunlukla aynı ise tekrardan servise çıkmayız ?
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
