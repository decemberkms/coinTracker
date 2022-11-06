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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateBCT();
  }

  CoinData coinCurrentData = CoinData();

  String selectedCurrency = 'USD';
  String? btcRate;

  void updateBCT() async {
    CoinData coinCurrentData = CoinData();
    var mythings = await coinCurrentData.getcoinData();
    setState(() {
      btcRate = mythings['rate'].toInt().toString();
    });
  }

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
      onChanged: (value) async {
        var mythings = await coinCurrentData.getcoinData();
        setState(() {
          selectedCurrency = value.toString();

          btcRate = mythings['rate'].toInt().toString();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (value) async {
        var mythings = await coinCurrentData.getcoinData();
        setState(() {
          btcRate = mythings['rate'].toInt().toString();
        });
        print(value);
      },
      children: [for (var currency in currenciesList) Text(currency)],
    );
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
                  '1 BTC = $btcRate',
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
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
