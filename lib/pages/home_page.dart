import 'package:expert_system/models/person.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _ageController;
  late Person person;
  late Map<String, bool?> facts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ageController = TextEditingController();
    facts = {
      "Shakiness": false,
      "Hunger": false,
      "Sweating": false,
      "Headach": false,
      "Diabetic parents": false,
      "Pale": false,
      "Frequent urination": false,
      "Thirst": false,
      "Blurred vision": false,
      "Dry mouth": false,
      "Smelling breath": false,
      "Shortness of breath": false,
    };
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
                    SizedBox(
                      width: 300,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: facts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              margin: const EdgeInsets.all(8),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(children: [
                                  Expanded(
                                      child: Text(facts.keys.elementAt(index))),
                                  Checkbox(
                                    value: facts[facts.keys.elementAt(index)],
                                    onChanged: (value) {
                                      setState(() {
                                        facts[facts.keys.elementAt(index)] = value;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  )
                                ]),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(height: 24,),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () {
                            _submitForm();
                          },
                          child: const Text('Submit')),
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
        person = Person(age: int.parse(_ageController.text), symptoms: facts);
      });
      print('Age: ${person.age} \n Symptoms: ${person.symptoms}');
    }
  }
}
