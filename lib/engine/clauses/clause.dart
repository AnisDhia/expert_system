import 'package:expert_system/engine/clauses/equals_clause.dart';
import 'package:expert_system/engine/clauses/regex_clause.dart';
import 'package:expert_system/engine/types/intersection.dart';

class Clause {
  late String variable = "";
  String value = "";
  String condition = "=";

  Clause({required this.variable, required this.value, this.condition = "="});

  String getVariable() {
    return variable;
  }

  void setVariable(String variable) {
    variable = variable;
  }

  String getValue() {
    return value;
  }

  void setValue(String value) {
    value = value;
  }

  String getCondition() {
    return condition;
  }

  void setCondition(String condition) {
    condition = condition;
  }

  IntersectionType matchClause(Clause rhs) {
    if (variable != rhs.getVariable()) {
      return IntersectionType.unknown;
    }
    return intersect(rhs);
  }

  IntersectionType intersect(Clause rhs) {
    throw Exception('intersect() not implemented');
  }

  @override
  String toString() {
    return "$variable $condition $value";
  }

  Clause clone() {
    return Clause(variable: variable, value: value, condition: condition);
  }

  Map<String, dynamic> toJSON() => {
        'variable': variable,
        'value': value,
        'condition': condition,
      };

  factory Clause.fromJSON(Map<String, dynamic> json) {
    if (json['condition'] == "match") {
      return RegexClause(json['variable'], json['value']);
    } else if (json['condition'] == "=") {
      return EqualsClause(variable: json['variable'], value: json['value']);
    } else {
      return Clause(
        variable: json['variable'],
        value: json['value'],
        condition: json['condition'],
      );
    }
  }
}
