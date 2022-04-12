import 'package:expert_system/engine/knowledge_base.dart';
import 'package:expert_system/engine/rule.dart';
import 'package:expert_system/models/illness.dart';
import 'package:expert_system/models/person.dart';
import 'dart:math';

class BinaryNode<T> {
  BinaryNode(this.value);
  T value;
  BinaryNode<T>? yesChild;
  BinaryNode<T>? noChild;
}

class Engine {
  KnowledgeBase knowledgeBase = KnowledgeBase();
  // Engine({this.person, this.rules});
  Engine();

  addIllness(Illness newIllness) {
    knowledgeBase.illnesses.add(newIllness);
  }

  Illness match(Person person) {
    //TODO: implement matching algorithm

    int greatestMatchIndex = 0;
    List<int> matchesParIllness = List.filled(knowledgeBase.illnesses.length, 0);
    
    int index = 0;
    for (var illness in knowledgeBase.illnesses) {
      int numberOfMatches = 0;
      for (var symptom in person.symptoms) {
        if (illness.symptoms.contains(symptom)) {
          numberOfMatches++;
        } 
      }
      matchesParIllness[index] = numberOfMatches;
      greatestMatchIndex = matchesParIllness[greatestMatchIndex] < matchesParIllness[index] ?
        index : greatestMatchIndex;
      index++;
    }
    
    
    return knowledgeBase.illnesses[greatestMatchIndex];
  }
}
