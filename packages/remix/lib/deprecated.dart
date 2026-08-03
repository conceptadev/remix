/// Deprecated Remix APIs retained for source compatibility.
library;

import 'src/components/button/button.dart' show ButtonStyler;
import 'src/components/menu/menu.dart'
    show MenuItemStyler, MenuStyler, MenuTriggerStyler;

/// Use `ButtonStyler` instead.
@Deprecated('Use ButtonStyler instead.')
typedef RemixButtonStyler = ButtonStyler;

/// Use `MenuStyler` instead.
@Deprecated('Use MenuStyler instead.')
typedef RemixMenuStyler = MenuStyler;

/// Use `MenuTriggerStyler` instead.
@Deprecated('Use MenuTriggerStyler instead.')
typedef RemixMenuTriggerStyler = MenuTriggerStyler;

/// Use `MenuItemStyler` instead.
@Deprecated('Use MenuItemStyler instead.')
typedef RemixMenuItemStyler = MenuItemStyler;
