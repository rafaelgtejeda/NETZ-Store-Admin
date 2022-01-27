import 'package:flutter/material.dart';
import 'package:netzstore/models/sort_model.dart';

class SearchBarProvider with ChangeNotifier {
  late SortModel _sortModel;
  SortModel get sortModel => _sortModel;
  SearchBarProvider() {
    _sortModel = SortModel(sortAscending: null);
    _sortModel.sortColumnIndex = 0;
    _sortModel.sortAscending = false;
  }

  setSort(int columnIndex, String sortColumnName, bool ascending) {
    _sortModel.sortAscending = ascending;
    _sortModel.sortColumnIndex = columnIndex;
    _sortModel.sortColumnName = sortColumnName;
    notifyListeners();
  }
}
