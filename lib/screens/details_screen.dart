import 'package:flutter/material.dart';
import 'package:stock_scan_parser/models/stock_market_scan.dart';
import 'package:stock_scan_parser/screens/variables_text.dart';
import 'package:stock_scan_parser/utils/get_color.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.stockMarketScan});
  final StockMarketScan stockMarketScan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: ColoredBox(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ColoredBox(
                    color: Colors.lightBlueAccent.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: double.infinity,
                            height: 1,
                          ),
                          Text(
                            stockMarketScan.name ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            stockMarketScan.tag ?? '',
                            style: TextStyle(
                              color: getColor(stockMarketScan.color ?? 'red'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Text('and'),
                    itemCount: stockMarketScan.criterias?.length ?? 0,
                    itemBuilder: (context, index) => VariablesText(
                        criteria: stockMarketScan.criterias?[index]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
