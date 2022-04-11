import 'package:expert_system/engine/rule.dart';
import 'package:expert_system/models/person.dart';

// class BinaryNode<T> {
//   BinaryNode(this.value);
//   T value;
//   BinaryNode<T>? yesChild;
//   BinaryNode<T>? noChild;
// }

class Engine {
  Person? person;
  List<Rule>? rules;

  Engine({this.person, this.rules});

  void addRule(List<Rule> rules) {
    this.rules!.addAll(rules);
  }
}
