import 'package:expert_system/repository/models/person.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _ageController;
  late Person person = Person(age: 12, symptoms: facts);
  Map<String, bool?> facts = {
    "shakiness": false,
    "hunger": false,
    "sweating": false,
    "headach": false,
    "diabetic parents": false,
    "pale": false,
    "urination": false,
    "thirst": false,
    "blurred vision": false,
    "dry mouth": false,
    "smelling breath": false,
    "shortness of breath": false,
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ageController = TextEditingController();
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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'How old is the patient?',
                  style: TextStyle(fontSize: 22),
                ),
                SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: _ageController,
                      decoration: const InputDecoration(
                        label: Text('Age'),
                      ),
                      onChanged: (value) {},
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
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: facts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(children: [
                            Expanded(child: Text(facts.keys.elementAt(index))),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
