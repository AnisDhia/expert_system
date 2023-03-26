import 'dart:core';

import '../types/intersection.dart';
import 'clause.dart';

class RegexMatchClause extends Clause {
  RegExp? pattern;

  RegexMatchClause(String variable, String value)
      : super(variable: variable, value: value) {
    condition = "match";
  }

  @override
  IntersectionType intersect(Clause rhs) {
    if (rhs is RegexMatchClause) {
      RegexMatchClause rhs2 = rhs;
      if (value == rhs2.getValue()) {
        return IntersectionType.inclusive;
      }
      if (match(rhs2.getValue())) {
        return IntersectionType.inclusive;
      } else if (rhs2.match(value)) {
        return IntersectionType.inclusive;
      }
      return IntersectionType.mutuallyExclusive;
    } 
    // else if (rhs is EqualsClause) {
    //   if (match(rhs.getValue())) {
    //     return IntersectionType.inclusive;
    //   } else {
    //     return IntersectionType.mutuallyExclusive;
    //   }
    // } else if (rhs is NegationClause) {
    //   return rhs.intersect(this);
    // }
    return IntersectionType.unknown;
  }

  bool match(String content) {
    pattern ??= RegExp(value);
    RegExpMatch? m = pattern?.firstMatch(content);
    if (m != null) {
      return true;
    } else {
      return false;
    }
  }
}
