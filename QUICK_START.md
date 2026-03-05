# 🚀 Quick Start Guide

## Get Started in 3 Steps

### 1️⃣ Install Dependencies
```bash
flutter pub get
```

### 2️⃣ Run the App
```bash
flutter run
```

### 3️⃣ Start Calculating!
The app will launch on your connected device or emulator.

---

## 📱 How to Use

### Basic Calculations
1. **Enter numbers** by tapping number buttons (0-9)
2. **Add operators** (+, -, ×, ÷)
3. **Press =** to get result

**Example**: `5 + 3 × 2` → Press `=` → Result: `11`

### Scientific Functions
1. **Tap function button** (sin, cos, tan, log, ln, sqrt)
2. **Enter value** in parentheses
3. **Press =** to calculate

**Examples**:
- `sin(30)` → `0.5`
- `sqrt(16)` → `4`
- `log(100)` → `2`

### Using Constants
- **π (Pi)**: Tap `π` button → `3.14159...`
- **e (Euler)**: Tap `e` button → `2.71828...`

**Examples**:
- `2π` → `6.28318...`
- `e^2` → Tap `e`, `^`, `2`, `=` → `7.389...`

### Advanced Expressions
Build complex expressions with parentheses:

**Examples**:
- `(2+3)×(4+5)` → `45`
- `sqrt(2^2 + 3^2)` → `3.605...`
- `sin(45)+cos(45)` → `1.414...`

---

## 🎯 Button Guide

### Number Pad
```
7️⃣ 8️⃣ 9️⃣ ➗
4️⃣ 5️⃣ 6️⃣ ✖️
1️⃣ 2️⃣ 3️⃣ ➖
0️⃣ . ➕ 🟰
```

### Scientific Functions (Top Rows)
```
sin  cos  tan  ln
log  √x   x²   x^y
π    e    (    )
```

### Control Buttons
- **AC**: Clear everything
- **DEL**: Delete last character
- **=**: Calculate result

---

## 📊 Using History

1. **Open History**: Tap 🕐 icon (top-right)
2. **View Calculations**: Scroll through past calculations
3. **Copy Result**: Tap 📋 icon next to any result
4. **Clear History**: Tap 🗑️ icon (top-right) → Confirm

---

## 💡 Tips & Tricks

### Tip 1: Auto Multiplication
No need to add × between number and π, e, or parentheses:
- Type `2π` instead of `2×π`
- Type `2(3+4)` instead of `2×(3+4)`

### Tip 2: Chain Calculations
After pressing `=`, you can:
- **Add operator** to continue from result
- **Type number** to start fresh calculation

### Tip 3: Delete Mistakes
- **DEL**: Removes last character/function
- **AC**: Clears everything (like reset)

### Tip 4: Copy Results
Two ways to copy:
1. Main screen: Tap 📋 icon next to result
2. History screen: Tap 📋 icon on any calculation

---

## ⚠️ Error Messages

| Error | Meaning | Solution |
|-------|---------|----------|
| `Error: Division by zero` | Tried to divide by 0 | Avoid dividing by zero |
| `Error: Invalid expression` | Expression can't be calculated | Check syntax and parentheses |
| `Error: Invalid operation` | Unsupported operation | Review expression |

---

## 🎨 Color Guide

| Color | Button Type | Examples |
|-------|-------------|----------|
| 🟠 **Orange** | Operators & Equals | +, -, ×, ÷, = |
| ⬛ **Dark Gray** | Numbers | 0-9, . |
| ⬜ **Medium Gray** | Functions | sin, cos, tan, π, e |
| 🔘 **Light Gray** | Clear/Delete | AC, DEL |

---

## 🏗️ Building for Production

### Android APK
```bash
flutter build apk --release
```
APK location: `build/app/outputs/flutter-apk/app-release.apk`

### iOS App
```bash
flutter build ios --release
```

---

## 🐛 Troubleshooting

### App won't run?
```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Run again
flutter run
```

### Expression not evaluating?
- Check for matching parentheses: `(` and `)`
- Ensure operators are between numbers
- Use DEL or AC to fix mistakes

### History not showing?
- History appears after first calculation
- Tap 🕐 icon (top-right of calculator screen)
- Maximum 50 calculations saved

---

## 📚 Learn More

- **Full Documentation**: See [README.md](README.md)
- **Project Structure**: See [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md)
- **Flutter Docs**: https://flutter.dev

---

## 🎓 Example Calculations

Try these to test all features:

1. **Basic Math**: `15 + 7 × 2` = `29`
2. **Percentage**: `50 + 20%` = `50.2`
3. **Trigonometry**: `sin(30) + cos(60)` = `1.0`
4. **Logarithm**: `ln(e^2)` = `2`
5. **Power**: `2^10` = `1024`
6. **Square Root**: `sqrt(144)` = `12`
7. **Complex**: `(5+3)×sqrt(16)÷2` = `16`
8. **With π**: `2πr` where r=5 → `2π×5` = `31.415...`

---

**Happy Calculating! 🎉**
