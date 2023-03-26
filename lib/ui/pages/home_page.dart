import 'package:another_flushbar/flushbar.dart';
import 'package:expert_system/engine/clauses/clause.dart';
import 'package:expert_system/engine/engine.dart';
import 'package:expert_system/engine/rule.dart';
import 'package:expert_system/shared/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  // final Engine engine;
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController scrollController;
  late TextEditingController _inputController;
  late List<String> facts;
  late String result;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _inputController = TextEditingController();
    facts = [];
    result = 'nothing';
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _inputController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Engine>(
      builder: (context, value, child) => Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                Card(
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.search),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: _inputController,
                          decoration: const InputDecoration(
                            hintText: 'Input your fact here',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          List<String> parts =
                              _inputController.text.toLowerCase().split(' ');
                          if (parts.length != 3) {
                            await Flushbar(
                              shouldIconPulse: true,
                              icon: const Icon(
                                CupertinoIcons.exclamationmark_circle,
                                color: Colors.red,
                                weight: 30,
                                size: 30,
                              ),
                              leftBarIndicatorColor: Colors.red,
                              backgroundColor: Theme.of(context)
                                  .snackBarTheme
                                  .backgroundColor!,
                              titleSize: 24,
                              title: 'Error: Invalid fact',
                              message: 'Please follow the format: '
                                  'variable = value',
                              duration: const Duration(seconds: 3),
                            ).show(context);
                          } else {
                            value.addFact(
                                Clause(variable: parts[0], value: parts[2]));
                            _inputController.clear();
                          }
                        },
                        style: ButtonStyle(
                            // backgroundColor: MaterialStateProperty.all<Color>(
                            //     const Color.fromARGB(255, 14, 15, 22)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            overlayColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(50, 33, 149, 243))),
                        child: const Text('Add fact'),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Facts: ',
                                style: TextStyle(fontSize: 30),
                              ),
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(255, 246, 160, 12)),
                                    overlayColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                50, 128, 83, 6))),
                                onPressed: () {
                                  value.infer();
                                },
                                child: const Text('Infer facts')),
                            ElevatedButton(
                                onPressed: () {
                                  value.knowledgeBase.clearFacts();
                                },
                                child: const Text('Clear facts')),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 500,
                          width: double.infinity,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.getFacts().length,
                            itemBuilder: (context, index) {
                              return Text(value.getFacts()[index].toString());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            CupertinoIcons.gear,
            size: 40,
            color: borderColor,
          ),
          onPressed: () {
            Rule rule = Rule(name: 'Bicycle');
            rule.addAntecedent(Clause(variable: "vehicleType", value: "cycle"));
            rule.addAntecedent(Clause(variable: "num_wheels", value: "2"));
            rule.addAntecedent(Clause(variable: "motor", value: "no"));
            rule.setConsequent(Clause(variable: "vehicle", value: 'Bicycle'));
            value.addRule(rule);
            rule = Rule(name: 'Tricycle');
            rule.addAntecedent(Clause(variable: "vehicleType", value: "cycle"));
            rule.addAntecedent(Clause(variable: "num_wheels", value: "3"));
            rule.addAntecedent(Clause(variable: "motor", value: "no"));
            rule.setConsequent(Clause(variable: 'vehicle', value: 'Tricycle'));
            value.addRule(rule);
            rule = Rule(name: 'Sedan');
            rule.addAntecedent(
                Clause(variable: "vehicleType", value: "automobile"));
            rule.addAntecedent(Clause(variable: "num_doors", value: "4"));
            rule.addAntecedent(Clause(variable: "size", value: "medium"));
            rule.setConsequent(Clause(variable: 'vehicle', value: 'Sedan'));
            value.addRule(rule);

            value.addFact(Clause(variable: 'num_wheels', value: '3'));
            value.addFact(Clause(variable: 'motor', value: 'no'));
            value.addFact(Clause(variable: 'vehicleType', value: 'cycle'));

            print('before inference ${value.getFacts()}');
            value.infer();
            print('after inference ${value.getFacts()}');

            scrollController.animateTo(0,
                duration: const Duration(seconds: 1), curve: Curves.easeIn);
          },
        ),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
