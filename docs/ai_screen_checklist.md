# AI Screen Checklist

Use this checklist before considering an AI-generated Flutter screen complete.

## Layout

- Uses `PortalMasterLayout` for admin/dashboard screens
- Uses `PageHeader`
- Uses `PortalFooter`
- Uses `AdaptiveWrap` for responsive multi-section or dashboard-style layouts when appropriate
- Follows the project's existing admin/dashboard layout style
- Works on both desktop and mobile layouts

## Design System

- Uses spacing, radius, heights, and breakpoints from `lib/constants/dimens.dart`
- Uses colors from `Theme.of(context).colorScheme` or `lib/theme/themes.dart`
- Reuses existing widgets before creating new ones
- Does not introduce a new visual language for a single screen

## Reuse

- Checked `lib/widgets/base_ui/` first
- Checked `lib/widgets/form/` if form-related
- Checked `lib/widgets/portal_master_layout/` if layout-related
- Checked `lib/ai_reference/` for reference structure and composition

## Structure

- Main `screen.dart` is focused on orchestration and composition
- Mock data is not kept in the main screen file
- Models are separated into `*_models.dart` when needed
- Sample data is separated into `*_data.dart` when needed
- Large UI sections are moved into `widgets/`
- Complex dialogs or form-heavy flows are moved into `dialogs/`

## UI Quality

- Text hierarchy feels consistent with the project
- Buttons and actions use existing button components
- Forms use existing form components
- Status indicators use existing reusable widgets where possible
- Tables and charts follow the project's existing style patterns

## Maintainability

- File names are clear and feature-oriented
- Widget responsibilities are easy to understand
- No giant single-file implementation unless explicitly justified
- No unnecessary duplication of existing reusable UI

## Final Validation

- The implementation follows `docs/ai_ui_rules.md`
- The prompt intent is fully addressed
- `lib/ai_reference/` was used as the primary structural reference
- Older demo screens were used only as secondary examples when needed
