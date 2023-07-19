import 'dart:math';

import 'package:flutter/material.dart';
import 'package:money_management/pages/categories/add_category_popup.dart';
import 'package:money_management/pages/categories/category_screen.dart';
import 'package:money_management/pages/transactions/add_new_transactions.dart';
import 'package:money_management/pages/transactions/trasactions_screen.dart';
import 'package:money_management/widgets/bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static ValueNotifier<int> selectedIndex = ValueNotifier(0);
  final _bottomScreens = [const TransactionsScreen(), const CategoriesScreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(249, 239, 242, 239),
        bottomNavigationBar: const MainBottomNavigation(),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (selectedIndex.value == 0) {
                print('if ${selectedIndex.value}');
                Navigator.pushNamed(
                    context, AddNewTransactionsScreen.routeName);
              } else {
                // final _categoryModel = CategoryModel(
                //     id: DateTime.now().millisecondsSinceEpoch.toString(),
                //     name: 'Salary',
                //     type: CategoryType.income);
                // CategoryDb().insertCategory(_categoryModel);
                showCategoryPopupSheet(context);
                print('else ${selectedIndex.value}');
              }
            },
            child: const Icon(Icons.add)),
        appBar: AppBar(
          title: const Text('Money Manager'),
          centerTitle: true,
        ),
        body: ValueListenableBuilder(
          valueListenable: selectedIndex,
          builder: (context, updatedIndex, child) {
            return _bottomScreens[updatedIndex];
          },
        ),
      ),
    );
  }
}
