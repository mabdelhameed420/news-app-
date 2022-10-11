import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../../modules/archivedTasks/archiveTasks.dart';
import '../../modules/doneTasks/doneTasks.dart';
import '../../modules/newTasks/newTasks.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isTrue = false;
  IconData checkIcon = Icons.check_box_outline_blank;
  bool isShowed = false;
  IconData fabIcon = Icons.mode_edit_outline_outlined;

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  List<Widget> screens = const [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];

  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archive Tasks',
  ];

  int currentIndex = 0;
  late Database database;

  void changeScreens(int index) {
    currentIndex = index;
    emit(AppChangeNavScreens());
  }

  void changeButtonSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isShowed = isShow;
    fabIcon = icon;
    emit(AppChangeButtonSheet());
  }

  void changeCheckState() {
    emit(AppCheckButtonState());
  }

  void createDatabase() async {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY NOT NULL,title '
                'TEXT,date TEXT,time TEXT,status TEXT);')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('error on create database ${error.toString()}');
        });
      },
      onOpen: (database) {
        getData(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  Future insertToDatabase({
    required var title,
    required var date,
    required var time,
  }) async {
    return await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new");')
          .then((value) {
        emit(AppInsertDatabaseState());
        getData(database);
        print('$value successfully insert');
      }).catchError((error) {
        print('error when inserting ${error.toString()}');
      });
    });
  }

  void updateData({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?;',
      [status, '$id'],
    ).then((value) {
      emit(AppUpdateDatabaseState());
      getData(database);
    });
  }

  void getData(database) async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks;').then((value) {
      for (var element in value) {
        if (element['status'] == 'new') {
          newTasks.add(element);
        } else if (element['status'] == 'done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      }
      emit(AppGetDatabaseState());
    });
  }

  void deleteData({
  required int id
}) async {
    database.rawDelete('DELETE FROM tasks WHERE id = ? ;',
      [id]
    ).then((value) {
      getData(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
