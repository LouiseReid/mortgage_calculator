import 'dart:math';

import 'package:flutter/material.dart';

class MaxLoan extends StatefulWidget {
  @override
  _MaxLoanState createState() => _MaxLoanState();
}

class _MaxLoanState extends State<MaxLoan> {
  var _monthlyPayments = new TextEditingController();
  var _period = new TextEditingController();
  var _interestRate = new TextEditingController();
    double _borrowAmount = 0.0;
  double _totalRepayment = 0.0;

   @override
  void initState() {
    super.initState();
    _monthlyPayments.addListener(_calculateMortgage);
    _period.addListener(_calculateMortgage);
    _interestRate.addListener(_calculateMortgage);
  }

  void _calculateMortgage() {
    double interestRate = (double.parse(_interestRate.text) / 100) / 12;
    int months = int.parse(_period.text) * 12;
    double monthlyTop = interestRate * pow((1 + interestRate), months);
    double monthlyBottom = pow(1 + interestRate, months) - 1;
    double borrowAmount =
        double.parse(_monthlyPayments.text) / (monthlyTop / monthlyBottom);
    double totalRepayment = double.parse(_monthlyPayments.text) * months;

    setState(() {
      _borrowAmount = borrowAmount;
      _totalRepayment = totalRepayment;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 0.0),
            child: Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 10.0),
                    child: TextField(
                        controller: _monthlyPayments,
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
        Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Container(
            margin: const EdgeInsets.only(left: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Total Cost of Mortgage: £${_totalRepayment.round()}",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w100),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text("You Could Borrow: £${_borrowAmount.round()}",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Container(
            child: Icon(Icons.home, color: Colors.deepPurple[400], size: 80.0),
          ),
        )
      ],
    );
  }
}
