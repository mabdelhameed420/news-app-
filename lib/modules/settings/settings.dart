import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/states.dart';
import 'package:todoapp/modules/about_us/about_us.dart';
import 'package:todoapp/shared/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(
                right: 20,
                bottom: 20,
                top: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Dark Mode',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        CupertinoSwitch(
                          value: cubit.isDark,
                          onChanged: (value) {
                            cubit.changeMode();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'About us',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              navigateTo(context, const AboutUs());
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
