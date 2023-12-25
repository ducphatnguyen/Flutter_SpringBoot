import 'package:flutter/cupertino.dart';
import 'package:todospring/Services/task_service.dart';
import 'package:todospring/models/task/task.dart';

// Thực hiện dịch vụ và lắng nghe sự thay đổi
class TasksData extends ChangeNotifier {
  List<Task> tasks = [];

  void addTask(String taskTitle) async {
    Task task = await TaskService.addTask(taskTitle);
    tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggle();
    TaskService.updateTask(task.id);
    notifyListeners();
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    TaskService.deleteTask(task.id);
    notifyListeners();
  }

}
