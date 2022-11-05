import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coin_tracker/coin_data.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> androidPicker() {
    List<DropdownMenuItem<String>> dropdwonItems = [];

    for (int myEle = 0; myEle < currenciesList.length; myEle++) {
      String currency = currenciesList[myEle];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdwonItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdwonItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value.toString();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (value) {
        print(value);
      },
      children: [for (var currency in currenciesList) Text(currency)],
    );
  }

  Widget? pickPicker() {
    if (Platform.isAndroid) {
      return androidPicker();
    } else if (Platform.isIOS) {
      return iosPicker();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ? USD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: pickPicker(),
          ),
        ],
      ),
    );
  }
}
