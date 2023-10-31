class StockMarketScan {
  final num? id;
  final String? name;
  final String? tag;
  final String? color;
  final List<Criteria>? criterias;

  StockMarketScan({
    this.id,
    this.name,
    this.tag,
    this.color,
    this.criterias,
  });

  factory StockMarketScan.fromJson(Map<String, dynamic> json) {
    return StockMarketScan(
      name: json['name'],
      id: json['id'],
      tag: json['tag'],
      color: json['color'],
      criterias: json['criteria'] != null
          ? (json['criteria'] as List<dynamic>)
              .map((e) => Criteria.fromJson(e))
              .toList()
          : [],
    );
  }
}

class Criteria {
  final String? type;
  final String? text;
  final Map<String, Variable>? variablesMap;

  Criteria({
    this.text,
    this.type,
    this.variablesMap,
  });

  factory Criteria.fromJson(Map<String, dynamic> json) {
    Map<String, Variable> variablesList = {};
    final List<String> variableKeys = json['text'] != null
        ? RegExp(r'\$\d+')
            .allMatches(json['text'])
            .toList()
            .map((e) => e.group(0) ?? '')
            .toList()
        : [];

    for (String k in variableKeys) {
      if (json['variable'][k]['type'] == 'indicator') {
        variablesList[k] =
            Variable.indicatorVariableFromJson(json['variable'][k]);
      }
      if (json['variable'][k]['type'] == 'value') {
        variablesList[k] = Variable.valuesVariableFromJson(json['variable'][k]);
      }
    }

    return Criteria(
      text: json['text'],
      type: json['type'],
      variablesMap: variablesList,
    );
  }
}

class Variable {
  final Values? values;
  final Indicator? indicator;
  final String? type;

  Variable({this.indicator, this.values, this.type});

  factory Variable.valuesVariableFromJson(Map<String, dynamic> json) {
    return Variable(
      type: 'value',
      values: Values.fromJson(json),
    );
  }

  factory Variable.indicatorVariableFromJson(Map<String, dynamic> json) {
    return Variable(
      type: 'indicator',
      indicator: Indicator.fromJson(json),
    );
  }
}

class Values {
  final List<dynamic>? values;

  Values({
    this.values,
  });
  factory Values.fromJson(Map<String, dynamic> json) {
    return Values(values: json['values']);
  }
}

class Indicator {
  final String? studyType;
  final String? parameterName;
  final num? minValue;
  final num? maxValue;
  final num? defaultValue;
  Indicator({
    this.studyType,
    this.parameterName,
    this.minValue,
    this.maxValue,
    this.defaultValue,
  });

  factory Indicator.fromJson(Map<String, dynamic> map) {
    return Indicator(
      studyType: map['study_type'] != null ? map['study_type'] as String : null,
      parameterName:
          map['parameter_name'] != null ? map['parameter_name'] as String : null,
      minValue: map['min_value'] != null ? map['min_value'] as num : null,
      maxValue: map['max_value'] != null ? map['max_value'] as num : null,
      defaultValue:
          map['default_value'] != null ? map['default_value'] as num : null,
    );
  }
}
