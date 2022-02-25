import 'package:crypto_tracker_flutter/screens/coin_detail.dart';
import 'package:crypto_tracker_flutter/model/coin_model.dart';
import 'package:crypto_tracker_flutter/services/coin_api.dart';
import 'package:crypto_tracker_flutter/widgets/custom_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/chart_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinApi coinApi = CoinApi();
  List<ChartData> data = [];
  late List<CoinModell> coinData;

  Future refresh() async {
    setState(() {
      coinApi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Crypto Tracker'),
          actions: [
            IconButton(
                onPressed: () => showSearchPage(), icon: const Icon(Icons.search)),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: coinApi.getCoin(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => refresh(),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: coinApi.myCoinList.length,
                          itemBuilder: (context, index) {
                            if (snapshot.hasData) {
                              coinData = snapshot.data;
                              data = [
                                ChartData(coinData[index].priceChange1H, 1),
                                ChartData(coinData[index].priceChange1W, 7),
                                ChartData(coinData[index].priceChange1D, 24),
                              ];
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CoinDetail(
                                              coin: coinData,
                                              index: index,
                                            ))),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 16.0),
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(30, 35, 61, 1),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              coinData[index].icon,
                                              width: 50,
                                              height: 50,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(coinData[index].symbol),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text('\$' +
                                                coinData[index]
                                                    .price
                                                    .toStringAsFixed(2)),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Container(
                                              width: double.infinity,
                                              height: 96.0,
                                              child: SfCartesianChart(
                                                  plotAreaBorderWidth: 0,
                                                  primaryXAxis: CategoryAxis(
                                                      isVisible: false),
                                                  primaryYAxis: CategoryAxis(
                                                      isVisible: false),
                                                  legend:
                                                      Legend(isVisible: false),
                                                  tooltipBehavior:
                                                      TooltipBehavior(
                                                          enable: false),
                                                  series: <
                                                      ChartSeries<ChartData,
                                                          String>>[
                                                    LineSeries<ChartData,
                                                        String>(
                                                      dataSource: data,
                                                      xValueMapper: (ChartData
                                                                  sales,
                                                              _) =>
                                                          sales.year.toString(),
                                                      yValueMapper:
                                                          (ChartData sales,
                                                                  _) =>
                                                              sales.value,
                                                    )
                                                  ]))),
                                      Container(
                                        margin: const EdgeInsets.only(right: 8.0),
                                        padding: const EdgeInsets.only(top: 10),
                                        width: 72,
                                        height: 36,
                                        decoration: BoxDecoration(
                                            color:
                                                coinData[index].priceChange1D <
                                                        0
                                                    ? Colors.red
                                                    : Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text(
                                          coinData[index]
                                              .priceChange1D
                                              .toString(),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text(snapshot.error.toString()),
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                    ),
                  );
                }),
          ],
        ));
  }

  showSearchPage() {
    showSearch(context: context, delegate: CustomSearchDelegate(coinData));
  }
}
