import 'package:flutter/material.dart';
//import 'package:speech_to_text_app/bloc/bloc_provider.dart';
//import 'package:speech_to_text_app/pages/tasks/bloc/task_bloc.dart';
//import 'package:speech_to_text_app/pages/labels/label_db.dart';
//import 'package:speech_to_text_app/pages/projects/project_db.dart';
//import 'package:speech_to_text_app/pages/projects/project.dart';
import 'package:speech_to_text_app/pages/about/about_us.dart';
//import 'package:speech_to_text_app/pages/home/home_bloc.dart';
//import 'package:speech_to_text_app/pages/labels/label_bloc.dart';
//import 'package:speech_to_text_app/pages/labels/label_widget.dart';
//import 'package:speech_to_text_app/pages/projects/project_bloc.dart';
//import 'package:speech_to_text_app/pages/projects/project_widget.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    HomeBloc homeBloc = BlocProvider.of(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Burhanuddin Rashid'),
            accountEmail: Text('jp.ne.co.jp@gmail.com'),
            otherAccountsPictures: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 36.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<bool>(
                          builder: (context) => AboutUsScreen()),
                    );
                  })
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              backgroundImage: AssetImage('assets/profile_pic.jpg'),
            ),
          ),
          ListTile(
              leading: Icon(Icons.inbox),
              title: Text('Inbox'),
              onTap: () {
//                var project = Project.getInbox();
//                homeBloc.applyFilter(
//                    project.name, Filter.byProject(project.id));
                Navigator.pop(context);
              }),
//          ListTile(
//              onTap: () {
//                homeBloc.applyFilter("Today", Filter.byToday());
//                Navigator.pop(context);
//              },
//              leading: Icon(Icons.calendar_today),
//              title: Text("Today")),
//          ListTile(
//            onTap: () {
//              homeBloc.applyFilter("Next 7 Days", Filter.byNextWeek());
//              Navigator.pop(context);
//            },
//            leading: Icon(Icons.calendar_today),
//            title: Text("Next 7 Days"),
//          ),
//          BlocProvider(
//            bloc: ProjectBloc(ProjectDB.get()),
//            child: ProjectPage(),
//          ),
//          BlocProvider(
//            bloc: LabelBloc(LabelDB.get()),
//            child: LabelPage(),
//          )
        ],
      ),
    );
  }
}
