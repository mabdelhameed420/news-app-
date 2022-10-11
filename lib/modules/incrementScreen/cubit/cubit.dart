
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/modules/incrementScreen/cubit/states.dart';

class IncrementCubit extends Cubit<IncrementStates>{

  IncrementCubit() : super(IncrementInitialState());

  static IncrementCubit get(context) => BlocProvider.of(context);

  var counter = 1;

  void minus(){
    counter--;
    emit(IncrementMinusState(counter));
  }

  void plus(){
    counter++;
    emit(IncrementPlusState(counter));
  }
}