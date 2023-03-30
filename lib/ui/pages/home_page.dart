import 'package:another_flushbar/flushbar.dart';
import 'package:expert_system/engine/engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

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

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _inputController = TextEditingController();
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
        body: Stack(
          children: [
            SingleChildScrollView(
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
                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.inputFactHere,
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
                                } else if (_inputController.text
                                    .contains('=')) {
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
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    const Color.fromARGB(50, 33, 149, 243))),
                            child: Text(AppLocalizations.of(context)!.addFact),
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
                                Expanded(
                                  child: Text(
                                    '${AppLocalizations.of(context)!.facts} ',
                                    style: const TextStyle(fontSize: 30),
                                  ),
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    255, 246, 160, 12)),
                                        overlayColor:
                                            MaterialStateProperty.all<Color>(
                                                const Color.fromARGB(
                                                    50, 128, 83, 6))),
                                    onPressed: () {
                                      value.infer();
                                    },
                                    child: Text(AppLocalizations.of(context)!
                                        .inferFacts)),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      value.knowledgeBase.clearFacts();
                                      value.resetRules();
                                    },
                                    child: Text(AppLocalizations.of(context)!
                                        .clearFacts)),
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
                                  return Text(
                                      value.getFacts()[index].toString());
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 140,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(137, 0, 0, 0),
                      blurRadius: 2,
                      spreadRadius: .2,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width * .93,
                height: 140,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Log Console',
                            // style: TextStyle(fontSize: 30),
                          ),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  value.logs.clear();
                                });
                              },
                              child: const Text('Clear Logs'))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 55,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                itemBuilder: (itemBuilder, index) {
                                  return Text('> ${value.getLogs()[index]}');
                                },
                                itemCount: value.getLogs().length,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // TODO move this to a separate class
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
