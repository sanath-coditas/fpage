import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stock_scan_parser/models/stock_market_scan.dart';
import 'package:stock_scan_parser/screens/inner_values_screen.dart';

class VariablesText extends StatelessWidget {
  const VariablesText({super.key, this.criteria});
  final Criteria? criteria;
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: _getCriteriaText(criteria, context)));
  }

  List<TextSpan> _getCriteriaText(Criteria? criteria, BuildContext context) {
    List<TextSpan> textSpans = [];
    String criteriaText = criteria?.text ?? '';
    final List<String?> variableKeys = RegExp(r'\$\d+')
        .allMatches(criteria?.text ?? '')
        .toList()
        .map((e) => e.group(0))
        .toList();

    for (String? s in criteriaText.split(' ')) {
      if (variableKeys.contains(s)) {
        textSpans.add(_getValue(criteria?.variablesMap?[s], context));
      } else {
        textSpans.add(
          TextSpan(
            text: '$s ',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }
    }
    return textSpans;
  }

  TextSpan _getValue(
    Variable? variable,
    BuildContext context,
  ) {
    if (variable?.type == 'indicator') {
      return TextSpan(
        text: ('(${variable?.indicator?.defaultValue.toString() ?? ''}) '),
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 30,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => InnerValuesScreen(
                  variable: variable,
                ),
              ),
            );
          },
      );
    }
    if (variable?.type == 'value') {
      return TextSpan(
        text: (variable?.values?.values?.isNotEmpty ?? false)
            ? ('(${variable?.values?.values?.first.toString() ?? ''}) ')
            : '',
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 30,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => InnerValuesScreen(
                  variable: variable,
                ),
              ),
            );
          },
      );
    }
    return const TextSpan(
      text: '',
    );
  }
}