import 'package:flutter/material.dart';
import 'package:todo_app/utilities/utils.dart';

class TodoTileWidget extends StatelessWidget {
  const TodoTileWidget({
    Key? key,required this.status,
  }) : super(key: key);

  final bool status;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).shadowColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ListTile(
          leading: Icon(
            status ? Icons.check_circle : Icons.check_circle_outline,
            size: 30,
            color: dateColor(date: 'Yesterday'),
          ),
          title: Text(
            'Plan the trip to Finland',
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
          ),
          subtitle: Text(
            'The family\'s trip to finland next summer',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          trailing: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: dateColor(date: 'Yesterday'),
              ),
              label: Text(
                'Yesterday',
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: dateColor(date: 'Yesterday')),
              )),
        ),
      ),
    );
  }
}
