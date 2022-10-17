import 'package:flutter/cupertino.dart';

class ProductDetailViewModelNotifier extends ChangeNotifier {
  ProductDetailViewModelNotifier();

  int currentPageIndex = 1;

  void setCurrentPageIndex({required int index}) {
    currentPageIndex = index;
    notifyListeners();
  }

  void resetPageIndex() {
    currentPageIndex = 0;
    notifyListeners();
  }
}
