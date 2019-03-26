import 'package:flutter/material.dart';
import 'package:mortgage_calc/ui/max_loan.dart';
import 'package:mortgage_calc/ui/monthly_cost.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Router(),
    );
  }
}

class Router extends StatefulWidget {
  @override
  _RouterState createState() => _RouterState();
}

class _RouterState extends State<Router> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mortgage Calculator'),
        backgroundColor: Colors.deepPurple[400],
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(text: 'Monthly Cost'),
            Tab(text: 'Maximum Loan')
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          Monthly(),
          MaxLoan(),
        ],
      ),
    );
  }
}
