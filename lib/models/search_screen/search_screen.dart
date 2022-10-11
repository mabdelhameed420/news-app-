import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/layout/news_layout/cubit/states.dart';
import 'package:todoapp/shared/components/components.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '3wcaz',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextField(
                  context: context,
                  text: 'Search',
                  controller: searchController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'must not be empty';
                    } else {
                      return null;
                    }
                  },
                  onChange: (value) {
                    cubit.getSearch(value);
                  },
                ),
              ),
              Expanded(
                  child: articleItem(cubit.search, context, isSearch: true))
            ],
          ),
        );
      },
    );
  }
}
