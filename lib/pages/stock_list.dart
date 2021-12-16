import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock/models/api_response.dart';
import 'package:stock/models/stock_list.dart';
import 'package:stock/pages/stock_details.dart';
import 'package:stock/services/stock_service.dart';

class Stocks extends StatefulWidget {
  Stocks({this.stockData});
  final stockData;

  @override
  _StocksState createState() => _StocksState();
}

class _StocksState extends State<Stocks> {
  StockService stocks = StockService();
  String ticker;
  String tickerName;
  String currencyName;
  int length;
  int index;

  @override
  void initState() {
    updateUIForList(widget.stockData);
    super.initState();
  }

  void updateUIForList(dynamic tickerData) {
    setState(() {
      if (tickerData == null) {
        ticker = 'No value';
        tickerName = 'No value';
        currencyName = 'Us';
        length = 0;
        return;
      }
      var tick = tickerData['results'][0]['ticker'];
      ticker = tick;

      var name = tickerData['results'][0]['name'];
      tickerName = name;

      var currency = tickerData['results'][0]['currency_name'];
      currencyName = currency;

      var count = tickerData['count'];
      length = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (_) {
          return ListView.separated(
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  5,
                  10,
                  5,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ListTile(
                    title: Text(
                      tickerName,
                    ),
                    subtitle: Text(
                      ticker,
                    ),
                    leading: Text(
                      currencyName.toUpperCase(),
                      
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return StockDetail(
                            ticker: ticker,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) {
              return SizedBox(
                height: 0,
              );
            },
            itemCount: length,
          );
        },
      ),
    );
  }
}
