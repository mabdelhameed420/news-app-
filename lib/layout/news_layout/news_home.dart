import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/models/search_screen/search_screen.dart';
import 'package:todoapp/shared/components/components.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class NewsHome extends StatelessWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('3wcaz'),
            actions: cubit.currentIndex == 3
                ? [const Icon(null)]
                : [
                    IconButton(
                        onPressed: () {
                          navigateTo(context, SearchScreen());
                        },
                        icon: const Icon(
                          Icons.search,
                        )),
                    IconButton(
                        onPressed: () {
                          cubit.changeMode();
                        },
                        icon: const Icon(
                          Icons.brightness_4_outlined,
                        )),
                  ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: BorderDirectional(
                top: BorderSide(
                    color: cubit.isDark ? Colors.grey : HexColor('333739'),
                    width: 1.0),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavButtonState(index);
              },
              items: cubit.itemButton,
            ),
          ),
        );
      },
    );
  }
}
