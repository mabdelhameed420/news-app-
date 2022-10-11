
abstract class AppStates {}

class InitialAppState extends AppStates{}

class AppChangeNavScreens extends AppStates{}

class AppCreateDatabaseState extends AppStates{}

class AppInsertDatabaseState extends AppStates{}

class AppGetDatabaseState extends AppStates{}

class AppUpdateDatabaseState extends AppStates{}

class AppDeleteDatabaseState extends AppStates{}


class AppGetDatabaseLoadingState extends AppStates{}

class AppChangeButtonSheet extends AppStates{}

class AppCheckButtonState extends AppStates{}