import 'package:flutter/material.dart';
import 'package:money_management/pages/transactions/add_new_transactions.dart';

import 'models/category_model.dart';
import 'pages/home screen/home_sreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightBlue),
      home: HomeScreen(),
      routes: {
        AddNewTransactionsScreen.routeName: (context) =>
            AddNewTransactionsScreen()
      },
    );
  }
}
