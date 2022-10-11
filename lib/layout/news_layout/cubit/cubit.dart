import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/layout/news_layout/cubit/states.dart';
import 'package:todoapp/modules/science_screen/science.dart';
import 'package:todoapp/modules/sports_screen/sports.dart';
import 'package:todoapp/shared/network/local/cached_helper.dart';
import 'package:todoapp/shared/network/remote/dio.dart';

import '../../../modules/business_screen/business.dart';
import '../../../shared/network/remote/dio.dart';

class NewsCubit extends Cubit<NewsStates> {
  int currentIndex = 0;
  bool isDark = false;

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  List<Widget> screens = const [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<BottomNavigationBarItem> itemButton = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.business_center_outlined), label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports_soccer_outlined), label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(Icons.science_outlined), label: 'Science'),
    // BottomNavigationBarItem(
    //     icon: Icon(Icons.settings_outlined), label: 'Settings'),
  ];

  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  void changeNavButtonState(int index) {
    currentIndex = index;
    if (currentIndex == 1) {
      getSports();
    }
    if (currentIndex == 2) {
      getScience();
    }
    emit(NewsChangeNavButtonState());
  }

  void getBusiness() {
    emit(NewsLoadingBusinessState());
    if (business.isEmpty) {
      NewsDio.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'f59ba0416940487cb9b18563abf81a65',
      }).then((value) {
        business = value.data['articles'];
        emit(NewsGetDataBusinessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsErrorBusinessState(error));
      });
    } else {
      emit(NewsGetDataBusinessState());
    }
  }

  void getSports() {
    emit(NewsLoadingSportsState());
    if (sports.isEmpty) {
      NewsDio.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'f59ba0416940487cb9b18563abf81a65',
      }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetDataSportsState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsErrorSportsState(error));
      });
    } else {
      emit(NewsGetDataSportsState());
    }
  }

  void getScience() {
    emit(NewsLoadingScienceState());
    if (science.isEmpty) {
      NewsDio.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'f59ba0416940487cb9b18563abf81a65',
      }).then((value) {
        science = value.data['articles'];
        emit(NewsGetDataScienceState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsErrorScienceState(error));
      });
    } else {
      emit(NewsGetDataScienceState());
    }
  }

  void getSearch(value) {
    emit(NewsLoadingSearchState());
    search = [];
    NewsDio.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': 'f59ba0416940487cb9b18563abf81a65',
    }).then((value) {
      search = value.data['articles'];
      emit(NewsGetDataSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsErrorSearchState(error));
    });
    emit(NewsGetDataScienceState());
  }

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsChangeModeState());
    } else {
      isDark = !isDark;
      CachedHelper.putBoolean(key: "isDark", value: isDark).then((value) {
        emit(NewsChangeModeState());
      });
    }
  }

  void refreshNews() {
    business = [];
    science = [];
    sports = [];
    emit(NewsRefreshState());
  }

  void changeSwitchState() {
    emit(NewsSwitchState());
  }
}
