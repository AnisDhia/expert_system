import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text('Item'),
              subtitle: Text(index.toString()),
              onTap: () {},
            );
          }),
          bottomNavigationBar: NavigationBar(
            destinations: const [
              Icon(Icons.gite_sharp),
              Icon(Icons.favorite_outline),
              Icon(Icons.chevron_left),
            ],
          ),
    );
  }
}
