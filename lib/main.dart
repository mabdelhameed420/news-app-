import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/states.dart';
import 'package:todoapp/layout/news_layout/news_home.dart';
import 'package:todoapp/shared/blocObserver.dart';
import 'package:todoapp/shared/network/local/cached_helper.dart';
import 'package:todoapp/shared/network/remote/dio.dart';
import 'package:todoapp/shared/style/themes.dart';

void main(context) async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  NewsDio.init();
  await CachedHelper.init();
  bool? isDark = CachedHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  const MyApp(this.isDark, {Key? key}) : super(key: key);

  final bool? isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NewsCubit()..getBusiness()..changeMode(fromShared: isDark);
      },
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const Directionality(
                textDirection: TextDirection.ltr, child: NewsHome()),
          );
        },
      ),
    );
  }
}
