import 'package:flutter/material.dart';
import 'package:food_order_app/viewmodels/category_viewmodel.dart';
import 'package:food_order_app/viewmodels/items_viewmodel.dart';
import 'package:food_order_app/viewmodels/menu_viewmodel.dart';
import 'package:food_order_app/viewmodels/modifier_viewmodel.dart';
import 'package:food_order_app/views/menu_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MenuViewmodel()),
        ChangeNotifierProvider(create: (_) => CategoryViewmodel()),
        ChangeNotifierProvider(create: (_) => ModifierViewmodel()),
        ChangeNotifierProvider(
            create: (context) => ItemsViewmodel(
                Provider.of<ModifierViewmodel>(context, listen: false))),
      ],
      child: const MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: MenuScreen(),
      ),
    );
  }
}
