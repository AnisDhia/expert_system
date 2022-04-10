class Person {
  Person({
    required this.age,
    required this.symptoms,
  });

  final int age;
  final Map<String, bool?> symptoms;
}