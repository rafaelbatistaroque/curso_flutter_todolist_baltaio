import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:curso_flutter_todolist_baltaio/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
  }

  @override
  _HomePageState createState() => _HomePageState();
}

//=====================================================
//               Home Page
//=====================================================
class _HomePageState extends State<HomePage> {
  var _taskCtrl = TextEditingController();

  _HomePageState() {
    _loadTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildListTask(),
      floatingActionButton: _buildFloatActionButtom(),
    );
  }

//=====================================================
//               Builder Widgets
//=====================================================
  Widget _buildAppBar() {
    return AppBar(
      title: _buildInputBoxAddTask(),
      centerTitle: true,
    );
  }

  Widget _buildInputBoxAddTask() {
    return TextFormField(
      controller: _taskCtrl,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nova Tarefa",
      ),
    );
  }

  Widget _buildListTask() {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: _buildTask,
    );
  }

  Widget _buildTask(BuildContext context, int index) {
    final item = widget.items[index];
    return Dismissible(
        key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) => _removeTask(index),
        background: Container(
          color: Colors.red,
          child: Align(
            alignment: Alignment(-0.9, 0),
            child: Icon(Icons.delete),
          ),
        ),
        child: CheckboxListTile(
          title: Text(item.title),
          value: item.done,
          onChanged: (value) {
            setState(() => item.done = value);
            _saveTask();
          },
        ));
  }

  Widget _buildFloatActionButtom() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addTask();
          _taskCtrl.clear();
        });
  }

//=====================================================
//               Functions
//=====================================================
  void _addTask() {
    if (_taskCtrl.text.isEmpty) return;

    setState(() => widget.items.add(
          Item(title: _taskCtrl.text, done: false),
        ));
    _taskCtrl.clear();
    _saveTask();
  }

  void _removeTask(int index) {
    setState(() => widget.items.removeAt(index));
    _saveTask();
  }

  Future _loadTask() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();

      setState(() => widget.items = result);
    }
  }

  _saveTask() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }
}
