import 'package:expert_system/engine/clauses/clause.dart';
import 'package:expert_system/engine/engine.dart';
import 'package:expert_system/engine/rule.dart';
import 'package:expert_system/ui/widgets/circular_progress_widget.dart';
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
  // Engine engine = Engine();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _ageController;
  late List<String> facts;
  late String result;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    _ageController = TextEditingController();
    facts = [];
    result = 'nothing';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
    _ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          'How old is the patient?',
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(
                            width: 100,
                            child: TextFormField(
                              controller: _ageController,
                              decoration: const InputDecoration(
                                label: Text('Age'),
                              ),
                              onChanged: (value) {},
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                return (int.tryParse(value!) == null)
                                    ? 'Enter a valid age'
                                    : null;
                              },
                            )),
                        const SizedBox(
                          height: 24,
                        ),
                        const Text(
                          'Which of these facts does the patient have?',
                          style: TextStyle(fontSize: 22),
                        ),
                        // IconButton(
                        //   onPressed: () {
                        //     showSearch(
                        //         context: context, delegate: MySearchDelegate());
                        //   },
                        //   icon: const Icon(Icons.search),
                        // ),
                        SizedBox(
                          width: 300,
                          child: Consumer<Engine>(
                            builder: (buildContext, value, child) =>
                                ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: value.knowledgeBase.facts.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        margin: const EdgeInsets.all(8),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            Expanded(
                                              child: Text(value.knowledgeBase
                                                  .facts[index].value),
                                            ),
                                            Checkbox(
                                              value: facts.contains(value
                                                  .knowledgeBase.facts[index]),
                                              onChanged: (value1) {
                                                setState(() {
                                                  if (facts.contains(value
                                                      .knowledgeBase
                                                      .facts[index])) {
                                                    facts.remove(value
                                                        .knowledgeBase
                                                        .facts[index]);
                                                  } else {
                                                    facts.add(value
                                                        .knowledgeBase
                                                        .facts[index]
                                                        .value);
                                                  }
                                                });
                                              },
                                            )
                                          ]),
                                        ),
                                      );
                                    }),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        // Row(
                        //   children: [
                        //     SizedBox(
                        //       width: 100,
                        //       child: ElevatedButton(
                        //           onPressed: () {
                        //             _submitForm();
                        //             scrollController.animateTo(0,
                        //                 duration: const Duration(seconds: 1),
                        //                 curve: Curves.easeIn);
                        //           },
                        //           child: const Text('Submit')),
                        //     ),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 14,
                      ),
                      Row(
                        children: [
                          const Text('The patient is diagnosed with ',
                              style: TextStyle(fontSize: 30)),
                          Text(
                            result,
                            style: const TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressWidget(
                                      title: 'Depression', percent: 33.3),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  CircularProgressWidget(
                                    title: 'Anxiety',
                                    percent: 50,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  CircularProgressWidget(
                                    title: 'ADHD',
                                    percent: 16.7,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                              Image.asset(
                                  'assets/images/Psychologist-amico.png')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer<Engine>(
        builder: (buildContext, value, child) => FloatingActionButton(
          // backgroundColor: Colors.blue,
          child: const Icon(
            Icons.check,
            size: 40,
            color: Colors.white,
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
            rule.addAntecedent(Clause(variable: "vehicleType", value: "automobile"));
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
