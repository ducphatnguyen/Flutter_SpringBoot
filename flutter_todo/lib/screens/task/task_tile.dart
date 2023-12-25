import 'package:flutter/material.dart';

import '../../models/task/task.dart';
import '../../models/task/tasks_data.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final TasksData tasksData;

  const TaskTile({Key? key, required this.task, required this.tasksData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(

        // Checkbox
        leading: Checkbox(
          activeColor: Colors.green,
          value: task.done,
          onChanged: (checkbox) {
            tasksData.updateTask(task);
          },
        ),

        // Nội dung công việc
        title: Text(
          task.title,
          style: TextStyle(
            decoration:
                task.done ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),

        // Dấu X (Xóa)
        trailing: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            tasksData.deleteTask(task);
          },
        ),

      ),
    );
  }
}
