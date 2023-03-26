import 'package:flutter/material.dart';

import 'clauses/clause.dart';

class KnowledgeBase {
  List<Clause> facts = [];
  VoidCallback? callback;

  KnowledgeBase({this.callback});

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
      if(fact.value == c.value) {
        return true;
      }
    }
    return false;
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