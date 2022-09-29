class User {
  final String userId;
  final String name;
  String? profilePhotoPath;
  String? phoneNumber;
  String? aboutYou;
  final List<String> myAds;
  final List<String> favoriteAds;
  // following
  // follower
  User({
    required this.userId,
    required this.name,
    required this.profilePhotoPath,
    required this.phoneNumber,
    required this.aboutYou,
    this.myAds = const [],
    this.favoriteAds = const [],
  });
}
