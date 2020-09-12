import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'network.dart';

double finalCurrency = 0.0;
double finalCurrency1 = 0.0;
double finalCurrency2 = 0.0;
String currency = 'USD';
String url =
    'https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=D1DE29E2-1A9B-4E83-A4E0-C9E9E080D4C3';
String url1 =
    'https://rest.coinapi.io/v1/exchangerate/ETH/$currency?apikey=D1DE29E2-1A9B-4E83-A4E0-C9E9E080D4C3';
String url2 =
    'https://rest.coinapi.io/v1/exchangerate/LTC/$currency?apikey=D1DE29E2-1A9B-4E83-A4E0-C9E9E080D4C3';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  DropdownButton<String> getDropDownItem() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton(
      items: dropDownItems,
      value: currency,
      onChanged: ((value) {
        setState(() {
          currency = value;
          getData(
              'https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=D1DE29E2-1A9B-4E83-A4E0-C9E9E080D4C3');
          getData1(
              'https://rest.coinapi.io/v1/exchangerate/ETH/$currency?apikey=D1DE29E2-1A9B-4E83-A4E0-C9E9E080D4C3');
          getData2(
              'https://rest.coinapi.io/v1/exchangerate/LTC/$currency?apikey=D1DE29E2-1A9B-4E83-A4E0-C9E9E080D4C3');
        });
      }),
    );
  }

  CupertinoPicker getPickerItem() {
    List<Text> pickerItem = [];
    for (String i in currenciesList) {
      pickerItem.add(Text(i));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItem,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(url);
    getData1(url1);
    getData2(url2);
  }

  void updateCV(dynamic cV) {
    print(cV);
    setState(() {
      finalCurrency = cV['rate'];
    });
    print(finalCurrency);
  }

  void updateCV1(dynamic cV) {
    print(cV);
    setState(() {
      finalCurrency1 = cV['rate'];
    });
    print(finalCurrency1);
  }

  void updateCV2(dynamic cV) {
    print(cV);
    setState(() {
      finalCurrency2 = cV['rate'];
    });
    print(finalCurrency2);
  }

  void getData(String url) async {
    Network network = Network(url: url);
    var currencyValue = await network.getData();
    updateCV(currencyValue);
  }

  void getData1(String url) async {
    Network network = Network(url: url);
    var currencyValue = await network.getData();
    updateCV1(currencyValue);
  }

  void getData2(String url) async {
    Network network = Network(url: url);
    var currencyValue = await network.getData();
    updateCV2(currencyValue);
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
            padding: EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $finalCurrency $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = $finalCurrency1 $currency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = $finalCurrency2 $currency',
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
            child: Platform.isIOS ? getPickerItem() : getDropDownItem(),
          )
        ],
      ),
    );
  }
}
