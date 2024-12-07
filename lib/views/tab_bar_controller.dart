import 'package:flutter/material.dart';

class TabBarController extends StatelessWidget {
  const TabBarController({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: TabBar(
          isScrollable: true,
          indicatorColor: Color(0xff1cae81),
          labelColor: Color(0xff1cae81),
          tabs: [
            Tab(
              child: Text(
                "Ingredients",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Tab(
              child: Text("Nutritional", style: TextStyle(fontSize: 16)),
            ),
            Tab(
              child: Text("Instructions", style: TextStyle(fontSize: 16)),
            ),
            Tab(
              child: Text("Allergies", style: TextStyle(fontSize: 16)),
            ),
          ]),
    );
  }
}
