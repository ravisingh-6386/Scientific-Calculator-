# Scientific Calculator App

A professional scientific calculator mobile application built with Flutter featuring a modern dark theme UI, real-time expression evaluation, and calculation history.

## Features

### 🎨 UI Design
- Modern Material Design interface
- Professional dark theme (iOS-inspired)
- Responsive grid layout
- Large, scrollable display for expressions and results
- Animated button press effects with ripple animations
- Color-coded buttons for different operations

### 🔢 Basic Operations
- **Arithmetic**: Addition (+), Subtraction (-), Multiplication (×), Division (÷)
- **Modulus**: Percentage (%)
- **Decimal**: Floating point numbers
- **Clear**: AC (All Clear) - Clears everything
- **Delete**: DEL - Removes last character/function

### 🧮 Scientific Functions
- **Trigonometric**: sin(), cos(), tan() (degree mode)
- **Logarithmic**: log() (base-10), ln() (natural logarithm)
- **Root**: sqrt() (square root)
- **Power**: x² (square), x^y (custom power)
- **Constants**: π (pi), e (Euler's number)
- **Parentheses**: ( ) for grouping expressions

### ⚡ Functionality
- Real-time expression display
- Type full mathematical expressions
- Press "=" to evaluate
- Error handling (division by zero, invalid expressions)
- Support for complex nested expressions
- Implicit multiplication (e.g., 2π automatically becomes 2×π)

### 📊 Extra Features
- **History**: View last 50 calculations
- **Copy Result**: One-tap copy to clipboard
- **Clear History**: Remove all saved calculations
- **Timestamps**: Each calculation is timestamped
- **Responsive Display**: Auto-scrolling for long expressions

## Project Structure

```
lib/
├── main.dart                          # App entry point with Provider setup
├── screens/
│   ├── calculator_screen.dart         # Main calculator UI
│   └── history_screen.dart            # Calculation history screen
├── widgets/
│   └── calculator_button.dart         # Reusable button widget
├── providers/
│   └── calculator_provider.dart       # State management with Provider
└── utils/
    └── calculation_logic.dart         # Expression parsing and evaluation
```

## Architecture

### Clean Architecture Principles
- **Separation of Concerns**: UI, business logic, and state management are separated
- **Reusable Components**: Modular widget design
- **State Management**: Provider pattern for reactive UI updates
- **Single Responsibility**: Each file has a specific purpose

### State Management (Provider)
The app uses the Provider package for state management:
- `CalculatorProvider`: Manages calculator state, expression, result, and history
- Notifies listeners when state changes
- Provides methods for all calculator operations

### Components

#### 1. Main Entry Point (`main.dart`)
- Initializes the app
- Sets up Provider
- Locks orientation to portrait
- Applies dark theme

#### 2. Calculator Screen (`calculator_screen.dart`)
- Main UI layout
- Display area for expression and result
- Button grid (8 rows with scientific functions and number pad)
- Navigation to history screen
- Copy result functionality

#### 3. History Screen (`history_screen.dart`)
- Displays list of past calculations
- Shows timestamp, expression, and result
- Copy individual results
- Clear all history option
- Dialog for calculation details

#### 4. Calculator Button (`calculator_button.dart`)
- Reusable button widget
- Animated press effect using AnimationController
- Color-coded by button type
- Scale animation on press
- Shadow effects

#### 5. Calculator Provider (`calculator_provider.dart`)
- Manages expression building
- Handles all operations (add, delete, clear)
- Evaluates expressions
- Maintains calculation history
- Provides state to UI

#### 6. Calculation Logic (`calculation_logic.dart`)
- Parses mathematical expressions
- Evaluates using math_expressions package
- Handles special characters (×, ÷, π, ²)
- Error handling
- Result formatting
- Implicit multiplication

## Button Types & Color Coding

| Button Type | Color | Examples |
|-------------|-------|----------|
| Number | Dark Gray (#333333) | 0-9, . |
| Operator | Orange (#FF9500) | +, -, ×, ÷, = |
| Function | Medium Gray (#505050) | sin, cos, tan, log, ln, sqrt, x², x^y |
| Special | Medium Gray (#505050) | π, e, (, ) |
| Clear | Light Gray (#A5A5A5) | AC |
| Delete | Light Gray (#A5A5A5) | DEL |

## Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  provider: ^6.1.1          # State management
  math_expressions: ^2.4.0  # Expression parsing and evaluation
  cupertino_icons: ^1.0.6   # iOS-style icons
  intl: ^0.18.1             # Date formatting for history
```

## Installation & Setup

1. **Prerequisites**
   - Flutter SDK (3.0.0 or higher)
   - Dart SDK (3.0.0 or higher)
   - Android Studio / VS Code with Flutter plugins

2. **Clone or Download**
   ```bash
   # Navigate to project directory
   cd calculator
   ```

3. **Install Dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the App**
   ```bash
   # Run on connected device/emulator
   flutter run
   
   # Run in release mode for better performance
   flutter run --release
   ```

5. **Build APK (Android)**
   ```bash
   flutter build apk --release
   ```

6. **Build iOS**
   ```bash
   flutter build ios --release
   ```

## Usage Guide

### Basic Calculations
1. Tap number buttons to build expression
2. Tap operator buttons (+, -, ×, ÷)
3. Press "=" to calculate result

### Scientific Functions
1. Tap function button (sin, cos, tan, etc.)
2. Enter value inside parentheses
3. Close parentheses if needed
4. Press "=" to calculate

Example: `sin(30)` → Result: `0.5`

### Complex Expressions
Build nested expressions with parentheses:
- `(2+3)×(4+5)` → Result: `45`
- `sqrt(16)+2^3` → Result: `12`
- `2π×5` → Result: `31.415926...`

### History
1. Tap history icon (top-right)
2. View past calculations
3. Tap any calculation to see details
4. Tap copy icon to copy result
5. Tap delete icon to clear all history

### Error Handling
The calculator displays error messages for:
- Division by zero → "Error: Division by zero"
- Invalid expressions → "Error: Invalid expression"
- Invalid operations → "Error: Invalid operation"

## Code Comments

All code files include detailed comments explaining:
- Class purposes and responsibilities
- Method functionality
- Complex logic sections
- Widget properties and parameters
- State management flow

## Customization

### Change Theme Colors
Edit colors in [main.dart](lib/main.dart):
```dart
colorScheme: const ColorScheme.dark(
  primary: Color(0xFFFF9500),    // Orange accent
  secondary: Color(0xFF505050),  // Medium gray
  background: Color(0xFF000000), // Black background
  surface: Color(0xFF1C1C1C),    // Dark gray surface
),
```

### Modify Button Colors
Edit `_getBackgroundColor()` in [calculator_button.dart](lib/widgets/calculator_button.dart):
```dart
case ButtonType.operator:
  return const Color(0xFFFF9500); // Change operator color
```

### Change Button Layout
Modify button grid in [calculator_screen.dart](lib/screens/calculator_screen.dart):
```dart
_buildButtonGrid(BuildContext context) {
  // Add or rearrange buttons here
}
```

### Add New Functions
1. Add function to [calculation_logic.dart](lib/utils/calculation_logic.dart)
2. Add button case in [calculator_provider.dart](lib/providers/calculator_provider.dart)
3. Add button to UI in [calculator_screen.dart](lib/screens/calculator_screen.dart)

## Performance Optimizations

- **Lazy Loading**: History items are built on-demand
- **Const Constructors**: Used where possible for better performance
- **Provider Selectors**: Only rebuild widgets that need updates
- **SingleTickerProviderStateMixin**: Efficient animations
- **ScrollController**: Optimized scrolling for long expressions

## Testing

Run tests with:
```bash
flutter test
```

## Known Limitations

- Trigonometric functions use degrees (not radians)
- Maximum history: 50 items
- Very long expressions may overflow display
- Scientific notation for extremely large/small numbers

## Future Enhancements

- [ ] Toggle between degrees and radians
- [ ] Landscape mode with extended functions
- [ ] Custom themes
- [ ] Memory functions (M+, M-, MR, MC)
- [ ] Calculation export/share
- [ ] Voice input
- [ ] Unit conversions
- [ ] Graphing capabilities

## License

This project is open source and available for personal and commercial use.

## Support

For issues, questions, or contributions, please refer to the repository documentation.

---

**Built with ❤️ using Flutter**
