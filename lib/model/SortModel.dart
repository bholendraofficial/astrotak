import 'package:flutter/cupertino.dart';

class SortModel {
  int id;
  String name;
  bool isSelected;
  Sorting sorting;

  SortModel(
      {@required this.id,
      @required this.name,
      @required this.isSelected,
      @required this.sorting});
}

enum Sorting {
  EX_HIGH_TO_LOW,
  EX_LOW_TO_HIGH,
  PRICE_HIGH_TO_LOW,
  PRICE_LOW_TO_HIGH,
}
