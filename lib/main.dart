import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Cost Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {
  String result = '';
  final currencies = ['Select Currency', 'Dollars', 'Naira'];
  String currency = "Select Currency";
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final formDistance = 5.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: formDistance, bottom: formDistance),
              child: TextField(
                decoration:
                InputDecoration(labelText: "Distance", hintText: 'e.g 123'),
                keyboardType: TextInputType.number,
                controller: distanceController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: formDistance, bottom: formDistance),
              child: TextField(
                decoration: InputDecoration(
                    labelText: "Distance per Unit", hintText: 'e.g 17'),
                keyboardType: TextInputType.number,
                controller: avgController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: formDistance, bottom: formDistance),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          labelText: "Price", hintText: 'e.g 1.65'),
                      keyboardType: TextInputType.number,
                      controller: priceController,
                    ),
                  ),
                  Container(width: formDistance * 5,),
                  Expanded(
                    child: DropdownButton<String>(
                      items: currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: currency,
                      onChanged: (String value) {
                        _onDropDownItemSelected(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(children: <Widget>[
              Expanded(child: RaisedButton(
                color: Theme
                    .of(context)
                    .primaryColorDark,
                textColor: Theme
                    .of(context)
                    .primaryColorLight,
                child: Text(
                  "Submit",
                  textScaleFactor: 1.5,
                ),
                onPressed: () {
                  setState(() {
                    result = _calculate();
                  });
                },
              ),),
              Expanded(child: RaisedButton(
                color: Theme
                    .of(context)
                    .buttonColor,
                textColor: Theme
                    .of(context)
                    .primaryColorDark,
                child: Text(
                  "Reset",
                  textScaleFactor: 1.5,
                ),
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
              ),),
            ],),
            Text('Hello ' + result + '!')
          ],
        ),
      ),
    );
  }

  _onDropDownItemSelected(String value) {
    setState(() {
      this.currency = value;
    });
  }

  String _calculate() {
    double _distance = double.parse(distanceController.text);
    double _fuelcost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _distance / _consumption * _fuelcost;
    return 'The total cost of your trip is' +
        _totalCost.toStringAsFixed(2) +
        ' ' +
        currency;
  }

  void _reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';
    setState(() {
      result = '';
    });
  }
}
