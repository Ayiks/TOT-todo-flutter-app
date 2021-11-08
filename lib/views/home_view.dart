import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/shared_widgets/todo_tile_widget.dart';
import 'package:todo_app/utilities/utils.dart';
import 'package:todo_app/views/create_todo_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final TodoController _todoController = TodoController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        centerTitle: false,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.red,
            backgroundImage: AssetImage('assets/profile_img.jfif'),
          ),
        ),
        title: const Text('My Tasks'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
      ),
      body: FutureBuilder<Todo?>(
          future: _todoController.getAllTodos(status: false),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                snapshot.data == null) {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null) {
              return const Text('Somthing went wrong');
            }
            return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return Dismissible(
                    secondaryBackground: const Material(
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    background: const Material(
                      color: Colors.green,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (dismissedDirection) {
                      SnackBar snackBar = const SnackBar(
                        content: Text('Todo created successfully!',
                            style: TextStyle(color: Colors.green)),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    confirmDismiss: (dismissedDirection) async {
                      if (dismissedDirection == DismissDirection.endToStart) {
                        return showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                    Text('Are you sure you want to delete'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      bool isDeleted =
                                          await _todoController.deleteTodo(
                                              snapshot.data!.data[index].id);
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('ok'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                ],
                              );
                            });
                      } else {
                        return showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    'Are you sure you want to update Todo'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      bool isUpdate = await _todoController
                                          .updateTodoStatus(
                                              id: snapshot.data!.data[index].id,
                                              status: !snapshot
                                                  .data!.data[index].status);
                                      Navigator.of(context).pop(isUpdate);
                                    },
                                    child: Text('ok'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    key: UniqueKey(),
                    child: TodoTileWidget(
                      todo: snapshot.data!.data[index],
                    ),
                  );

                  // if (snapshot.data!.data[index].status == false) {

                  // } else {
                  //  return SizedBox.shrink();
                  // }
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: snapshot.data!.data.length);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CreateTodoView();
          }));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: SafeArea(
        child: InkWell(
          onTap: () {
            showBarModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                builder: (context) {
                  return CompletedTodoWidget();
                });
          },
          child: Container(
            height: 50,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: customBlue,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'completed',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w600, color: customBlue),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: customBlue,
                    )
                  ],
                ),
                Text(
                  '24',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: customBlue),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompletedTodoWidget extends StatefulWidget {
  CompletedTodoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CompletedTodoWidget> createState() => _CompletedTodoWidgetState();
}

class _CompletedTodoWidgetState extends State<CompletedTodoWidget> {
  final TodoController _todoController = TodoController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Todo?>(
        future: _todoController.getAllTodos(status: true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.data == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null) {
            return const Text('Somthing went wrong');
          }
          return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return Dismissible(
                    secondaryBackground: const Material(
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    background: const Material(
                      color: Colors.green,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (dismissedDirection) {
                      SnackBar snackBar = const SnackBar(
                        content: Text('Todo created successfully!',
                            style: TextStyle(color: Colors.green)),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    confirmDismiss: (dismissedDirection) async {
                      if (dismissedDirection == DismissDirection.endToStart) {
                        return showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content:
                                    Text('Are you sure you want to delete'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      bool isDeleted =
                                          await _todoController.deleteTodo(
                                              snapshot.data!.data[index].id);
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text('ok'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                ],
                              );
                            });
                      } else {
                        return showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                    'Are you sure you want to update Todo'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      bool isUpdate = await _todoController
                                          .updateTodoStatus(
                                              id: snapshot.data!.data[index].id,
                                              status: !snapshot
                                                  .data!.data[index].status);
                                      Navigator.of(context).pop(isUpdate);
                                    },
                                    child: Text('ok'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    key: UniqueKey(),
                    child: TodoTileWidget(
                      todo: snapshot.data!.data[index],
                    ),
                  );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: snapshot.data!.data.length);
        });
  }
}
