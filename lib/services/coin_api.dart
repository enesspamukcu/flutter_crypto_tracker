import 'package:crypto_tracker_flutter/model/coin_model.dart';
import 'package:crypto_tracker_flutter/screens/price_screen.dart';
import 'package:dio/dio.dart';

class CoinApi{
  PriceScreen priceScreen = PriceScreen();
  String coinApiURL='https://api.coinstats.app/public/v1/coins?skip=0&limit=50&currency=USD';
   List<CoinModell> myCoinList = [];
  List apiListCoin=[];
  Future <List<CoinModell>> getCoin()async{
    var result = await Dio().get(coinApiURL);
    apiListCoin = result.data['coins'];
    if (apiListCoin is List) {
      myCoinList = apiListCoin.map((e) => CoinModell.fromJson(e)).toList();
    }else{
      return  [];
    }
    return myCoinList;
  }
}