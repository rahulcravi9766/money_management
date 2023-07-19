import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:money_management/db/category_db.dart';
import 'package:money_management/models/category_model.dart';

class AddNewTransactionsScreen extends StatelessWidget {
  static const routeName = 'add-new-transaction-screen';

  AddNewTransactionsScreen({super.key});

  ValueNotifier<CategoryType> radioButtonListener =
      ValueNotifier(CategoryType.income);

  ValueNotifier<String> selectedDate = ValueNotifier('');

  // ValueNotifier<String>? dropDownListener = ValueNotifier<String>(null);
  // final ValueNotifier<String> selectedOption = ValueNotifier<String>(null);

  final List<String> options = ['Option 1', 'Option 2', 'Option 3'];
  String? selectedOption;
  List<String>? listOfCategories;

  @override
  Widget build(BuildContext context) {
    IconData iconData = Platform.isAndroid
        ? Icons.keyboard_arrow_down
        : CupertinoIcons.arrow_down;

    getCategoryList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Add your transaction details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 34,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
                valueListenable: selectedDate,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      TextButton.icon(
                          onPressed: () async {
                            final _selectedDateTemp = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now()
                                    .subtract(const Duration(days: 30)),
                                lastDate: DateTime.now());

                            if (_selectedDateTemp == null) {
                              return;
                            } else {
                              print('date is $_selectedDateTemp');
                              selectedDate.value = _selectedDateTemp.toString();
                            }
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: Text(selectedDate.value.isEmpty
                              ? 'Select date'
                              : selectedDate.value.toString())),
                    ],
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
                valueListenable: radioButtonListener,
                builder: (context, value, child) {
                  return Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: CategoryType.income,
                              groupValue: value,
                              onChanged: (newValue) {
                                if (newValue == null) {
                                  return;
                                }
                                radioButtonListener.value = newValue;
                                radioButtonListener.notifyListeners();
                              }),
                          const Text('Income')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: CategoryType.expense,
                              groupValue: value,
                              onChanged: (newValue) {
                                if (newValue == null) {
                                  return;
                                }
                                radioButtonListener.value = newValue;
                                radioButtonListener.notifyListeners();
                              }),
                          const Text(
                            'Expense',
                          )
                        ],
                      ),
                    ],
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            DropdownButtonFormField(
              icon: Icon(iconData),
              hint: const Text('Select Category'),
              value: selectedOption,
              onChanged: (newValue) {
                print(
                    'value is ${CategoryDb().listOfExpenseCategoryModel.value}');
                if (newValue == null) {
                  return;
                }
                selectedOption = newValue;
              },
              items: listOfCategories!
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ]),
        ),
      ),
    );
  }

  Future getCategoryList() async {
    var model = await CategoryDb().getCategories();
    // var data = CategoryDb()
    //     .getCategories()
    //     .map<DropdownMenuItem<String>>((CategoryModel value) {
    //   return DropdownMenuItem<String>(
    //     value: value.name,
    //     child: Text(value.name),
    //   );
    // }).toList();

    for (var person in model) {
      listOfCategories?.add(person.name);
      String name = person.name;
      print(' model name is $name');
    }

    // data.forEach((person) {
    //   String name = person.value!;
    //   print(' name is $name');
    // });
  }
}
