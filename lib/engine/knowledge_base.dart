import 'package:expert_system/engine/types/intersection.dart';
import 'package:flutter/material.dart';

import 'clauses/clause.dart';

class KnowledgeBase {
  List<Clause> facts = [];
  VoidCallback? callback;

  KnowledgeBase({this.callback, List<Clause>? facts}) : facts = facts ?? [];

  void addFact(Clause fact) {
    facts.add(fact);
    if(callback != null) callback!();
  }

  void clearFacts() {
    facts.clear();
    if(callback != null) callback!();
  }

  List<Clause> getFacts() {
    return facts;
  }

  bool isFact(Clause c) {
    for(Clause fact in facts) {
      if(fact.matchClause(c) == IntersectionType.inclusive) {
        return true;
      }
    }
    return false;
  }

  Map<String, dynamic> toJSON() => {
        'facts': facts.map((e) => e.toJSON()).toList(),
      };

  void loadFromJSON(Map<String, dynamic> json) {
    facts = List<Clause>.from(json['facts'].map((clauseJson) => Clause.fromJSON(clauseJson)));
    if(callback != null) callback!();
  }
  // List<String> symptoms = [
  //   fever,
  //   soreThroat,
  //   tiredness,
  //   dryCough,
  //   lossOfTaste,
  //   lossOfSmell,
  //   diarrhea,
  //   chestPain,
  //   redEyes,
  //   discolorationOfFingersAndToes,
  //   rashOnSkin,
  //   lossOfAppetite,
  //   difficultySleeping,
  //   tummyPain,
  //   achingBody,
  //   highTemprature,
  //   sneezing,
  //   wateryEyes,
  //   swollenLips,
  //   stomachAche,
  //   runnyOrBlockedNose,
  //   bumpsFilledWithLiquid,
  //   blotchySkin,
  //   sweating,
  //   thirst,
  //   blurredVision,
  //   dryMouth,
  //   shakiness,
  //   pale,
  //   frequentUrination,
  //   itchyAndRedSkin,
  //   smellingBreath,
  //   shortnessOfBreath,
  //   coughing,
  //   hunger
  // ];

  // List<Illness> illnesses = [
  //   Illness(name: 'diabetes', symptoms: [
  //     shakiness,
  //     hunger,
  //     sweating,
  //     headAche,
  //     pale,
  //     thirst,
  //     blurredVision,
  //     dryMouth,
  //     smellingBreath,
  //     frequentUrination
  //   ]),
  //   Illness(name: 'corona', symptoms: [
  //     fever,
  //     soreThroat,
  //     dryCough,
  //     chestPain,
  //     lossOfTaste,
  //     lossOfSmell,
  //     redEyes,
  //     diarrhea
  //   ]),
  //   Illness(name: 'flu', symptoms: [
  //     fever,
  //     soreThroat,
  //     tiredness,
  //     dryCough,
  //     tummyPain,
  //     // lossOfTaste,
  //     lossOfSmell,
  //     difficultySleeping,
  //     lossOfAppetite,
  //     highTemprature
  //   ]),
  //   Illness(name: 'allergy', symptoms: [
  //     fever,
  //     wateryEyes,
  //     tiredness,
  //     runnyOrBlockedNose,
  //     swollenLips,
  //     itchyAndRedSkin,
  //     sneezing,
  //     shortnessOfBreath,
  //     coughing
  //   ]),
  //   Illness(name: 'chicken pox', symptoms: [
  //     bumpsFilledWithLiquid,
  //     stomachAche,
  //     blotchySkin,
  //     itchyAndRedSkin,
  //     tiredness,
  //     headAche,
  //     fever
  //   ])
  // ];
}
