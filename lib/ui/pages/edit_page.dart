import 'package:expert_system/engine/engine.dart';
import 'package:expert_system/engine/rule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../engine/clauses/clause.dart';

class EditPage extends StatefulWidget {
  // final Engine engine;
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  // late List<Rule> rules;
  // late List<Clause> facts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // rules = widget.engine.rules;
    // facts = widget.engine.knowledgeBase.getFacts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Engine>(
      builder: (buildContext, value, child) => Scaffold(
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const Text('Rules'),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 500,
                                    width: 500,
                                    color: Colors.red,
                                  ),
                                ],
                              ))),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Text('Facts'),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  // ? THAT DAMN BUTTON I KEEP LOOKING FOR
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            value.knowledgeBase.clearFacts();
                                          },
                                          icon: const Icon(Icons.refresh))
                                    ],
                                  ),
                                  SizedBox(
                                    width: 500,
                                    height: 500,
                                    child: ListView.builder(
                                      itemBuilder: (itemBuilder, index) {
                                        return Text(
                                            '${value.knowledgeBase.getFacts()[index].variable} = ${value.knowledgeBase.getFacts()[index].value}');
                                      },
                                      itemCount: value.knowledgeBase.getFacts().length,
                                    ),
                                  ),
                                ],
                              ))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
