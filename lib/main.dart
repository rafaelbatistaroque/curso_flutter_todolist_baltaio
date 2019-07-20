import 'package:curso_flutter_todolist_baltaio/models/item.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ToDo List",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
    items.add(Item(title: "Limpar", done: false));
    items.add(Item(title: "Estudar", done: true));
    items.add(Item(title: "Descansar", done: false));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildListTask(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text("ToDo List"),
      centerTitle: true,
    );
  }

  Widget _buildListTask() {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: _buildTask,
    );
  }

  Widget _buildTask(BuildContext context, int index) {
    return Text(widget.items[index].title);
  }
}
