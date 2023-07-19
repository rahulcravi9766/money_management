import 'package:flutter/material.dart';
import 'package:money_management/db/category_db.dart';
import 'package:money_management/pages/categories/expense_category_list.dart';
import 'package:money_management/pages/categories/income_category_list.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    // CategoryDb singleton = CategoryDb.instance;
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(controller: _tabController, tabs: const [
          Tab(
            text: 'Income',
          ),
          Tab(
            text: 'Expense',
          )
        ]),
        Expanded(
          child: TabBarView(
              controller: _tabController,
              children: const [IncomeCategoryList(), ExpenseCategoryList()]),
        )
      ],
    );
  }
}
