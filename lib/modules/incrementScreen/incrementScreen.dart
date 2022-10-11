import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/modules/incrementScreen/cubit/cubit.dart';
import 'package:todoapp/modules/incrementScreen/cubit/states.dart';

class IncrementScreen extends StatelessWidget {
  const IncrementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IncrementCubit(),
      child: BlocConsumer<IncrementCubit,IncrementStates>(
        builder: (context, sate) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Increment'),
            ),
            body: SizedBox(
              height: double.infinity,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        IncrementCubit.get(context).minus();
                      },
                      child: const Text(
                        'Minus',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(
                        '${IncrementCubit.get(context).counter}',
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        IncrementCubit.get(context).plus();
                      },
                      child: const Text(
                        'Plus',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, sate) {},
      ),
    );
  }
}
