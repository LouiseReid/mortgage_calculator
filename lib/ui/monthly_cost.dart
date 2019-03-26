import 'package:flutter/material.dart';
import 'dart:math';

class Monthly extends StatefulWidget {
  @override
  _MonthlyState createState() => _MonthlyState();
}

class _MonthlyState extends State<Monthly> {
  var _mortgageAmount = new TextEditingController();
  var _period = new TextEditingController();
  var _interestRate = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _mortgageAmount.addListener(_calculateMortgage);
    _period.addListener(_calculateMortgage);
    _interestRate.addListener(_calculateMortgage);
  }

  void _calculateMortgage() {
    double interestRate = (double.parse(_interestRate.text) / 100) / 12;
    int months = int.parse(_period.text) * 12;
    double monthlyTop = interestRate * pow((1 + interestRate), months);
    double monthlyBottom = pow(1 + interestRate, months) - 1;
    double monthlyRate = double.parse(_mortgageAmount.text) * (monthlyTop/monthlyBottom);
    print(monthlyRate);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 10.0),
                    child: TextField(
                        controller: _mortgageAmount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Monthly Payments',
                          prefix: Text('£'),
                        ))),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              controller: _interestRate,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Interest Rate',
                                  suffixText: '%',
                                  suffixStyle: TextStyle(fontSize: 13.0))),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                              controller: _period,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Period',
                                  suffixText: 'years',
                                  suffixStyle: TextStyle(fontSize: 13.0))),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container()
      ],
    );
  }
}
