import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/components/components.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return cubit.newTasks.isNotEmpty ? BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) =>
              dataItem(cubit.newTasks[index], context),
          separatorBuilder: (context, index) =>
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black26,
              ),
          itemCount: cubit.newTasks.length,
          padding: const EdgeInsetsDirectional.only(start: 16),

        );
      },
    ) : fellowColumn();
  }
}
