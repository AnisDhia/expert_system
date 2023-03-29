import 'package:another_flushbar/flushbar.dart';
import 'package:expert_system/engine/engine.dart';
import 'package:expert_system/engine/rule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


import '../../engine/clauses/equals_clause.dart';
import '../../engine/clauses/regex_clause.dart';

class EditPage extends StatefulWidget {
  // final Engine engine;
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late ScrollController scrollController;
  late TextEditingController _ruleNameController;
  late TextEditingController _antecedentController;
  late TextEditingController _consequentController;
  final Rule _rule = Rule(name: '', antecedents: []);

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    _antecedentController = TextEditingController();
    _consequentController = TextEditingController();
    _ruleNameController = TextEditingController();
  }

  @override
  void dispose() {
    _antecedentController.dispose();
    _consequentController.dispose();
    _ruleNameController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Engine>(
      builder: (buildContext, value, child) => Scaffold(
        body: SingleChildScrollView(
          controller: scrollController,
          physics: const ScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.addNewRules,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 450,
                            child: TextField(
                              controller: _ruleNameController,
                              decoration:
                                  InputDecoration(hintText: AppLocalizations.of(context)!.ruleName),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(AppLocalizations.of(context)!.antecedents),
                                    SizedBox(
                                      width: 450,
                                      child: TextField(
                                        controller: _antecedentController,
                                        decoration:  InputDecoration(
                                            hintText:
                                                '${AppLocalizations.of(context)!.enterAntecedent} (variable (= or match) value)'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              setState(() {
                                                _rule.clearAntecedents();
                                              });
                                            },
                                            child:  Text(
                                                AppLocalizations.of(context)!.clearAntecedents)),
                                        ElevatedButton(
                                            onPressed: () {
                                              List<String> parts =
                                                  _antecedentController.text
                                                      .toLowerCase()
                                                      .split(
                                                          RegExp(r'=|match'));
                                              if (parts.length != 2) {
                                                _showFlushBar(
                                                    'Error: Invalid Format',
                                                    'Please follow the format: variable (= or match) value');
                                              } else {
                                                if (_antecedentController.text
                                                    .contains('match')) {
                                                  setState(() {
                                                    _rule.addAntecedent(
                                                        RegexClause(
                                                            parts[0].trim(),
                                                            parts[1].trim()));
                                                  });
                                                } else if (_antecedentController
                                                    .text
                                                    .contains('=')) {
                                                  setState(() {
                                                    _rule.addAntecedent(
                                                        EqualsClause(
                                                            variable:
                                                                parts[0].trim(),
                                                            value: parts[1]
                                                                .trim()));
                                                  });
                                                } else {
                                                  _showFlushBar(
                                                      'Error: Invalid Format',
                                                      'Please follow the format: variable (= or match) value');
                                                }
                                              }
                                              _antecedentController.clear();
                                            },
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.blue),
                                                overlayColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        const Color.fromARGB(
                                                            50, 33, 149, 243))),
                                            child:
                                                Text(AppLocalizations.of(context)!.addAntecedent)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        itemBuilder: (context, index) =>
                                            ListTile(
                                          title: Text(_rule.antecedents[index]
                                              .toString()),
                                        ),
                                        itemCount: _rule.antecedents.length,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     Text(AppLocalizations.of(context)!.consequent),
                                    SizedBox(
                                      width: 450,
                                      child: TextField(
                                        controller: _consequentController,
                                        decoration:  InputDecoration(
                                            hintText:
                                                '${AppLocalizations.of(context)!.enterConsequent} (variable (= or match) value)'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              List<String> parts =
                                                  _consequentController.text
                                                      .toLowerCase()
                                                      .split(
                                                          RegExp(r'=|match'));
                                              if (parts.length != 2) {
                                                _showFlushBar(
                                                    'Error: Invalid Format',
                                                    'Please follow the format: variable (= or match) value');
                                              } else {
                                                if (_consequentController.text
                                                    .contains('match')) {
                                                  setState(() {
                                                    _rule.setConsequent(
                                                        RegexClause(
                                                            parts[0].trim(),
                                                            parts[1].trim()));
                                                  });
                                                } else if (_consequentController
                                                    .text
                                                    .contains('=')) {
                                                  setState(() {
                                                    _rule.setConsequent(
                                                        EqualsClause(
                                                            variable:
                                                                parts[0].trim(),
                                                            value: parts[1]
                                                                .trim()));
                                                  });
                                                } else {
                                                  _showFlushBar(
                                                      'Error: Invalid Format',
                                                      'Please follow the format: variable (= or match) value');
                                                }
                                              }
                                              _consequentController.clear();
                                            },
                                            style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.blue),
                                                overlayColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
                                                        const Color.fromARGB(
                                                            50, 33, 149, 243))),
                                            child:
                                                Text(AppLocalizations.of(context)!.addConsequent)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(_rule.consequent.toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // ? ADD RULE BUTTON
                          ElevatedButton(
                              onPressed: () {
                                if (_rule.consequent == null ||
                                    _rule.antecedents.isEmpty) {
                                  _showFlushBar('Error: Invalid Rule',
                                      'A rule must have at least one antecedent and one consequent');
                                  return;
                                } else {
                                  setState(() {
                                    _rule.name = _ruleNameController.text == "" ? '#${value.rules.length+1}' : _ruleNameController.text;
                                    value.addRule(_rule.clone());
                                    _rule.clearAntecedents();
                                    _rule.clearConsequent();
                                    _rule.name = '';
                                    _ruleNameController.clear();
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)!.addRule,
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                               Expanded(
                                child: Text(
                                  AppLocalizations.of(context)!.activeRules,
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    value.clearRules();
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  tooltip: AppLocalizations.of(context)!.clearRules),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.rules.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: Icon(
                                  Icons.circle,
                                  color: value.rules[index].isFired()
                                      ? Colors.green
                                      : Colors.red,
                                ),
                                title: Text('${value.rules[index].name}: '),
                                subtitle: Text(value.rules[index].toString()),
                                trailing: IconButton(
                                    tooltip: AppLocalizations.of(context)!.removeRule,
                                    onPressed: () {
                                      value.removeRule(value.rules[index]);
                                    },
                                    icon: const Icon(Icons.minimize_outlined)),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
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
