import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/utilities/utils.dart';

class CreateTodoView extends StatefulWidget {
  const CreateTodoView({Key? key}) : super(key: key);

  @override
  State<CreateTodoView> createState() => _CreateTodoViewState();
}

class _CreateTodoViewState extends State<CreateTodoView> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _timeController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  final TodoController _todoController = TodoController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new Todo'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  label: const Text('title'),
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  hintText: 'Please enter a tilte',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue))),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter somthing';
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _descriptionController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  label: const Text('Description'),
                  labelStyle: Theme.of(context).textTheme.bodyText1,
                  hintText: 'Please enter a description here',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: customBlue))),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter a description';
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)))
                          .then((value) {
                        setState(() {
                          _dateController.text =
                              DateFormat.yMMMMd().format(value!);
                        });
                      });
                    },
                    controller: _dateController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        label: const Text('Date'),
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        hintText: 'Please pick a date',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: customBlue))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please pick a date';
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextFormField(
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) {
                        setState(() {
                          // _timeController.text = '${value!.hour}:${value!.minute}';
                          _timeController.text = value!.format(context);
                        });
                      });
                    },
                    controller: _timeController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                        label: const Text('Time'),
                        labelStyle: Theme.of(context).textTheme.bodyText1,
                        hintText: 'Please pick a time',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: customBlue))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please pick a time';
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 35,
            ),isLoading ? const Center(child: CircularProgressIndicator()) : 
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  print(_titleController.text);
                  print(_descriptionController.text);
                  print(_dateController.text);
                  print(_timeController.text);

                  String dateTime =
                      _dateController.text + " " + _timeController.text;
                  // '${ _dateController.text} ${_timeController.text}';

                  setState(() {
                    isLoading = true;
                  });

                  bool isSuccessful = await _todoController.createTodo(
                      title: _titleController.text,
                      description: _descriptionController.text,
                      dateTime: dateTime);
                      print('createTodo:$isSuccessful');
                  if (isSuccessful) {
                    setState(() {
                      isLoading = false;
                    });
                    _timeController.clear();
                    _titleController.clear();
                    _dateController.clear();
                    _descriptionController.clear();
                    SnackBar snackBar = const SnackBar(
                      content: Text('Todo created successfully!',
                          style: TextStyle(color: Colors.green)),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    SnackBar snackBar = const SnackBar(
                      content: Text('Failed to create Todo!',
                          style: TextStyle(color: Colors.red)),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                } else {
                  SnackBar snackBar = const SnackBar(
                    content: Text('All fields are required!',
                        style: TextStyle(color: Colors.blue)),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text(
                'Create Todo',
                style: TextStyle(color: Colors.white),
              ),
              
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(168),
                  backgroundColor: customBlue),
            )
          ],
        ),
      ),
    );
  }
}
