import 'package:crypto_tracker_flutter/constants.dart';
import 'package:crypto_tracker_flutter/helper/methods.dart';
import 'package:crypto_tracker_flutter/widgets/link_button.dart';
import 'package:crypto_tracker_flutter/widgets/rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/chart_data.dart';
import '../model/coin_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CoinDetail extends StatelessWidget {
  CoinDetail({required this.coin, required this.index});
  List<CoinModell> coin;
  int index;
  Methods methods = Methods();

  @override
  Widget build(BuildContext context) {
    List<ChartData> data = [
      ChartData(coin[index].priceChange1H, 1),
      ChartData(coin[index].priceChange1W, 7),
      ChartData(coin[index].priceChange1D, 24),
    ];
    List<double> periods = [
      coin[index].priceChange1H,
      coin[index].priceChange1D,
      coin[index].priceChange1W,
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text(coin[index].name + ' ' + '(${coin[index].symbol})'),
        ),
        body: Column(children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            '\$' + coin[index].price.toStringAsFixed(2),
            style: const TextStyle(fontSize: 26),
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(16),
                      width: double.infinity,
                      height: 96.0,
                      child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          primaryXAxis: CategoryAxis(isVisible: false),
                          primaryYAxis: CategoryAxis(isVisible: false),
                          legend: Legend(isVisible: false),
                          tooltipBehavior: TooltipBehavior(enable: false),
                          series: <ChartSeries<ChartData, String>>[
                            LineSeries<ChartData, String>(
                              dataSource: data,
                              xValueMapper: (ChartData sales, _) =>
                                  sales.year.toString(),
                              yValueMapper: (ChartData sales, _) => sales.value,
                            )
                          ]))),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(30, 41, 61, 1),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Image.network(
                        coin[index].icon,
                        width: 40,
                        height: 40,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(coin[index].name + ' (${coin[index].symbol})',
                          style: Constants.coinDetailTitle),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text('Rate', style: Constants.coinDetailTitle),
                              Text(
                                  'BTC: ' +
                                      coin[index].priceBtc.toStringAsFixed(5),
                                  style: const TextStyle(fontSize: 17)),
                              Text(
                                  'USD: ' +
                                      coin[index].price.toStringAsFixed(2),
                                  style: const TextStyle(fontSize: 17)),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Market', style: Constants.coinDetailTitle),
                            Text(
                                'Cap : ' +
                                    methods.generator(coin[index].marketCap),
                                style: const TextStyle(fontSize: 17)),
                            Text(
                                'Volume: ' +
                                    methods.generator(
                                      coin[index].volume,
                                    ),
                                style: const TextStyle(fontSize: 17)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('% Change',
                                  style: Constants.coinDetailTitle),
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: periods.length,
                                  itemBuilder: (context, index) {
                                    return Center(
                                      child: RichTextt(
                                          text: Constants.times[index],
                                          textStyle2: TextStyle(
                                              color: periods[index] < 0
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontSize: 17),
                                          text2: periods[index].toString(),
                                          textStyle1: Constants.coinDetailText),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text('Supply', style: Constants.coinDetailTitle),
                              Text(
                                  'Available : ' +
                                      methods.generator(
                                          coin[index].availableSupply),
                                  style: Constants.coinDetailText),
                              Text(
                                  'Total : ' +
                                      methods
                                          .generator(coin[index].totalSupply),
                                  style: Constants.coinDetailText),
                              Text('Rank : ' + coin[index].rank.toString(),
                                  style: Constants.coinDetailText),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Community',
                          style: Constants.coinDetailTitle,
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 1,
                          endIndent: 16,
                        ),
                        Row(
                          children: [
                            LinkButton(
                              text: 'Website',
                              onPress: () => coin[index].websiteUrl == null ?
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Website Not Found'))) :
                                 launch(coin[index].websiteUrl)),
                            LinkButton(
                                text: 'Twitter',
                                onPress: () => coin[index].twitterUrl == null ?
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Twitter Url Not Found'))):
                                 launch(coin[index].twitterUrl )),
                          ],
                        ),
                        Row(
                          children: [
                            LinkButton(
                              text: 'Explorer',
                              onPress: () {
                                launch(coin[index].exp![1]);
                              },
                            ),
                            LinkButton(
                              text: 'Contract Adress',
                              onPress: () {
                                Clipboard.setData(ClipboardData(
                                    text: coin[index]
                                        .contractAddress
                                        .toString()));
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Contract Adress Copied')));
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
