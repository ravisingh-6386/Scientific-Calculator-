import 'package:flutter/material.dart';
import '../utils/calculation_logic.dart';

/// Model for calculation history
class CalculationHistory {
  final String expression;
  final String result;
  final DateTime timestamp;

  CalculationHistory({
    required this.expression,
    required this.result,
    required this.timestamp,
  });
}

/// Provider for managing calculator state
class CalculatorProvider with ChangeNotifier {
  // Current expression being built
  String _expression = '';

  // Current result displayed
  String _result = '0';

  // History of calculations
  final List<CalculationHistory> _history = [];

  // Whether the last operation was equals
  bool _lastOperationWasEquals = false;

  // Getters
  String get expression => _expression;
  String get result => _result;
  List<CalculationHistory> get history => List.unmodifiable(_history);
  bool get hasHistory => _history.isNotEmpty;

  /// Adds a character or function to the expression
  void addToExpression(String value) {
    // If last operation was equals, start fresh with operators or continue with numbers
    if (_lastOperationWasEquals) {
      if ('+-×÷'.contains(value)) {
        // Continue from previous result
        _expression = _result + value;
      } else {
        // Start fresh
        _expression = value;
      }
      _lastOperationWasEquals = false;
    } else {
      // Validate if character can be added
      if (CalculationLogic.canAddCharacter(_expression, value)) {
        _expression += value;
      }
    }

    notifyListeners();
  }

  /// Deletes the last character from the expression
  void deleteLast() {
    if (_expression.isNotEmpty) {
      // Handle multi-character deletions (functions like sin, cos, etc.)
      if (_expression.endsWith('sin(')) {
        _expression = _expression.substring(0, _expression.length - 4);
      } else if (_expression.endsWith('cos(')) {
        _expression = _expression.substring(0, _expression.length - 4);
      } else if (_expression.endsWith('tan(')) {
        _expression = _expression.substring(0, _expression.length - 4);
      } else if (_expression.endsWith('log(')) {
        _expression = _expression.substring(0, _expression.length - 4);
      } else if (_expression.endsWith('ln(')) {
        _expression = _expression.substring(0, _expression.length - 3);
      } else if (_expression.endsWith('sqrt(')) {
        _expression = _expression.substring(0, _expression.length - 5);
      } else {
        // Delete single character
        _expression = _expression.substring(0, _expression.length - 1);
      }

      _lastOperationWasEquals = false;
      notifyListeners();
    }
  }

  /// Clears all (AC button)
  void clearAll() {
    _expression = '';
    _result = '0';
    _lastOperationWasEquals = false;
    notifyListeners();
  }

  /// Evaluates the current expression
  void calculate() {
    if (_expression.isNotEmpty) {
      String calculationResult = CalculationLogic.evaluateExpression(
        _expression,
      );

      // Add to history if result is valid
      if (!calculationResult.startsWith('Error')) {
        _history.insert(
          0,
          CalculationHistory(
            expression: _expression,
            result: calculationResult,
            timestamp: DateTime.now(),
          ),
        );

        // Keep only last 50 calculations
        if (_history.length > 50) {
          _history.removeRange(50, _history.length);
        }
      }

      _result = calculationResult;
      _lastOperationWasEquals = true;
      notifyListeners();
    }
  }

  /// Adds a specific mathematical function
  void addFunction(String function) {
    switch (function) {
      case 'sin':
        addToExpression('sin(');
        break;
      case 'cos':
        addToExpression('cos(');
        break;
      case 'tan':
        addToExpression('tan(');
        break;
      case 'log':
        addToExpression('log(');
        break;
      case 'ln':
        addToExpression('ln(');
        break;
      case 'sqrt':
        addToExpression('sqrt(');
        break;
      case 'π':
        addToExpression('π');
        break;
      case 'e':
        addToExpression('e');
        break;
      case 'x²':
        addToExpression('²');
        break;
      case 'x^y':
        addToExpression('^');
        break;
      case '(':
        addToExpression('(');
        break;
      case ')':
        addToExpression(')');
        break;
    }
  }

  /// Clears calculation history
  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  /// Returns the current result or expression display
  String getDisplayText() {
    if (_expression.isEmpty) {
      return _result;
    }
    return _expression;
  }

  /// Copies result to clipboard
  String getResultForCopy() {
    return _result;
  }
}
