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
  double _monthlyRepayment = 0.0;
  double _totalRepayment = 0.0;

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
    double monthlyRate =
        double.parse(_mortgageAmount.text) * (monthlyTop / monthlyBottom);
    double totalPayment = monthlyRate * months;

    setState(() {
      _monthlyRepayment = monthlyRate;
      _totalRepayment = totalPayment;
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
                        controller: _mortgageAmount,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Mortgage Amount',
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
                  child: Text("Monthly Payments: £${_monthlyRepayment.round()}",
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
