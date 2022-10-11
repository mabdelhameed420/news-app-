import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/shared/components/components.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../../shared/constants/constants.dart';

class ToDoApp extends StatelessWidget {
  const ToDoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              leading: const Icon(null),
              leadingWidth: 0,
            ),
            body: state is AppGetDatabaseLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isShowed) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                      title: titleController.text,
                      date: calendarController.text,
                      time: timeController.text,
                    );
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          padding: const EdgeInsetsDirectional.all(20),
                          color: Colors.grey[150],
                          child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultTextField(
                                    text: 'Task title',
                                    controller: titleController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'title must be valid';
                                      } else {
                                        return null;
                                      }
                                    },
                                    prefixIcon: Icons.title_outlined,
                                    radius: 30,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  defaultTextField(
                                      text: 'Task time',
                                      controller: timeController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'time must be valid';
                                        } else {
                                          return null;
                                        }
                                      },
                                      prefixIcon: Icons.watch_later_outlined,
                                      radius: 30,
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) {
                                          timeController.text =
                                              value!.format(context).toString();
                                          print(value.format(context));
                                        });
                                      }),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  defaultTextField(
                                      text: 'Task date',
                                      controller: calendarController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'calendar must be valid';
                                        } else {
                                          return null;
                                        }
                                      },
                                      prefixIcon: Icons.calendar_month_outlined,
                                      radius: 30,
                                      onTap: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    '2024-08-09'))
                                            .then((value){
                                              calendarController.text =
                                                  DateFormat.yMMMd().format
                                                    (value!);
                                        });
                                      }),
                                ],
                              )),
                        ),
                        elevation: 20,
                      )
                      .closed
                      .then((value) {
                    cubit.changeButtonSheetState(
                        isShow: false, icon: Icons.edit_outlined);
                  });
                  cubit.changeButtonSheetState(isShow: true, icon: Icons.add);
                }
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeScreens(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_outlined),
                  label: 'New Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.task_alt_outlined),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
