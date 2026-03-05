import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';

/// Calculator logic for parsing and evaluating mathematical expressions
class CalculationLogic {
  /// Evaluates a mathematical expression and returns the result
  /// Returns an error message if the expression is invalid
  static String evaluateExpression(String expression) {
    try {
      if (expression.isEmpty) {
        return '0';
      }

      // Prepare the expression for evaluation
      String preparedExpression = _prepareExpression(expression);

      // Parse the expression using GrammarParser
      GrammarParser parser = GrammarParser();
      Expression exp = parser.parse(preparedExpression);

      // Create context with variables
      ContextModel contextModel = ContextModel();
      contextModel.bindVariable(Variable('e'), Number(math.e));
      contextModel.bindVariable(Variable('π'), Number(math.pi));

      // Evaluate the expression
      double result = exp.evaluate(EvaluationType.REAL, contextModel);

      // Check for special cases
      if (result.isNaN) {
        return 'Error: Invalid operation';
      }
      if (result.isInfinite) {
        return 'Error: Division by zero';
      }

      // Format the result
      return _formatResult(result);
    } catch (e) {
      return 'Error: Invalid expression';
    }
  }

  /// Prepares the expression for evaluation by replacing functions and operators
  static String _prepareExpression(String expression) {
    String prepared = expression;

    // Replace × with *
    prepared = prepared.replaceAll('×', '*');

    // Replace ÷ with /
    prepared = prepared.replaceAll('÷', '/');

    // Replace π with pi (handled by context variable)
    // Note: Keep π as is, it will be handled by context variable

    // Handle implicit multiplication (e.g., 2π becomes 2*π)
    prepared = _addImplicitMultiplication(prepared);

    // Handle percentage
    prepared = _handlePercentage(prepared);

    // Replace sqrt with sqrt function
    prepared = prepared.replaceAllMapped(
      RegExp(r'sqrt\((.*?)\)'),
      (match) => 'sqrt(${match.group(1)})',
    );

    // Handle square (x²)
    prepared = prepared.replaceAllMapped(
      RegExp(r'(\d+\.?\d*)²'),
      (match) => '(${match.group(1)})^2',
    );

    return prepared;
  }

  /// Adds implicit multiplication where needed
  static String _addImplicitMultiplication(String expression) {
    String result = expression;

    // Add * between number and π
    result = result.replaceAllMapped(
      RegExp(r'(\d)π'),
      (match) => '${match.group(1)}*π',
    );

    // Add * between number and e
    result = result.replaceAllMapped(
      RegExp(r'(\d)e(?![0-9])'),
      (match) => '${match.group(1)}*e',
    );

    // Add * between ) and (
    result = result.replaceAll(')(', ')*(');

    // Add * between number and (
    result = result.replaceAllMapped(
      RegExp(r'(\d)\('),
      (match) => '${match.group(1)}*(',
    );

    // Add * between ) and number
    result = result.replaceAllMapped(
      RegExp(r'\)(\d)'),
      (match) => ')*${match.group(1)}',
    );

    return result;
  }

  /// Handles percentage calculations
  static String _handlePercentage(String expression) {
    // Convert percentage to decimal (e.g., 50% becomes 0.5)
    return expression.replaceAllMapped(
      RegExp(r'(\d+\.?\d*)%'),
      (match) => '(${match.group(1)}/100)',
    );
  }

  /// Formats the result to remove unnecessary decimals
  static String _formatResult(double result) {
    // If the result is an integer, display it without decimals
    if (result == result.toInt()) {
      return result.toInt().toString();
    }

    // Otherwise, display with up to 10 decimal places, removing trailing zeros
    String formatted = result.toStringAsFixed(10);
    formatted = formatted.replaceAll(RegExp(r'\.?0+$'), '');

    // Check if result is too long
    if (formatted.length > 15) {
      // Use scientific notation
      return result.toStringAsExponential(6);
    }

    return formatted;
  }

  /// Calculates sine (in degrees)
  static double sine(double value) {
    return math.sin(value * math.pi / 180);
  }

  /// Calculates cosine (in degrees)
  static double cosine(double value) {
    return math.cos(value * math.pi / 180);
  }

  /// Calculates tangent (in degrees)
  static double tangent(double value) {
    return math.tan(value * math.pi / 180);
  }

  /// Calculates natural logarithm
  static double naturalLog(double value) {
    return math.log(value);
  }

  /// Calculates base-10 logarithm
  static double log10(double value) {
    return math.log(value) / math.log(10);
  }

  /// Calculates square root
  static double squareRoot(double value) {
    return math.sqrt(value);
  }

  /// Calculates power
  static double power(double base, double exponent) {
    return math.pow(base, exponent).toDouble();
  }

  /// Validates if a character can be added to the expression
  static bool canAddCharacter(String expression, String character) {
    if (expression.isEmpty) {
      // Can start with number, minus, or opening parenthesis
      return character.contains(RegExp(r'[\d\-\(]')) ||
          character == 'sin(' ||
          character == 'cos(' ||
          character == 'tan(' ||
          character == 'log(' ||
          character == 'ln(' ||
          character == 'sqrt(' ||
          character == 'π' ||
          character == 'e';
    }

    String lastChar = expression[expression.length - 1];

    // Prevent consecutive operators
    if ('+-×÷'.contains(lastChar) && '+-×÷'.contains(character)) {
      return false;
    }

    // Prevent multiple decimal points in the same number
    if (character == '.' && lastChar == '.') {
      return false;
    }

    return true;
  }
}
