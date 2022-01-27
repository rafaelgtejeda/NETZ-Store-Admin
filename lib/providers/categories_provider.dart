import 'package:flutter/material.dart';
import 'package:netzstore/models/category_model.dart';
import 'package:netzstore/services/api_services.dart';

class CategoriesProvider with ChangeNotifier {
  
  late APIService _apiService;

  late List<CategoryModel> _categoriesList;

  List<CategoryModel> get categoriesList => _categoriesList;

  double get totalRecords => _categoriesList.length.toDouble();

  CategoriesProvider() {

    _apiService = APIService();

    _categoriesList = [];

  }

  resetStreams() {

    _apiService = APIService();

    _categoriesList = [];

    notifyListeners();
  }

  fetchCategories({
    String? strSearch,
    String? sortBy,
    String? sortOrder,
  }) async {
    
    List<CategoryModel> categoriesList = await _apiService.getCategories(strSearch: strSearch, sortBy: sortBy, sortOrder: sortOrder);
    
    if (_categoriesList != null) {

      List<CategoryModel>.empty(growable: true);

    }

    if (categoriesList.isNotEmpty) {

      _categoriesList = [];

      _categoriesList.addAll(categoriesList);

    }

    notifyListeners();
  }

  createCategory(CategoryModel model, Function onCallBack) async {
    
    CategoryModel _categoryModel = await _apiService.createCategory(model: model);

    if (_categoriesList != null) {

      _categoriesList.add(_categoryModel);

      onCallBack(true);

    } else {

      onCallBack(false);
    }

    notifyListeners();
  }

  updateCategory(CategoryModel? model, Function onCallBack) async {
    
    CategoryModel _categoryModel = await _apiService.updateCategory(model: model);

    if (_categoriesList != null) {

      _categoriesList.remove(model!);

      _categoriesList.add(_categoryModel);

      onCallBack(true);

    } else {

      onCallBack(false);

    }

    notifyListeners();
  }

  deleteCategory(CategoryModel? model, Function onCallBack) async {

    bool isDeleted = await _apiService.deleteCategory(model: model);

    if (isDeleted) {

      _categoriesList.remove(model);

    }

    onCallBack(isDeleted);

    notifyListeners();

  }

}
