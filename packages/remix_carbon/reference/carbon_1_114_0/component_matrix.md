# Carbon 1.114.0 component comparison

This is the human-readable view of `manifest.json`. It defines the package's
scope: every listed family has a Carbon public API, public export, focused test
and interactive catalog example. Internal reuse is selected by behavior and semantics; it
does not add the corresponding Remix API to Carbon's public surface.

## Implementation strategies

| Strategy | Meaning |
| --- | --- |
| `remix_recipe` | A generated Carbon wrapper restyles an equivalent Remix behavior primitive. |
| `remix_adapter` | A Carbon-facing contract adapts a related Remix component. |
| `carbon_composite` | Multiple Remix primitives compose one Carbon component. |
| `carbon_native` | Carbon behavior has no safe one-to-one Remix equivalent. |
| `mix_chart_recipe` | A Carbon chart wrapper applies Carbon data-visualization tokens to `mix_chart`. |

## Complete mapping

| Carbon family | Public Carbon API | Strategy | Reused implementation |
| --- | --- | --- | --- |
| `accordion` | `CarbonAccordionGroup`, `CarbonAccordion` | `remix_recipe` | `RemixAccordionGroup`, `RemixAccordion` |
| `ai_label` | `CarbonAiLabel` | `carbon_composite` | `RemixPopover` |
| `breadcrumb` | `CarbonBreadcrumb`, `CarbonBreadcrumbItem` | `carbon_native` | Carbon-native |
| `button` | `CarbonButton`, `CarbonIconButton` | `remix_recipe` | `RemixButton`, `RemixIconButton` |
| `checkbox` | `CarbonCheckbox`, `CarbonCheckboxGroup`, `CarbonCheckboxGroupItem` | `remix_recipe` | `RemixCheckbox`, `RemixCheckboxGroup`, `RemixCheckboxGroupItem` |
| `code_snippet` | `CarbonCodeSnippet` | `carbon_native` | Carbon-native |
| `contained_list` | `CarbonContainedList`, `CarbonContainedListItem` | `carbon_native` | Carbon-native |
| `content_switcher` | `CarbonContentSwitcher` | `remix_recipe` | `RemixSegmentedControl` |
| `data_table` | `CarbonDataTable` | `remix_adapter` | `RemixDataTable` |
| `date_picker` | `CarbonDatePicker`, `CarbonDateRangePicker` | `carbon_native` | Carbon-native |
| `dropdown` | `CarbonDropdown` | `remix_adapter` | `RemixSelect` |
| `file_uploader` | `CarbonFileUploader`, `CarbonFileUploadItem` | `carbon_native` | Carbon-native |
| `form` | `CarbonForm`, `CarbonFormGroup` | `carbon_native` | Carbon-native |
| `inline_loading` | `CarbonInlineLoading` | `carbon_composite` | `RemixSpinner` |
| `link` | `CarbonLink` | `carbon_native` | Carbon-native |
| `list` | `CarbonUnorderedList`, `CarbonOrderedList`, `CarbonListItem` | `carbon_native` | Carbon-native |
| `loading` | `CarbonLoading` | `remix_recipe` | `RemixSpinner` |
| `menu` | `CarbonMenu` | `remix_recipe` | `RemixMenu` |
| `menu_button` | `CarbonMenuButton`, `CarbonOverflowMenu` | `carbon_composite` | `RemixButton`, `RemixIconButton`, `RemixMenu` |
| `modal` | `CarbonModal`, `showCarbonModal`, `showCarbonAlertModal` | `remix_adapter` | `RemixDialog`, `showRemixDialog`, `showRemixAlertDialog` |
| `multiselect` | `CarbonMultiselect` | `carbon_native` | Carbon-native |
| `notification` | `CarbonNotification` | `remix_adapter` | `RemixCallout` |
| `number_input` | `CarbonNumberInput` | `carbon_composite` | `RemixTextField`, `RemixIconButton` |
| `pagination` | `CarbonPagination` | `carbon_native` | Carbon-native |
| `popover` | `CarbonPopover` | `remix_recipe` | `RemixPopover` |
| `progress_bar` | `CarbonProgressBar` | `remix_recipe` | `RemixProgress` |
| `progress_indicator` | `CarbonProgressIndicator`, `CarbonProgressStep` | `carbon_native` | Carbon-native |
| `radio_button` | `CarbonRadioButton`, `CarbonRadioButtonGroup` | `remix_recipe` | `RemixRadio`, `RemixRadioGroup` |
| `search` | `CarbonSearch` | `carbon_composite` | `RemixTextField` |
| `select` | `CarbonSelect`, `CarbonSelectItem`, `CarbonSelectItemGroup` | `remix_adapter` | `RemixSelect` |
| `slider` | `CarbonSlider` | `remix_recipe` | `RemixSlider` |
| `structured_list` | `CarbonStructuredList`, `CarbonStructuredListRow`, `CarbonStructuredListCell` | `carbon_native` | Carbon-native |
| `tabs` | `CarbonTabs`, `CarbonTabBar`, `CarbonTab`, `CarbonTabView` | `remix_recipe` | `RemixTabs`, `RemixTabBar`, `RemixTab`, `RemixTabView` |
| `tag` | `CarbonTag` | `remix_adapter` | `RemixBadge` |
| `text_input` | `CarbonTextInput`, `CarbonTextArea`, `CarbonPasswordInput` | `remix_recipe` | `RemixTextField`, `RemixTextArea` |
| `tile` | `CarbonTile`, `CarbonClickableTile`, `CarbonSelectableTile`, `CarbonExpandableTile` | `remix_adapter` | `RemixCard` |
| `toggle` | `CarbonToggle` | `remix_recipe` | `RemixSwitch` |
| `toggletip` | `CarbonToggletip` | `carbon_composite` | `RemixPopover` |
| `tooltip` | `CarbonTooltip` | `remix_recipe` | `RemixTooltip` |
| `tree_view` | `CarbonTreeView`, `CarbonTreeNode` | `carbon_native` | Carbon-native |
| `ui_shell` | `CarbonUiShell`, `CarbonHeader`, `CarbonSideNav` | `carbon_native` | Carbon-native |
| `bar_chart` | `CarbonBarChart` | `mix_chart_recipe` | `mix_chart` |
| `line_chart` | `CarbonLineChart` | `mix_chart_recipe` | `mix_chart` |
| `pie_chart` | `CarbonPieChart` | `mix_chart_recipe` | `mix_chart` |

## Explicitly excluded Remix families

| Remix family | Why it is not a Carbon component here |
| --- | --- |
| Avatar | No component in the official Carbon core catalog. |
| Badge | Carbon Tag has narrower labeling semantics and its own adapter. |
| Card | Carbon Tile has explicit interaction variants and its own adapter. |
| Data List | Carbon Contained List and Structured List use different row contracts. |
| Divider | Carbon uses contextual border tokens rather than a standalone core divider. |
| Skeleton | Carbon exposes component skeleton states and dedicated skeleton primitives, not a one-to-one catalog family. |
| Toggle Button | Remix Toggle is a selected pressable; Carbon Toggle uses switch semantics. |
| Toggle Group | Carbon Content Switcher reuses segmented-control behavior without exposing a duplicate family. |

## Pinned source

- `@carbon/react` 1.114.0
- `@carbon/styles` 1.113.0
- Carbon commit `188d23202ec1092322dee92cf0df9d9958224ae4`
- Snapshot date 2026-08-13

The exact source files, integrity hashes and semantic primitive for each family
remain in `manifest.json` so automated parity tests can detect catalog drift.
