# Remix Widget Preview 🎨

Flutter Widget Preview integration for Remix components, providing an interactive browser-based preview environment for rapid development and testing.

## Prerequisites

- **Flutter 3.44.0** through FVM (the stable version pinned in `.fvmrc`)
- **Chrome browser** (required for widget preview)
- Widget preview is an experimental feature - APIs may change

## Quick Start

### Option 1: Use the Script (Recommended)
```bash
cd packages/demo
./scripts/preview.sh
```

### Option 2: Direct Command
```bash
cd packages/demo
fvm flutter widget-preview start
```

### Option 3: Clean and Start
```bash
cd packages/demo
fvm flutter widget-preview clean
fvm flutter widget-preview start
```

## What's Included

### 📋 Form Components
- **Checkbox States**: Unchecked, checked, disabled states
- **Switch States**: On/off states with enabled/disabled variants
- **Radio Group**: Multiple options with selection state
- **Text Fields**: Basic, with icons, password field, disabled state
- **Slider Examples**: Different values and disabled state
- **Select Dropdown**: Dropdown with multiple options

### 🎛️ Layout Components  
- **Cards**: Basic card, with actions, profile card, stats dashboard
- **Buttons**: Basic buttons, states, icon-only, variations

## How It Works

1. **Start Command**: Launches a local web server
2. **Chrome Opens**: Automatically opens preview environment 
3. **Interactive Sidebar**: Lists all `@Preview` annotated functions
4. **Live Updates**: Hot reload when you save changes
5. **Responsive**: Each preview has defined viewport size

## Preview Structure

```
packages/demo/lib/previews/
├── preview_helper.dart      # Shared helper function
├── button_preview.dart      # Button component previews  
├── card_preview.dart        # Card component previews
└── form_preview.dart        # Form component previews
```

## Adding New Previews

### 1. Create Preview Function
```dart
@Preview(name: 'My Widget Example', size: Size(400, 300))
Widget previewMyWidget() {
  return createRemixPreview(
    MyRemixWidget(
      // Configure your widget
    ),
  );
}
```

### 2. Use the Helper
Always use `createRemixPreview()` helper to ensure:
- Proper Remix theming and tokens
- Material design context
- Consistent background and centering
- Debug banner disabled

### 3. Size Guidelines
- **Forms**: `Size(350-400, 200-400)` depending on content
- **Cards**: `Size(400, 250-400)` for readability
- **Buttons**: `Size(300-400, 150-300)` based on layout
- **Complex Layouts**: `Size(500, 400+)` for more space

## Technical Details

### Preview Helper Function
```dart
Widget createRemixPreview(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Builder(
      builder: (context) => FortalScope(
        brightness: Theme.of(context).brightness,
        child: Scaffold(
          backgroundColor: MixColors.grey[50],
          body: Center(child: child),
        ),
      ),
    ),
  );
}
```

### Key Features
- **Remix Tokens**: Full access to design system tokens
- **Theme Support**: Automatic light/dark theme handling
- **Hot Reload**: Changes reflect immediately
- **No Interaction**: Uses empty callbacks for preview safety
- **Consistent Styling**: All previews use same wrapper

## Browser Environment

### Supported
✅ Chrome (primary browser)  
✅ Hot reload and live updates  
✅ Responsive viewport controls  
✅ Zoom and inspection tools

### Not Supported  
❌ Native platform APIs  
❌ dart:io library  
❌ Platform-specific plugins  
❌ IDE integration (browser only)

## Troubleshooting

### Port Already in Use
If you see port conflicts:
```bash
fvm flutter widget-preview clean
fvm flutter widget-preview start
```

### Chrome Not Opening
Manually navigate to: `http://localhost:9000` (or port shown in terminal)

### Hot Reload Not Working
1. Ensure you're saving files in the preview directory
2. Check terminal for any error messages
3. Try refreshing the browser page

### Widget Not Appearing
1. Verify `@Preview` annotation is properly imported
2. Check that function returns a Widget
3. Ensure all required parameters are constant/public

## Performance Tips

- Keep preview functions lightweight
- Use `const` constructors where possible  
- Avoid expensive computations in previews
- Limit preview count per file for faster loading

## Contributing

When adding new component previews:

1. **Follow naming convention**: `preview[ComponentName][Variant]()`
2. **Add descriptive names**: Clear preview names in annotations
3. **Show multiple states**: Demonstrate different configurations
4. **Use proper sizing**: Choose appropriate viewport dimensions
5. **Test thoroughly**: Verify previews load correctly

## Useful Commands

```bash
# Clean preview cache
flutter widget-preview clean

# Check Flutter version
fvm flutter --version

# View available Flutter commands
fvm flutter help

# Check widget preview help
fvm flutter widget-preview --help
```

---

**Note**: Widget Preview is experimental. Expect changes in future Flutter releases.
