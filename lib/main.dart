import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stock_scan_parser/constants/url_constants.dart';
import 'package:stock_scan_parser/models/stock_market_scan.dart';
import 'package:stock_scan_parser/screens/details_screen.dart';
import 'package:stock_scan_parser/utils/get_color.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});
  final Dio _dio = Dio();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: _dio.get(
            dataUrl,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
            if (snapshot.hasData) {
              List<StockMarketScan> stockMarketScans = [];
              try {
                stockMarketScans = ((snapshot.data?.data) as List<dynamic>)
                    .map((e) => StockMarketScan.fromJson(e))
                    .toList();
              } catch (e) {
                return const Text('Something went wrong!');
              }
              return Container(
                color: Colors.black,
                margin: const EdgeInsets.only(top: 40),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  shrinkWrap: true,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 2, color: Colors.white),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                              stockMarketScan: stockMarketScans[index]),
                        ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stockMarketScans[index].name ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Text(
                            stockMarketScans[index].tag ?? '',
                            style: TextStyle(
                              color: getColor(
                                  stockMarketScans[index].color ?? 'red'),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: stockMarketScans.length,
                ),
              );
            }
            return const Text('Something went wrong!');
          },
        ),
      ),
    );
  }
}
