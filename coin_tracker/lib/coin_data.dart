import 'package:coin_tracker/networking.dart';

const baseUrl =
    'https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=23AADA7F-48AE-44DE-A4CF-0ED759B142EE';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<dynamic> getcoinData() async {
    NetworkHelper networkHelper = NetworkHelper(baseUrl);

    var coinData = await networkHelper.getData();
    // print('Coin data inside CoinData function.');
    // print(coinData);
    return coinData;
  }
}
