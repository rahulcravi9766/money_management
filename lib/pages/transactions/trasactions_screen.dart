import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(left: 5, right: 5),
            child: Card(
              elevation: 1,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Text(
                    '15th\nMay',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                title: Text('5000'),
                subtitle: Text('Rent amount paid'),
                trailing: Text('Expense'),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 1,
          );
        },
        itemCount: 15);
  }
}
