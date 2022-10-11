
abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsChangeNavButtonState extends NewsStates{}

class NewsLoadingBusinessState extends NewsStates{}

class NewsGetDataBusinessState extends NewsStates{}

class NewsErrorBusinessState extends NewsStates{
  final error;

  NewsErrorBusinessState(this.error);
}

class NewsLoadingSportsState extends NewsStates{}

class NewsGetDataSportsState extends NewsStates{}

class NewsErrorSportsState extends NewsStates{
  final error;

  NewsErrorSportsState(this.error);
}

class NewsLoadingScienceState extends NewsStates{}

class NewsGetDataScienceState extends NewsStates{}

class NewsErrorScienceState extends NewsStates{
  final error;

  NewsErrorScienceState(this.error);
}

class NewsLoadingSearchState extends NewsStates{}

class NewsGetDataSearchState extends NewsStates{}

class NewsErrorSearchState extends NewsStates{
  final error;

  NewsErrorSearchState(this.error);
}

class NewsChangeModeState extends NewsStates{}

class NewsRefreshState extends NewsStates{}

class NewsSwitchState extends NewsStates{}
