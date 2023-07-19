import 'package:flutter/material.dart';
import 'package:money_management/db/category_db.dart';
import 'package:money_management/models/category_model.dart';

class AddTrasactionScreen extends StatefulWidget {
  static const routeName = 'add-transaction-screen';

  const AddTrasactionScreen({super.key});

  @override
  State<AddTrasactionScreen> createState() => _AddTrasactionScreenState();
}

class _AddTrasactionScreenState extends State<AddTrasactionScreen> {
  @override
  void initState() {
    super.initState();
  }

  //final singleton = CategoryDb.instance;
  DateTime? _selectedDate;
  CategoryType? _selectedCategory;
  CategoryModel? _selectedCategoryModel;

  ValueNotifier<CategoryType> radioButtonListener =
      ValueNotifier(CategoryType.income);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                height: 15,
              ),
              TextButton.icon(
                  onPressed: () async {
                    final _selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now());

                    if (_selectedDateTemp == null) {
                      return;
                    } else {
                      print('date is $_selectedDateTemp');
                      setState(() {
                        _selectedDate = _selectedDateTemp;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_selectedDate == null
                      ? 'Select datee'
                      : _selectedDate!.toString())),
              ValueListenableBuilder(
                  valueListenable: radioButtonListener,
                  builder: (context, value, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RadioListTile(
                            title: Text('${CategoryType.income}'),
                            value: '1',
                            groupValue: radioButtonListener.value,
                            onChanged: (changedValues) {
                              if (changedValues != null) {
                                //   radioButtonListener.value = changedValues;
                              } else {
                                return;
                              }
                            }),
                        RadioListTile(
                            title: Text('${CategoryType.expense}'),
                            value: '2',
                            groupValue: radioButtonListener.value,
                            onChanged: (changedValues) {
                              if (changedValues != null) {
                                //   radioButtonListener.value = changedValues;
                              } else {
                                return;
                              }
                            }),

                        // Row(
                        //   children: [
                        //     Radio(
                        //         value: CategoryType.income,
                        //         groupValue: CategoryType.income,
                        //         onChanged: (newValue) {}),
                        //     const Text('Income')
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Radio(
                        //         value: CategoryType.expense,
                        //         groupValue: CategoryType.income,
                        //         onChanged: (newValue) {}),
                        //     const Text('Expense')
                        //   ],
                        // ),
                      ],
                    );
                  }),
              DropdownButton(
                  hint: const Text('Select Category'),
                  items: CategoryDb().listOfIncomeCategoryModel.value.map((e) {
                    print('drop downs are ${e.id}');
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                    );
                  }).toList(),
                  onChanged: (newValue) {}),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
