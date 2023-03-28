import 'package:expert_system/engine/knowledge_base.dart';
import 'package:expert_system/engine/rule.dart';
import 'package:flutter/material.dart';
// import 'package:expert_system/models/illness.dart';
// import 'package:expert_system/models/person.dart';
// import 'dart:math';

import 'clauses/clause.dart';

// class BinaryNode<T> {
//   BinaryNode(this.value);
//   T value;
//   BinaryNode<T>? yesChild;
//   BinaryNode<T>? noChild;
// }

class Engine extends ChangeNotifier {
  List<Rule> rules = [];
  KnowledgeBase knowledgeBase = KnowledgeBase();
  Engine() {
    knowledgeBase.callback = () => notifyListeners();
  }

  void addRule(Rule rule) {
    rules.add(rule);
    notifyListeners();
  }

  void clearRules() {
    rules.clear();
    notifyListeners();
  }

  void addFact(Clause fact) {
    knowledgeBase.addFact(fact);
    notifyListeners();
  }

  List<Clause> getFacts() {
    return knowledgeBase.getFacts();
  }

  void infer() {
    List<Rule>? cs;
    do {
      cs = match();
      if (cs.isNotEmpty) {
        if (!fireRules(cs)) {
          break;
        }
      }
    } while (cs.isNotEmpty);
    notifyListeners();
  }

  List<Rule> match() {
    List<Rule> cs = [];
    for (Rule rule in rules) {
      if (rule.isTriggered(knowledgeBase)) {
        cs.add(rule);
      }
    }
    return cs;
  }

  bool fireRules(List<Rule> rules) {
    bool hasRules = false;
    for (Rule rule in rules) {
      if (!rule.isFired()) {
        hasRules = true;
        rule.fire(knowledgeBase);
      }
    }
    return hasRules;
  }

  Map<String, dynamic> toJSON() {
    return {
      'rules': rules.map((rule) => rule.toJSON()).toList(),
      'knowledgeBase': knowledgeBase.toJSON(),
    };
  }

  void loadFromJSON(Map<String, dynamic> json) {
    rules = List<Rule>.from(
        json['rules'].map((ruleJson) => Rule.fromJSON(ruleJson)));
    knowledgeBase = KnowledgeBase.fromJSON(json['knowledgeBase']);
    notifyListeners();
  }
}
