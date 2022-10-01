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
  );

  Future<void> getUserInformation({required String userId}) async {
    // çok uzattın aga o ismi
    final userInformationFromFirebase = await UserCloudFireStoreService.instance.getUserInformationById(userId: userId);
    _userInformation = userInformationFromFirebase!;
    notifyListeners();
  }
}
