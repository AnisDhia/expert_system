import 'package:another_flushbar/flushbar.dart';
import 'package:expert_system/engine/engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../engine/clauses/equals_clause.dart';
import '../../engine/clauses/regex_clause.dart';

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
                        onPressed: () {
                          List<String> parts = _inputController.text
                              .toLowerCase()
                              .split(RegExp(r'=|match'));
                          if (parts.length != 2) {
                            _showFlushBar('Error: Invalid fact',
                                'Please follow the format: variable (= or match) value');
                          } else {
                            if (_inputController.text.contains('match')) {
                              value.addFact(RegexClause(
                                  parts[0].trim(), parts[1].trim()));
                            } else if (_inputController.text.contains('=')) {
                              value.addFact(EqualsClause(
                                  variable: parts[0].trim(),
                                  value: parts[1].trim()));
                            } else {
                              _showFlushBar('Error: Invalid fact',
                                  'Please follow the format: variable (= or match) value');
                            }
                            _inputController.clear();
                          }
                        },
                        style: ButtonStyle(
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
                                            const Color.fromARGB(
                                                255, 246, 160, 12)),
                                    overlayColor: MaterialStateProperty.all<
                                            Color>(
                                        const Color.fromARGB(50, 128, 83, 6))),
                                onPressed: () {
                                  value.infer();
                                },
                                child: const Text('Infer facts')),
                            const SizedBox(
                              width: 10,
                            ),
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
      ),
    );
  }

  _showFlushBar(String title, String message) async {
    await Flushbar(
      shouldIconPulse: true,
      icon: const Icon(
        CupertinoIcons.exclamationmark_circle,
        color: Colors.red,
        weight: 30,
        size: 30,
      ),
      leftBarIndicatorColor: Colors.red,
      backgroundColor: Theme.of(context).snackBarTheme.backgroundColor!,
      titleSize: 24,
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
    ).show(context);
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
