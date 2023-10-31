import 'package:flutter/material.dart';
import 'package:stock_scan_parser/models/stock_market_scan.dart';

class InnerValuesScreen extends StatelessWidget {
  const InnerValuesScreen({
    super.key,
    this.variable,
  });
  final Variable? variable;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (variable?.type == 'value')
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ColoredBox(
                    color: Colors.black,
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) => Text(
                        (variable?.values?.values?[index] ?? '').toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      separatorBuilder: (context, index) => Container(
                        height: 1,
                        color: Colors.white,
                      ),
                      itemCount: variable?.values?.values?.length ?? 0,
                    ),
                  ),
                ),
              ),
            if (variable?.type == 'indicator')
              const ColoredBox(
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Set Parameters',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ColoredBox(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Text('Period'),
                            SizedBox(
                              width: 30,
                            ),
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 20,
                                  horizontal: 10,
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
