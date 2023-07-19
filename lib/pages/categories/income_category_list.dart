import 'package:flutter/material.dart';
import 'package:money_management/db/category_db.dart';
import 'package:money_management/models/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    //CategoryDb singleton = CategoryDb.instance;
    return ValueListenableBuilder(
        valueListenable: CategoryDb().listOfIncomeCategoryModel,
        builder: ((context, List<CategoryModel> listOfIncome, child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Card(
                    child: ListTile(
                      trailing: IconButton(
                          onPressed: () {
                            CategoryDb().deleteCategory(listOfIncome[index].id);
                          },
                          icon: const Icon(Icons.delete)),
                      title: Text(
                        listOfIncome[index].name,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 0,
                );
              },
              itemCount: listOfIncome.length);
        }));
  }
}
