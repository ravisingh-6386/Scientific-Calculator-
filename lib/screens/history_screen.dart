import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import 'package:intl/intl.dart';

/// Screen displaying calculation history
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Calculation History',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
        ),
        actions: [
          Consumer<CalculatorProvider>(
            builder: (context, provider, child) {
              return provider.hasHistory
                  ? IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () {
                        _showClearHistoryDialog(context, provider);
                      },
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<CalculatorProvider>(
        builder: (context, provider, child) {
          if (!provider.hasHistory) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, size: 80, color: Colors.grey[700]),
                  const SizedBox(height: 16),
                  Text(
                    'No calculation history',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: provider.history.length,
            itemBuilder: (context, index) {
              final item = provider.history[index];
              return _buildHistoryItem(context, item, provider);
            },
          );
        },
      ),
    );
  }

  /// Builds a single history item card
  Widget _buildHistoryItem(
    BuildContext context,
    CalculationHistory item,
    CalculatorProvider provider,
  ) {
    final timeFormat = DateFormat('MMM dd, yyyy - HH:mm');

    return Card(
      color: const Color(0xFF1C1C1C),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          _showHistoryItemDialog(context, item);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Timestamp
              Text(
                timeFormat.format(item.timestamp),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              // Expression
              Text(
                item.expression,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFAAAAAA),
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 4),
              // Divider
              const Divider(color: Color(0xFF505050), height: 16),
              // Result with copy button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '= ${item.result}',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.copy,
                      size: 20,
                      color: Color(0xFF808080),
                    ),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: item.result));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Result copied to clipboard'),
                          duration: Duration(seconds: 1),
                          backgroundColor: Color(0xFF505050),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Shows dialog with full history item details
  void _showHistoryItemDialog(BuildContext context, CalculationHistory item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Calculation Details',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Expression:',
              style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              item.expression,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Result:',
              style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              item.result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: item.result));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Result copied to clipboard'),
                  duration: Duration(seconds: 1),
                  backgroundColor: Color(0xFF505050),
                ),
              );
            },
            child: const Text(
              'Copy Result',
              style: TextStyle(color: Color(0xFFFF9500)),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Close',
              style: TextStyle(color: Color(0xFFFF9500)),
            ),
          ),
        ],
      ),
    );
  }

  /// Shows confirmation dialog for clearing history
  void _showClearHistoryDialog(
    BuildContext context,
    CalculatorProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Clear History',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to clear all calculation history?',
          style: TextStyle(color: Color(0xFFAAAAAA), fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF808080)),
            ),
          ),
          TextButton(
            onPressed: () {
              provider.clearHistory();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('History cleared'),
                  duration: Duration(seconds: 1),
                  backgroundColor: Color(0xFF505050),
                ),
              );
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
