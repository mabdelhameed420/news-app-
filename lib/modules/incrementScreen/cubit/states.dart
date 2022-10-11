
abstract class IncrementStates {

}

class IncrementInitialState extends IncrementStates{

}

class IncrementPlusState extends IncrementStates{
  final int counter;

  IncrementPlusState(this.counter);

}

class IncrementMinusState extends IncrementStates{
  final int counter;

  IncrementMinusState(this.counter);
}