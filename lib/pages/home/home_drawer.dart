import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
                  icon: Icon(Icons.info, color: Colors.white, size: 36.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute<bool>(
                        fullscreenDialog: true,
                        builder: (context) => AboutUsScreen(),
                      ),
                    );
                  })
            ],
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              backgroundImage: AssetImage('assets/profile_pic.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.notifications_active),
            title: Text('通知'),
            onTap: () {
//                var project = Project.getInbox();
//                homeBloc.applyFilter(
//                    project.name, Filter.byProject(project.id));
              Navigator.push(
                context,
                CupertinoPageRoute<bool>(
                  fullscreenDialog: true,
                  builder: (context) => AboutUsScreen(),
                ),
              );
            },
          ),
          Divider(
            height: 2.0,
          ),
          ListTile(
            title: Text('設定'),
            leading: Icon(Icons.settings),
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute<bool>(
                  fullscreenDialog: true,
                  builder: (context) => AboutUsScreen(),
                ),
              );
            },
          ),
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
