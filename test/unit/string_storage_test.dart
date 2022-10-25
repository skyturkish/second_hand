// firebase storage download link
// from https://firebasestorage.googleapis.com/v0/b/second-hand-sky.appspot.com/o/products%2F2b1ab929-4914-4d1e-b133-9a2eae8143d8?alt=media&token=db1c975c-18d2-4dd7-bf4f-d3fe9eef7da1
// to products/2b1ab929-4914-4d1e-b133-9a2eae8143d8

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('from Storage download url to Storage reference', () {
    test('basic ', () {
      String downloadUrl =
          'https://firebasestorage.googleapis.com/v0/b/second-hand-sky.appspot.com/o/products%2F2b1ab929-4914-4d1e-b133-9a2eae8143d8?alt=media&token=db1c975c-18d2-4dd7-bf4f-d3fe9eef7da1';

      // first part
      int index = downloadUrl.indexOf('/o/');
      if (index >= 0) {
        downloadUrl = downloadUrl.substring(index + 3, downloadUrl.length);
      }
      // %2F  => /
      downloadUrl = downloadUrl.replaceAll('%2F', '/');

      // last part
      int index2 = downloadUrl.indexOf('?alt=media');
      if (index2 >= 0) {
        downloadUrl = downloadUrl.substring(0, index2);
      }

      expect(downloadUrl, 'products/2b1ab929-4914-4d1e-b133-9a2eae8143d8');
    });

    // thanks for help https://github.com/BSTech
    test('more clear thanks to bstech_', () {
      String downloadUrl =
          'https://firebasestorage.googleapis.com/v0/b/second-hand-sky.appspot.com/o/products%2F2b1ab929-4914-4d1e-b133-9a2eae8143d8?alt=media&token=db1c975c-18d2-4dd7-bf4f-d3fe9eef7da1';

      int ps = downloadUrl.lastIndexOf('/') + 1;
      int qs = downloadUrl.indexOf('?', ps);

      if (qs < 0) qs = downloadUrl.length;

      downloadUrl = downloadUrl.substring(ps, qs).replaceAll(RegExp(r'%2[Ff]'), '/');
      expect(downloadUrl, 'products/2b1ab929-4914-4d1e-b133-9a2eae8143d8');
    });
    // for more information https://www.youtube.com/watch?v=lkAeX3T6A9I
    // thanks for their help. https://github.com/BSTech   https://github.com/allxrise
    test(' Uri parse pathSegments', () {
      String downloadUrl =
          'https://firebasestorage.googleapis.com/v0/b/second-hand-sky.appspot.com/o/products%2F2b1ab929-4914-4d1e-b133-9a2eae8143d8?alt=media&token=db1c975c-18d2-4dd7-bf4f-d3fe9eef7da1';

      expect(Uri.parse(downloadUrl).pathSegments.last, 'products/2b1ab929-4914-4d1e-b133-9a2eae8143d8');
    });
  });
}
