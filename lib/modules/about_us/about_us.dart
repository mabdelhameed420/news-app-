import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/states.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
            title: Text(
              '3wcaz',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          body: Padding(
                padding: const EdgeInsetsDirectional.all(20),
              child: SizedBox(
                 width: double.infinity,
                  child: Column(
                    children: [
                       Text('Introduce by : ma420',
                       style: Theme.of(context).textTheme.bodyText1,
                       ),
                      const SizedBox(width: 20,),
                      Text('Mail Us on: Mabdelhameed420@gmail.com',
                      style: Theme.of(context).textTheme.bodyText1,)

                    ],
                  )
              ),
            ),
          );
        },
    );
  }
}
