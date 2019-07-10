import 'package:flutter/material.dart';

//import 'package:speech_to_text_app/ui/home/home_bloc.dart';
import 'package:speech_to_text_app/pages/home/home_drawer.dart';

class HomePage extends StatelessWidget {
//  final TaskBloc _taskBloc = TaskBloc(TaskDB.get());

  @override
  Widget build(BuildContext context) {
//    final HomeBloc homeBloc = BlocProvider.of(context);
//    homeBloc.filter.listen((filter) {
//      _taskBloc.updateFilters(filter);
//    });
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
            initialData: 'Today',
//            stream: homeBloc.title,
            builder: (context, snapshot) {
              return Text(snapshot.data);
            }),
        actions: <Widget>[buildPopupMenu(context)],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
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
      ),
      drawer: HomeDrawer(),
//      body: BlocProvider(
//        bloc: _taskBloc,
//        child: TasksPage(),
//      ),
    );
  }

// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
  Widget buildPopupMenu(BuildContext context) {
    return PopupMenuButton<MenuItem>(
      onSelected: (MenuItem result) async {
//        switch (result) {
//          case MenuItem.taskCompleted:
//            await Navigator.push(
//              context,
//              MaterialPageRoute<bool>(
//                  builder: (context) => TaskCompletedPage()),
//            );
//            _taskBloc.refresh();
//            break;
//        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuItem>>[
            const PopupMenuItem<MenuItem>(
              value: MenuItem.taskCompleted,
              child: Text('Completed Tasks'),
            )
          ],
    );
  }
}

// This is the type used by the popup menu below.
enum MenuItem { taskCompleted }
