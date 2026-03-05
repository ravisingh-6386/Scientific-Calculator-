import 'package:flutter/material.dart';

/// Enum for button types to determine styling
enum ButtonType {
  number, // 0-9 and decimal point
  operator, // +, -, ×, ÷
  function, // sin, cos, tan, etc.
  equals, // = button
  clear, // AC button
  delete, // DEL button
  special, // π, e, parentheses
}

/// Reusable calculator button widget with animations
class CalculatorButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final bool isWide;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.number,
    this.isWide = false,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Returns the background color based on button type
  Color _getBackgroundColor() {
    switch (widget.type) {
      case ButtonType.number:
        return const Color(0xFF333333);
      case ButtonType.operator:
        return const Color(0xFFFF9500);
      case ButtonType.function:
        return const Color(0xFF505050);
      case ButtonType.equals:
        return const Color(0xFFFF9500);
      case ButtonType.clear:
        return const Color(0xFFA5A5A5);
      case ButtonType.delete:
        return const Color(0xFFA5A5A5);
      case ButtonType.special:
        return const Color(0xFF505050);
    }
  }

  /// Returns the text color based on button type
  Color _getTextColor() {
    switch (widget.type) {
      case ButtonType.number:
        return Colors.white;
      case ButtonType.operator:
        return Colors.white;
      case ButtonType.function:
        return Colors.white;
      case ButtonType.equals:
        return Colors.white;
      case ButtonType.clear:
        return Colors.black;
      case ButtonType.delete:
        return Colors.black;
      case ButtonType.special:
        return Colors.white;
    }
  }

  /// Returns appropriate font size based on text length
  double _getFontSize() {
    if (widget.text.length > 4) {
      return 18.0;
    } else if (widget.text.length > 2) {
      return 20.0;
    }
    return 24.0;
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _isPressed
                ? _getBackgroundColor().withValues(alpha: 0.7)
                : _getBackgroundColor(),
            borderRadius: BorderRadius.circular(widget.isWide ? 40 : 50),
            boxShadow: _isPressed
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: _getFontSize(),
                fontWeight: FontWeight.w400,
                color: _getTextColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
