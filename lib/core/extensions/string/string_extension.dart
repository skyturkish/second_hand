extension OverFlowString on String {
  String overFlowString({int limit = 15}) {
    return length > limit ? '${substring(0, limit - 1)}...' : this;
  }
}

extension ToStorageReference on String {
  String get convertToStorageReferenceFromDownloadUrl => Uri.parse(this).pathSegments.last;
}
