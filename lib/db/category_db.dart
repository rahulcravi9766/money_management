import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<void> insertCategory(CategoryModel value);

  Future<List<CategoryModel>> getCategories();

  Future<void> deleteCategory(String id);
}

class CategoryDb implements CategoryDbFunctions {
  static final CategoryDb _instance = CategoryDb._privateConstructor();
  factory CategoryDb() {
    return _instance;
  }

  CategoryDb._privateConstructor();

  // //private constructor
  // CategoryDb._();

  // //Singleton instance
  // static final CategoryDb _instance = CategoryDb._();

  // //Getter to access the instance
  // static CategoryDb get instance => _instance;

  ValueNotifier<List<CategoryModel>> listOfIncomeCategoryModel =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> listOfExpenseCategoryModel =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id, value);
    await refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    listOfExpenseCategoryModel.value.clear();
    listOfIncomeCategoryModel.value.clear();
    final _allCategories = await getCategories();

    await Future.forEach(
        _allCategories,
        (element) => {
              if (element.type == CategoryType.income)
                {listOfIncomeCategoryModel.value.add(element)}
              else
                {listOfExpenseCategoryModel.value.add(element)}
            });
    listOfExpenseCategoryModel.notifyListeners();
    listOfIncomeCategoryModel.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String id) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(id);
    refreshUI();
  }
}
