import 'package:flutter/material.dart';
import 'package:money_management/db/category_db.dart';
import 'package:money_management/models/category_model.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);

TextEditingController _categoryNameController = TextEditingController();
//CategoryDb singleton = CategoryDb.instance;

Future<void> showCategoryPopupSheet(BuildContext context) async {
  showDialog(
      context: context,
      builder: ((ctx) {
        return SimpleDialog(
          title: const Text('Add Category'),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: TextFormField(
                controller: _categoryNameController,
                decoration: const InputDecoration(
                    hintText: 'Category name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Row(
                children: const [
                  RadioButton(title: 'Income', type: CategoryType.income),
                  RadioButton(title: 'Expense', type: CategoryType.expense)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                onPressed: () {
                  final name = _categoryNameController.text;
                  if (name.isEmpty) {
                    return;
                  }
                  final categoryModel = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: name,
                      type: selectedCategory.value);

                  CategoryDb().insertCategory(categoryModel);
                  _categoryNameController.text = '';
                  Navigator.of(ctx).pop();
                },
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }));
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategory,
            builder: ((context, value, child) {
              return Radio<CategoryType>(
                  value: type,
                  groupValue: selectedCategory.value,
                  onChanged: (value) {
                    if (value == null) return;
                    print('values is $value');
                    selectedCategory.value = value;
                    selectedCategory.notifyListeners();
                  });
            })),
        Text(title)
      ],
    );
  }
}
