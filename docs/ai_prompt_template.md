# AI Prompt Template

Use this template when asking a UI agent to create or refactor a Flutter screen in this project.

## Full Template

```text
Create a new Flutter screen for [FEATURE NAME] in this project.

Goal:
- follow the project's existing design system
- reuse existing widgets before creating new ones
- keep the result consistent with the admin/dashboard UI style

Required rules:
- use `PortalMasterLayout`
- use `PageHeader` and `PortalFooter`
- prefer `AdaptiveWrap` for responsive section layouts when applicable
- follow the rules in `docs/ai_ui_rules.md`
- use `lib/ai_reference/` as the primary implementation reference
- prefer reusable widgets from:
  1. `lib/widgets/base_ui/`
  2. `lib/widgets/form/`
  3. `lib/widgets/portal_master_layout/`
- use tokens from `lib/constants/dimens.dart`
- use colors from `Theme.of(context).colorScheme` or `lib/theme/themes.dart`
- do not invent a new visual style for this screen
- do not place large mock data, models, dialogs, and section widgets inside the main screen file

Expected file structure:
- `screen.dart`
- `*_models.dart`
- `*_data.dart`
- `widgets/`
- `dialogs/` if the screen contains complex dialogs or form-heavy flows

Screen composition:
- page header with breadcrumb
- [N] summary cards / metrics
- [N] main content sections
- [N] table, chart, list, or detail panels
- responsive layout for desktop and mobile

Feature requirements:
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]

Data requirements:
- use local mock data for now
- structure the code so data can be replaced with API integration later

Implementation rules:
- keep the main screen focused on orchestration and composition
- extract reusable or large UI blocks into small widgets
- extract complex dialogs into `dialogs/`
- reuse existing base widgets whenever possible
- add a new route only if needed
- do not modify older demo screens unless explicitly requested

Output:
- implement the necessary files
- keep the code clean and maintainable
- preserve consistency with the project's existing UI system
```

## Short Template

```text
Create a new Flutter screen for [FEATURE NAME] using this project's existing design system.

Use:
- `PortalMasterLayout`
- `PageHeader`
- `PortalFooter`
- `AdaptiveWrap` for responsive section layout when appropriate
- reusable widgets from `lib/widgets/base_ui/`, `lib/widgets/form/`, and `lib/widgets/portal_master_layout/`
- `lib/ai_reference/` as the primary reference

Follow `docs/ai_ui_rules.md`.

Structure the implementation as:
- `screen.dart`
- `*_models.dart`
- `*_data.dart`
- `widgets/`
- `dialogs/` when needed

Do not create a giant single-file screen. Keep the screen orchestration-focused and move large sections, mock data, and dialogs into separate files.
```

## CRUD Screen Example

```text
Create a new Flutter admin CRUD screen for [FEATURE NAME].

Requirements:
- use `PortalMasterLayout`, `PageHeader`, and `PortalFooter`
- prefer `AdaptiveWrap` for the top summary and responsive section layout
- follow `docs/ai_ui_rules.md`
- use `lib/ai_reference/` as the main structural reference
- reuse existing buttons, badges, forms, dialogs, and table styles from the project

Screen should include:
- page header with breadcrumb
- 3-4 top summary metrics
- one main data table
- search/filter actions
- add dialog
- edit dialog
- delete confirmation dialog

Technical requirements:
- split into `screen`, `models`, `data`, `widgets`, and `dialogs`
- use local mock data
- keep styling aligned with the current admin UI
- avoid large inline widget trees in the main screen file
```

## Dashboard Screen Example

```text
Create a new Flutter dashboard screen for [FEATURE NAME].

Requirements:
- follow `docs/ai_ui_rules.md`
- use `PortalMasterLayout`
- use `PageHeader` and `PortalFooter`
- use `AdaptiveWrap` for responsive dashboard section composition when applicable
- use `lib/ai_reference/` as the main reference for structure
- reuse existing base widgets and chart/table helpers where possible

Screen should include:
- page header with breadcrumb
- 4 summary metric cards
- 2-3 insight sections
- at least one chart or data visualization
- one supporting table or activity list
- responsive behavior for desktop and mobile

Implementation rules:
- separate data, models, dialogs, and large widgets
- keep the main screen file orchestration-only
- do not create a new design language
```

## Refactor Prompt Example

```text
Refactor this Flutter screen to match the project's AI-friendly UI structure.

Goals:
- preserve the current UI behavior
- improve structure and reuse
- align with `docs/ai_ui_rules.md`
- use `lib/ai_reference/` as the reference structure

Refactor rules:
- keep the main `screen.dart` focused on layout composition
- move models into `*_models.dart`
- move mock data into `*_data.dart`
- move large sections into `widgets/`
- move complex dialogs and form flows into `dialogs/`
- replace ad-hoc UI with existing reusable widgets where possible
- do not change the project's design language
```

## Recommended Final Line

Add this line at the end of your prompt for stronger consistency:

```text
Use `lib/ai_reference/` as the primary reference and treat older demo screens only as secondary examples.
```
