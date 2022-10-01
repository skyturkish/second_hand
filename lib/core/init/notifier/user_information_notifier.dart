// TODO bak buraya da aynı şeyi yazacağım bunlar gerçekten gerekiyor mu provider ile yapmama ???????? hiç doğru hissetirmiyor
import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/cloud/user/user_service.dart';

class UserInformationNotifier extends ChangeNotifier {
  static final UserInformationNotifier _instance = UserInformationNotifier._init();

  static UserInformationNotifier get instance => _instance;

  UserInformationNotifier._init();

  UserInformation get userInformation => _userInformation;

  UserInformation _userInformation = UserInformation(
    userId: '',
    name: '',
    favoriteAds: ['value'],
  );

  Future<void> getUserInformation({required String userId}) async {
    // çok uzattın aga o ismi
    final userInformationFromFirebase = await UserCloudFireStoreService.instance.getUserInformationById(userId: userId);
    _userInformation = userInformationFromFirebase!;
    _userInformation.favoriteAds.isEmpty ? _userInformation.favoriteAds.add('value') : null;

    notifyListeners();
  }

  Future<void> addFavoriteProduct({required String productId}) async {
    _userInformation.favoriteAds.add(productId);
    notifyListeners();
    await UserCloudFireStoreService.instance.addProductToFavorites(
      userId: _userInformation.userId,
      productId: productId,
    );
  }

  Future<void> removeFavoriteProduct({required String productId}) async {
    _userInformation.favoriteAds.remove(productId);
    notifyListeners();
    await UserCloudFireStoreService.instance.removeProductToFavorites(
      userId: _userInformation.userId,
      productId: productId,
    );
  }
}
