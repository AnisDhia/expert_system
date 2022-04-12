import 'package:expert_system/engine/engine.dart';
import 'package:expert_system/engine/knowledge_base.dart';
import 'package:expert_system/models/illness.dart';
import 'package:expert_system/models/person.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Engine engine = Engine();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _ageController;
  late Person person;
  late List<String> symptoms;
  late String result;
  late Illness resultIllness;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ageController = TextEditingController();
    symptoms = [];
    result = 'nothing';
    // person = Person(age: 0, symptoms: []);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      'Which of these symptoms does the patient have?',
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
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: engine.knowledgeBase.symptoms.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  Expanded(
                                    child: Text(
                                        engine.knowledgeBase.symptoms[index]),
                                  ),
                                  Checkbox(
                                    value: symptoms.contains(
                                        engine.knowledgeBase.symptoms[index]),
                                    onChanged: (value) {
                                      setState(() {
                                        if (symptoms.contains(engine
                                            .knowledgeBase.symptoms[index])) {
                                          symptoms.remove(engine
                                              .knowledgeBase.symptoms[index]);
                                        } else {
                                          symptoms.add(engine
                                              .knowledgeBase.symptoms[index]);
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
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              child: const Text('Submit')),
                        ),
                        const SizedBox(width: 14,),
                        const Text('You have '),
                        Text(result),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        person =
            Person(age: int.parse(_ageController.text), symptoms: symptoms);
        resultIllness = engine.match(person);
        result = resultIllness.name;
      });
      print('Age: ${person.age} \n Symptoms: ${person.symptoms}');
    }
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
