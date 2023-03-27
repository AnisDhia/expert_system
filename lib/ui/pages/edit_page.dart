import 'package:expert_system/engine/engine.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  // final Engine engine;
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
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
                          const Text('Add New Rules'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: const [Text('Antecedents')],
                              ),
                              Column(
                                children: const [
                                  Text('Consequent'),
                                  Expanded(
                                      child: TextField(
                                    decoration: InputDecoration(
                                        hintText:
                                            'Enter a consequent clause (variable(= or match) value)'),
                                  ))
                                ],
                              ),
                            ],
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
}
