# remix_ui_icons

`remix_ui_icons` provides the complete 318-glyph Radix Icons 1.3.2 catalog as a
Flutter icon font. Every glyph is a static `IconData` constant, allowing
Flutter release builds to subset the font to the icons an application uses.

```dart
import 'package:flutter/widgets.dart';
import 'package:remix_ui_icons/remix_ui_icons.dart';

const icon = Icon(RemixIcons.check);
```

There is deliberately no runtime name-to-icon map on `RemixIcons` itself,
because dynamic lookup would keep the full catalog reachable. Catalogs,
galleries, and drift tests that must enumerate every glyph can opt into the
separate index:

```dart
import 'package:remix_ui_icons/icons_index.dart';

final icon = remixIconsByName['check'];
```

The `shadow`, `shadowInner`, `shadowNone`, `shadowOuter`, and
`transparencyGrid` glyphs approximate Radix's partial opacity as opaque
coverage. The other 313 glyphs are lossless conversions.
