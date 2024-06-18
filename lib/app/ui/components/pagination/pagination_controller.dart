import 'package:flutter/material.dart';

class PaginationController extends ChangeNotifier {
  int page = 1;
  int? initialPage;

  PaginationController({this.initialPage = 1});

  void moveTo(int page) {
    this.page = page;
    notifyListeners();
  }

  void back() {
    page--;
    notifyListeners();
  }

  void next() {
    page++;
    notifyListeners();
  }
}
