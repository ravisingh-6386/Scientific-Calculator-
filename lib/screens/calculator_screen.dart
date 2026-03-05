import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../widgets/calculator_button.dart';
import 'history_screen.dart';

/// Main calculator screen with display and buttons
class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Scientific Calculator',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        actions: [
          // History button
          Consumer<CalculatorProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.history),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryScreen(),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Display area
          Expanded(flex: 2, child: _buildDisplay(context)),
          // Button grid
          Expanded(flex: 5, child: _buildButtonGrid(context)),
        ],
      ),
    );
  }

  /// Builds the display area showing expression and result
  Widget _buildDisplay(BuildContext context) {
    return Consumer<CalculatorProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Expression display
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Text(
                  provider.expression.isEmpty ? '0' : provider.expression,
                  style: const TextStyle(
                    fontSize: 32,
                    color: Color(0xFFAAAAAA),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Result display with copy button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Copy button
                  if (provider.result != '0' &&
                      !provider.result.startsWith('Error'))
                    IconButton(
                      icon: const Icon(
                        Icons.copy,
                        size: 20,
                        color: Color(0xFF808080),
                      ),
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(text: provider.getResultForCopy()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Result copied to clipboard'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color(0xFF505050),
                          ),
                        );
                      },
                    ),
                  // Result text
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      reverse: true,
                      child: Text(
                        provider.result,
                        style: TextStyle(
                          fontSize: 56,
                          color: provider.result.startsWith('Error')
                              ? Colors.red
                              : Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds the button grid with all calculator buttons
  Widget _buildButtonGrid(BuildContext context) {
    final provider = Provider.of<CalculatorProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Scientific functions row 1
          Expanded(
            child: Row(
              children: [
                _buildButton(context, 'sin', ButtonType.function, () {
                  provider.addFunction('sin');
                }),
                _buildButton(context, 'cos', ButtonType.function, () {
                  provider.addFunction('cos');
                }),
                _buildButton(context, 'tan', ButtonType.function, () {
                  provider.addFunction('tan');
                }),
                _buildButton(context, 'ln', ButtonType.function, () {
                  provider.addFunction('ln');
                }),
              ],
            ),
          ),
          // Scientific functions row 2
          Expanded(
            child: Row(
              children: [
                _buildButton(context, 'log', ButtonType.function, () {
                  provider.addFunction('log');
                }),
                _buildButton(context, 'sqrt', ButtonType.function, () {
                  provider.addFunction('sqrt');
                }),
                _buildButton(context, 'x²', ButtonType.function, () {
                  provider.addFunction('x²');
                }),
                _buildButton(context, 'x^y', ButtonType.function, () {
                  provider.addFunction('x^y');
                }),
              ],
            ),
          ),
          // Special characters row
          Expanded(
            child: Row(
              children: [
                _buildButton(context, 'π', ButtonType.special, () {
                  provider.addFunction('π');
                }),
                _buildButton(context, 'e', ButtonType.special, () {
                  provider.addFunction('e');
                }),
                _buildButton(context, '(', ButtonType.special, () {
                  provider.addFunction('(');
                }),
                _buildButton(context, ')', ButtonType.special, () {
                  provider.addFunction(')');
                }),
              ],
            ),
          ),
          // Clear and operators row
          Expanded(
            child: Row(
              children: [
                _buildButton(context, 'AC', ButtonType.clear, () {
                  provider.clearAll();
                }),
                _buildButton(context, 'DEL', ButtonType.delete, () {
                  provider.deleteLast();
                }),
                _buildButton(context, '%', ButtonType.operator, () {
                  provider.addToExpression('%');
                }),
                _buildButton(context, '÷', ButtonType.operator, () {
                  provider.addToExpression('÷');
                }),
              ],
            ),
          ),
          // Number row 1
          Expanded(
            child: Row(
              children: [
                _buildButton(context, '7', ButtonType.number, () {
                  provider.addToExpression('7');
                }),
                _buildButton(context, '8', ButtonType.number, () {
                  provider.addToExpression('8');
                }),
                _buildButton(context, '9', ButtonType.number, () {
                  provider.addToExpression('9');
                }),
                _buildButton(context, '×', ButtonType.operator, () {
                  provider.addToExpression('×');
                }),
              ],
            ),
          ),
          // Number row 2
          Expanded(
            child: Row(
              children: [
                _buildButton(context, '4', ButtonType.number, () {
                  provider.addToExpression('4');
                }),
                _buildButton(context, '5', ButtonType.number, () {
                  provider.addToExpression('5');
                }),
                _buildButton(context, '6', ButtonType.number, () {
                  provider.addToExpression('6');
                }),
                _buildButton(context, '-', ButtonType.operator, () {
                  provider.addToExpression('-');
                }),
              ],
            ),
          ),
          // Number row 3
          Expanded(
            child: Row(
              children: [
                _buildButton(context, '1', ButtonType.number, () {
                  provider.addToExpression('1');
                }),
                _buildButton(context, '2', ButtonType.number, () {
                  provider.addToExpression('2');
                }),
                _buildButton(context, '3', ButtonType.number, () {
                  provider.addToExpression('3');
                }),
                _buildButton(context, '+', ButtonType.operator, () {
                  provider.addToExpression('+');
                }),
              ],
            ),
          ),
          // Bottom row with 0 and equals
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CalculatorButton(
                    text: '0',
                    onPressed: () {
                      provider.addToExpression('0');
                    },
                    type: ButtonType.number,
                    isWide: true,
                  ),
                ),
                _buildButton(context, '.', ButtonType.number, () {
                  provider.addToExpression('.');
                }),
                _buildButton(context, '=', ButtonType.equals, () {
                  provider.calculate();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to build a single button
  Widget _buildButton(
    BuildContext context,
    String text,
    ButtonType type,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: CalculatorButton(text: text, onPressed: onPressed, type: type),
    );
  }
}
