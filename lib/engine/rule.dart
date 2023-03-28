import 'package:expert_system/engine/clauses/clause.dart';
import 'package:expert_system/engine/knowledge_base.dart';

class Rule {
  List<Clause> antecedents = [];
  Clause? consequent;
  bool fired = false;
  String name;

  Rule({required this.name, required this.antecedents, this.consequent});

  String getName() {
    return name;
  }

  Clause getConsequent() {
    return consequent!;
  }

  void setConsequent(Clause consequent) {
    this.consequent = consequent;
  }

  void clearConsequent() {
    consequent = null;
  }

  // adds an antecedent to the rule
  void addAntecedent(Clause antecedent) {
    antecedents.add(antecedent);
  }

  void clearAntecedents() {
    antecedents.clear();
  }

  void fire(KnowledgeBase knowledgeBase) {
    if (!knowledgeBase.isFact(consequent!)) {
      knowledgeBase.addFact(consequent!);
    }
    fired = true;
  }

  bool isTriggered(KnowledgeBase knowledgeBase) {
    for (Clause antecedent in antecedents) {
      if (!knowledgeBase.isFact(antecedent)) {
        return false;
      }
    }
    return true;
  }

  bool isFired() {
    return fired;
  }

  @override
  String toString() {
    String antecedentsString = "";
    for (Clause antecedent in antecedents) {
      antecedentsString += "${antecedent.toString()} AND ";
    }
    antecedentsString =
        antecedentsString.substring(0, antecedentsString.length - 5);
    return "IF $antecedentsString THEN ${consequent.toString()}";
  }

  // function to copy a rule
  Rule clone() {
    List<Clause> antecedentsClone = antecedents.map((a) => a.clone()).toList();
    Clause? consequentClone = consequent?.clone();
    return Rule(
        name: name, antecedents: antecedentsClone, consequent: consequentClone);
  }

  Map<String, dynamic> toJSON() {
    return {
      'name': name,
      'antecedents': antecedents.map((clause) => clause.toJSON()).toList(),
      'consequent': consequent?.toJSON(),
      'fired': fired,
    };
  }

  static Rule fromJSON(Map<String, dynamic> json) {
    final rule = Rule(
      name: json['name'],
      antecedents: List<Clause>.from(
          json['antecedents'].map((clauseJson) => Clause.fromJSON(clauseJson))),
      consequent: json['consequent'] != null
          ? Clause.fromJSON(json['consequent'])
          : null,
    );
    rule.fired = json['fired'];
    return rule;
  }
}
