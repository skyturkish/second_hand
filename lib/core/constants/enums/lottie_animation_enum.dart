enum LottieAnimation {
  notFound(name: '404_not_found'),
  splash(name: 'splash'),
  messageChat(name: 'message_chat'),
  uploadPhotos(name: 'upload_photos'),
  location(name: 'location'),
  loading(name: 'loading'),
  noInternet(name: 'no-internet');

  const LottieAnimation({
    required this.name,
  });

  final String name;

  String get fullPath => 'assets/animations/$name.json';
}
