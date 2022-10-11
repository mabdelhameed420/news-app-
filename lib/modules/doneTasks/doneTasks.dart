import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return cubit.doneTasks.isNotEmpty
        ? BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return ListView.separated(
                itemBuilder: (context, index) =>
                    dataItem(cubit.doneTasks[index], context),
                separatorBuilder: (context, index) => Container(
                  padding: const EdgeInsetsDirectional.only(start: 16),
                  width: double.infinity,
                  height: 1,
                  color: Colors.black26,
                ),
                itemCount: cubit.doneTasks.length,
              );
            },
          )
        : fellowColumn();
  }
}
