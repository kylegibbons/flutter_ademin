# AI Reference

This folder contains the primary UI reference implementation for AI agents working in this project.

## Purpose

Use this folder to learn:

- the preferred structure for new screens
- how to compose screens using the existing design system
- how to separate screen orchestration, data, models, widgets, and dialogs
- how to reuse existing widgets from `lib/widgets/base_ui/`, `lib/widgets/form/`, and `lib/widgets/portal_master_layout/`

## What Agents Should Copy

Agents should copy these patterns from this folder:

- a small main `*_screen.dart` focused on orchestration
- separated `*_models.dart`
- separated `*_data.dart`
- large UI sections moved into `widgets/`
- form-heavy or complex dialogs moved into `dialogs/`

## What Agents Should Not Copy

Agents should not treat this folder as a place for low-level primitives.

Do not:

- move generic reusable widgets here if they belong in `lib/widgets/base_ui/`
- duplicate existing base widgets just for one screen

## Recommended Usage Order

When generating a screen:

1. Read `docs/ai_ui_rules.md`
2. Use `docs/ai_prompt_template.md`
3. Use this folder as the primary implementation reference
4. Validate the result with `docs/ai_screen_checklist.md`

## Scope

This folder is for reference implementations, not for every feature screen in the project.
