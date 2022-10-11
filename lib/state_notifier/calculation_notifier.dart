import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

abstract class CalculationState {
  const CalculationState();

  String getMathFormula();
}

class CalculationInitialState extends CalculationState {
  final String mathFormula;

  const CalculationInitialState(this.mathFormula);

  @override
  String getMathFormula() {
    return mathFormula;
  }
}

class CalculationLoadingState extends CalculationState {
  const CalculationLoadingState();

  @override
  String getMathFormula() {
    throw UnimplementedError();
  }
}

class CalculationLoadedState extends CalculationState {
  final String mathFormula;
  CalculationLoadedState(this.mathFormula);

  @override
  String getMathFormula() {
    return mathFormula;
  }
}

class CalculationErrorState extends CalculationState {
  String errorMessage;
  CalculationErrorState(this.errorMessage);

  @override
  String getMathFormula() {
    throw UnimplementedError();
  }
}

final calculationNotifierProvider = StateNotifierProvider((ref) {
  return CalculationStateNotifier();
});

class CalculationStateNotifier extends StateNotifier<CalculationState> {
  CalculationStateNotifier() : super(const CalculationInitialState("0"));

  void addToInput(String input) {
    if (state is CalculationInitialState) {
      state = CalculationLoadedState("");
    }
    String oldInput = state.getMathFormula();
    oldInput = oldInput + input;
    print(oldInput);
    state = CalculationLoadedState(oldInput);
  }

  double equals() {
    String mathFormula = state.getMathFormula();
    String newMathFormula = mathFormula.replaceAll(",", ".");

    Parser p = Parser();
    Expression exp = p.parse(newMathFormula);

    ContextModel cm = ContextModel();

    double result = exp.evaluate(EvaluationType.REAL, cm);

    String resultWithComa = result.toString().replaceAll(".", ",");
    state = CalculationLoadedState(resultWithComa);

    return result;
  }

  void deleteAll() {
    state = const CalculationInitialState("0");
  }

  void setInit() {
    state = const CalculationInitialState("0");
  }

  void back() {
    String oldInput = state.getMathFormula();
    String newInput = oldInput.substring(0, oldInput.length - 1);
    if (newInput.isEmpty) {
      state = const CalculationInitialState("0");
    } else {
      state = CalculationLoadedState(newInput);
    }
  }
}
