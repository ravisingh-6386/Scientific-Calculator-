# Scientific Calculator - Project Structure

## Complete Folder Structure

```
calculator/
│
├── lib/
│   ├── main.dart                          # Application entry point
│   │                                      # - Sets up Provider
│   │                                      # - Configures dark theme
│   │                                      # - Locks portrait orientation
│   │
│   ├── screens/
│   │   ├── calculator_screen.dart         # Main calculator interface
│   │   │                                  # - Display area (expression & result)
│   │   │                                  # - Button grid layout
│   │   │                                  # - Copy result functionality
│   │   │                                  # - Navigation to history
│   │   │
│   │   └── history_screen.dart            # Calculation history
│   │                                      # - List of past calculations
│   │                                      # - Timestamp display
│   │                                      # - Copy individual results
│   │                                      # - Clear history option
│   │
│   ├── widgets/
│   │   └── calculator_button.dart         # Reusable button component
│   │                                      # - Animated press effect
│   │                                      # - Color-coded by type
│   │                                      # - Ripple effect
│   │                                      # - Shadow effects
│   │
│   ├── providers/
│   │   └── calculator_provider.dart       # State management (Provider)
│   │                                      # - Expression management
│   │                                      # - Result calculation
│   │                                      # - History tracking
│   │                                      # - State notifications
│   │
│   └── utils/
│       └── calculation_logic.dart         # Core calculation engine
│                                          # - Expression parsing
│                                          # - Mathematical evaluation
│                                          # - Error handling
│                                          # - Result formatting
│
├── pubspec.yaml                           # Project dependencies
│                                          # - provider: State management
│                                          # - math_expressions: Expression parsing
│                                          # - intl: Date formatting
│
├── analysis_options.yaml                  # Dart/Flutter linting rules
├── .gitignore                             # Git ignore configuration
└── README.md                              # Project documentation
```

## File Responsibilities

### Core Application
- **main.dart** (52 lines)
  - MaterialApp setup
  - Provider initialization
  - Theme configuration
  - Orientation lock

### Screens
- **calculator_screen.dart** (275 lines)
  - Main UI layout
  - Display component (expression + result)
  - 8-row button grid
  - Scientific function buttons
  - Number pad
  - Copy functionality
  - History navigation

- **history_screen.dart** (255 lines)
  - History list view
  - Calculation cards
  - Timestamp formatting
  - Copy individual results
  - Clear all history
  - Empty state UI

### Widgets
- **calculator_button.dart** (150 lines)
  - Stateful widget with animation
  - Button type enum (7 types)
  - Color coding logic
  - Press animation (scale + shadow)
  - Ripple effect
  - Dynamic sizing for wide buttons

### State Management
- **calculator_provider.dart** (155 lines)
  - ChangeNotifier implementation
  - Expression state
  - Result state
  - History list (max 50 items)
  - CRUD operations for expression
  - Calculation trigger
  - History management

### Business Logic
- **calculation_logic.dart** (220 lines)
  - Expression evaluation
  - String parsing
  - Operator replacement (×→*, ÷→/)
  - Implicit multiplication
  - Percentage handling
  - Error handling
  - Result formatting
  - Validation logic

## Data Flow

```
User Input → Calculator Button
            ↓
Calculator Screen → Provider (addToExpression)
            ↓
Provider updates expression state
            ↓
UI reflects change (Consumer rebuilds)
            ↓
User presses "=" → Provider (calculate)
            ↓
Provider calls Calculation Logic
            ↓
Calculation Logic evaluates expression
            ↓
Result returned to Provider
            ↓
Provider updates result + adds to history
            ↓
UI displays result (Consumer rebuilds)
```

## State Management Pattern

```
CalculatorProvider (ChangeNotifier)
    ↓
notifyListeners()
    ↓
Consumer<CalculatorProvider> in UI
    ↓
Widget rebuilds with new state
```

## Button Types & Components

### Number Buttons (11)
`0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `.`

### Operator Buttons (5)
`+`, `-`, `×`, `÷`, `%`

### Equals Button (1)
`=`

### Clear/Delete Buttons (2)
`AC`, `DEL`

### Scientific Function Buttons (8)
`sin`, `cos`, `tan`, `log`, `ln`, `sqrt`, `x²`, `x^y`

### Special Character Buttons (4)
`π`, `e`, `(`, `)`

**Total: 31 buttons**

## Key Features Implementation

### 1. Real-time Expression Display
- Provider stores current expression
- Consumer rebuilds on every change
- Horizontal scroll for long expressions

### 2. Error Handling
```dart
try {
  // Parse and evaluate
} catch (e) {
  return 'Error: Invalid expression';
}
```

### 3. History Management
- List<CalculationHistory> in Provider
- Max 50 items (FIFO)
- Timestamp with each calculation
- Persistent during app session

### 4. Animation System
- AnimationController for button press
- Scale animation (1.0 → 0.95)
- Duration: 100ms
- Curve: easeInOut

### 5. Copy to Clipboard
```dart
Clipboard.setData(ClipboardData(text: result));
```

## Color Scheme

```dart
Background:    #000000 (Black)
Surface:       #1C1C1C (Dark Gray)
Number:        #333333 (Medium Dark Gray)
Function:      #505050 (Medium Gray)
Operator:      #FF9500 (Orange)
Clear/Delete:  #A5A5A5 (Light Gray)
Text:          #FFFFFF (White)
Secondary Text:#AAAAAA (Light Gray)
Error:         #FF0000 (Red)
```

## Dependencies Overview

| Package | Version | Purpose |
|---------|---------|---------|
| provider | ^6.1.1 | State management |
| math_expressions | ^2.4.0 | Expression parsing |
| intl | ^0.18.1 | Date/time formatting |
| cupertino_icons | ^1.0.6 | iOS-style icons |

## Build Commands

```bash
# Install dependencies
flutter pub get

# Run in debug mode
flutter run

# Run in release mode
flutter run --release

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Analyze code
flutter analyze

# Run tests
flutter test
```

## Code Statistics

- **Total Files**: 11
- **Total Lines of Code**: ~1,400+
- **Dart Files**: 8
- **Configuration Files**: 3
- **Documentation Files**: 2

## Best Practices Implemented

✅ Clean Architecture (separation of concerns)
✅ Provider pattern for state management
✅ Reusable widget components
✅ Comprehensive error handling
✅ Responsive UI design
✅ Material Design guidelines
✅ Code comments and documentation
✅ Consistent naming conventions
✅ Proper file organization
✅ Git-ready project structure
