# AI UI Rules

## Core Goal

Build new screens from the existing design system. Do not invent a new visual language for one feature.

## Layout

- Admin and dashboard pages must use `PortalMasterLayout`.
- Page structure should be:
  1. `PageHeader`
  2. content sections
  3. `PortalFooter`
- Prefer `AdaptiveWrap` for responsive multi-card, multi-section, and dashboard-style layouts before writing custom `Row`/`Column` responsive branching.
- Use project breakpoints from `lib/constants/dimens.dart` when configuring `AdaptiveWrap`.
- Check `lib/ai_reference/` before inventing a new screen composition.

## Styling

- Always use values from `lib/constants/dimens.dart` for spacing, heights, radius, and breakpoints.
- Always read colors from `Theme.of(context).colorScheme` or the shared theme tokens in `lib/theme/themes.dart`.
- Do not hardcode font families, random spacing, or ad-hoc radius values if a token already exists.

Before creating a new widget, search in this order:

  1. `lib/widgets/base_ui/`
  2. `lib/widgets/form/`
  3. `lib/widgets/portal_master_layout/`
  4. `lib/ai_reference/`

Prefer existing reusable widgets from these sources.

Common reusable examples:

- Buttons: `FlatButton`, `CustomOutlinedButton`, `CustomIconButton`
- Forms: `CustomTextFormField`, `CustomTextField`, `FormLabel`
- Status UI: `CustomBadge`
- Layout shell: `PortalMasterLayout`, `PageHeader`, `PortalFooter`
- Tables: `TableStyle`

## File Structure

New feature screens should follow this structure when practical:

- `screen.dart`
- `models/` or `*_models.dart`
- `data/` or `*_data.dart`
- `widgets/`
- `dialogs/` when dialog logic is non-trivial

Keep mock data, view models, and large dialogs out of the main screen file.

## References

- Treat `lib/ai_reference/` as the primary reference source for AI-generated screens.
- Read `lib/ai_reference/README.md` together with the reference files in that folder.
- Use it to learn the preferred structure:
  - screen orchestration in `*_screen.dart`
  - sample data in `*_data.dart`
  - models in `*_models.dart`
  - large sections in `widgets/`
  - form-heavy flows in `dialogs/`
- Use demo screens outside `lib/ai_reference/` only as secondary references for content ideas or domain examples.
- Do not copy large legacy demo screens as-is when creating a new feature screen.

## Reuse

- If a widget is generic and reusable across many features, prefer placing or reusing it from `lib/widgets/base_ui/`.
- If a widget is form-specific, prefer `lib/widgets/form/`.
- If a widget is specific to app shell layout, prefer `lib/widgets/portal_master_layout/`.
- Treat `lib/ai_reference/` as reference implementation, not as a folder for low-level primitives.

## Behavior

- Keep screen widgets focused on orchestration and composition.
- Move reusable UI blocks into small widgets.
- Move formatting helpers and fake data outside the screen widget.
- Keep dialog widgets isolated when they exceed a few controls or contain validation logic.

## Do

- reuse project tokens
- reuse existing base widgets
- preserve visual consistency
- compose from existing references and primitives first
- keep files small and purpose-driven

## Do Not

- create a brand-new visual language for one screen
- hardcode large inline data in the screen file
- mix routing, layout, dialogs, models, and tables into one large file
- bypass existing theme or component primitives without a strong reason

## Primary Example

Use the AI reference implementation in `lib/ai_reference/` as the primary reference shape for future AI-generated admin screens.
