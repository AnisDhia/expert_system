import 'package:expert_system/engine/clauses/clause.dart';
import 'package:expert_system/engine/clauses/regex_clause.dart';

import '../types/intersection.dart';

class EqualsClause extends Clause {

  EqualsClause({
    required String variable,
    required String value,
  }) : super(variable: variable, value: value) {
    condition = "=";
  }

  @override
  IntersectionType intersect(Clause rhs) {
    if (rhs is EqualsClause) {
      if (value == rhs.getValue()) {
        return IntersectionType.inclusive;
      } else {
        return IntersectionType.mutuallyExclusive;
      }
    } else if (rhs is RegexClause) {
      var rhs2 = rhs;
      return rhs2.intersect(this);
    } 
    return IntersectionType.unknown;
    //else if (rhs is NegationClause) {
    //   return rhs.intersect(this);
    // }

    // var v1 = value;
    // var v2 = rhs.getValue();

    // var a = 0.0;
    // var b = 0.0;

    // var isNumeric = true;
    // try {
    //   a = double.parse(v1);
    //   b = double.parse(v2);
    // } catch (e) {
    //   isNumeric = false;
    // }

    // if (isNumeric) {
    //   if (rhs is LessClause) {
    //     if (a >= b) {
    //       return IntersectionType.mutuallyExclusive;
    //     } else {
    //       return IntersectionType.inclusive;
    //     }
    //   } else if (rhs is LEClause) {
    //     if (a > b) {
    //       return IntersectionType.mutuallyExclusive;
    //     } else {
    //       return IntersectionType.inclusive;
    //     }
    //   } else if (rhs is GreaterClause) {
    //     if (a <= b) {
    //       return IntersectionType.mutuallyExclusive;
    //     } else {
    //       return IntersectionType.inclusive;
    //     }
    //   } else if (rhs is GEClause) {
    //     if (a < b) {
    //       return IntersectionType.mutuallyExclusive;
    //     } else {
    //       return IntersectionType.inclusive;
    //     }
    //   } else {
    //     return IntersectionType.unknown;
    //   }
    // } else {
    //   return IntersectionType.unknown;
    // }
  }
}