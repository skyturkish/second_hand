// TODO bak buraya da aynı şeyi yazacağım bunlar gerçekten gerekiyor mu provider ile yapmama ???????? hiç doğru hissetirmiyor
import 'package:flutter/cupertino.dart';
import 'package:second_hand/models/user.dart';
import 'package:second_hand/service/cloud/user/user_service.dart';

class UserInformationNotifier extends ChangeNotifier {
  UserInformation get userInformation => _userInformation;

  UserInformation _userInformation = UserInformation(
    userId: '',
    name: '',
  );

  Future<void> getUserInformation({required String userId}) async {
    // çok uzattın aga o ismi
    final userInformationFromFirebase = await UserCloudFireStoreService.instance.getUserInformationById(userId: userId);
    _userInformation = userInformationFromFirebase!;
    _userInformation.favoriteAds.add('value'); // we added this because, when list is empty flutter throw crash ??
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

  bool anyChanges({required String name, required String aboutYou}) {
    return name != _userInformation.name || aboutYou != _userInformation.aboutYou;
  }

  Future<void> changeUserInformation({required String name, required String aboutYou}) async {
    if (!anyChanges(name: name, aboutYou: aboutYou)) return;
    _userInformation.name = name;
    _userInformation.aboutYou = aboutYou;
    notifyListeners();
  }
}
