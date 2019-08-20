import 'package:flutter/material.dart';

import 'package:speech_to_text_app/pages/doc/doc_widget.dart';
//import 'package:speech_to_text_app/ui/home/home_bloc.dart';

enum MenuItem { taskCompleted }

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
//  final TaskBloc _taskBloc = TaskBloc(TaskDB.get());

  @override
  Widget build(BuildContext context) {
//    final HomeBloc homeBloc = BlocProvider.of(context);
//    homeBloc.filter.listen((filter) {
//      _taskBloc.updateFilters(filter);
//    });
    return Scaffold(
      body: DocPage(),
//      body: BlocProvider(
//        bloc: _taskBloc,
//        child: TasksPage(),
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add, color: Colors.white),
//        backgroundColor: Colors.orange,
//        onPressed: () async {
//          var blocProviderAddTask = BlocProvider(
//            bloc: AddTaskBloc(TaskDB.get(), ProjectDB.get(), LabelDB.get()),
//            child: AddTaskScreen(),
//          );
//          await Navigator.push(
//            context,
//            MaterialPageRoute<bool>(builder: (context) => blocProviderAddTask),
//          );
//          _taskBloc.refresh();
//        },
//      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
//  Widget buildPopupMenu(BuildContext context) {
//    return PopupMenuButton<MenuItem>(
//      onSelected: (MenuItem result) async {
//        switch (result) {
//          case MenuItem.taskCompleted:
//            await Navigator.push(
//              context
//              MaterialPageRoute<bool>(
//                  builder: (context) => TaskCompletedPage()),
//            );
//            _taskBloc.refresh();
//            break;
//        }
//      },
//      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
//            const PopupMenuItem<MenuItem>(
//              value: MenuItem.taskCompleted,
//              child: Text('Completed Tasks'),
//            )
//          ],
//    );
//  }
}
