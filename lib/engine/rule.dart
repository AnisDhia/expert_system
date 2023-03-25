import 'package:expert_system/engine/clauses/clause.dart';
import 'package:expert_system/engine/knowledge_base.dart';

class Rule {
  List<Clause> antecedents = [];
  Clause? consequent = null;
  bool fired = false;
  String name;

  Rule({required this.name});

  String getName() {
    return name;
  }

  Clause getConsequent() {
    return consequent!;
  }

  void setConsequent(Clause consequent) {
    this.consequent = consequent;
  }

  void addAntecedent(Clause antecedent) {
    antecedents.add(antecedent);
  }

  void fire(KnowledgeBase knowledgeBase) {
    if (!knowledgeBase.isFact(consequent!)) {
      knowledgeBase.addFact(consequent!);
    }
    fired = true;
  }

  bool isTriggered(KnowledgeBase knowledgeBase) {
    for(Clause antecedent in antecedents){
      if(!knowledgeBase.isFact(antecedent)){
        return false;
      }
    }
    return true;
  }

  bool isFired() {
    return fired;
  }
}
