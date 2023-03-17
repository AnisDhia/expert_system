import 'package:expert_system/engine/engine.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  Engine engine = Engine();
  late List<String> symptoms;
  late List<String> illnesses;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    symptoms = [];
    illnesses = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: [
                  Text('Illnesses'),
                  SizedBox(
                          width: 300,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: engine.knowledgeBase.symptoms.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  margin: const EdgeInsets.all(0),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Row(children: [
                                      Expanded(
                                        child: Text(engine
                                            .knowledgeBase.symptoms[index]),
                                      ),
                                      Checkbox(
                                        value: symptoms.contains(engine
                                            .knowledgeBase.symptoms[index]),
                                        onChanged: (value) {
                                          setState(() {
                                            if (symptoms.contains(engine
                                                .knowledgeBase
                                                .symptoms[index])) {
                                              symptoms.remove(engine
                                                  .knowledgeBase
                                                  .symptoms[index]);
                                            } else {
                                              symptoms.add(engine.knowledgeBase
                                                  .symptoms[index]);
                                            }
                                          });
                                        },
                                        activeColor: Colors.blue,
                                      )
                                    ]),
                                  ),
                                );
                              }),
                        ),
                ],
              ),
              Column()
            ],
          ),
        ),
      ),
    );
  }
}
