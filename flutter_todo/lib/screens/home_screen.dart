// Thư viện hệ thống
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// API
import 'package:todospring/Services/task_service.dart';
import 'package:todospring/models/task/task.dart';
import 'package:todospring/models/task/tasks_data.dart';

// Components
import 'task/task_tile.dart';
import 'task/add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Task>? tasks;

  getTasks() async {
    tasks = await TaskService.getTasks();
    Provider.of<TasksData>(context, listen: false).tasks = tasks!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {

    return tasks == null

        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(

            // 1. AppBar
            appBar: AppBar(
              title: Text(
                'Todo Tasks (${Provider.of<TasksData>(context).tasks.length})',
                style: const TextStyle(color: Colors.white), // Set text color to white
              ),
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 99, 8, 15),
            ),

            // 2. Container (Consumer >< Provider)
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Consumer<TasksData>(

                builder: (context, tasksData, child) {
                  return ListView.builder(
                    itemCount: tasksData.tasks.length,
                    itemBuilder: (context, index) {
                      Task task = tasksData.tasks[index];
                      return TaskTile(
                        task: task,
                        tasksData: tasksData,
                      );
                    });
                },
              ),
            ),

            // 3. Nút nổi
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const AddTaskScreen();
                  });
                },
              ),
          );
  }
}
