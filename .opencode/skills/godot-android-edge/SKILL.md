---
name: godot-android-edge
description: Godot 4 development ON the Android edge — on-device editor, GABE exports, renderer constraints, packaging, permissions, and hardware support. Load when working with engine tooling, project settings, exports, or Android-specific behavior.
---

# GODOT ANDROID EDGE DEVELOPMENT (BV-SKILL-001)

## NAME
GODOT ANDROID EDGE DEVELOPMENT

## PURPOSE
Make BLACK VECTOR development correct and safe specifically on the Android tablet developer toolchain and Android target devices — where the editor, the renderer contracts, and the device realities differ from desktop.

## WHEN TO LOAD
- Creating or editing the Godot project, `project.godot`, renderer settings, export presets, or GABE packaging.
- Any work involving the on-device Android editor or GDExtension plugins.
- Performance, packaging, or device-behavior questions on Android.

## DO NOT LOAD WHEN
- Pure methodology/documentation work (use governing set only).
- Desktop-focused analysis; the Android toolchain has no bearing there.

## PRECONDITIONS
- Governing set loaded (Developer's Way, project doctrine, SOP-001/002/005).
- Authoritative docs consulted where this skill's constraints are applied (docs.godotengine.org, godotengine.org).

## GOVERNING INVARIANTS
1. The Android editor is Early Access/streamlined: no Mono/C#, no external script editors, OpenGL 3+ required on the device.
2. Forward+ rendering on the Android editor and Android targets is FORBIDDEN (severe perf limits). Initial renderer target: GL Compatibility (BV-D001); Mobile renderer only behind the documented upgrade gate with device evidence.
3. On-device packaging: GABE (Godot Android Build Environment) enables full Gradle export (AAB/APK) on-device including GDExtension plugins; non-Gradle in-editor exports exist without GABE.
4. All-files access permission is required for broad access; on Android Go, create projects under Android Documents/Downloads to reach all-files permission reliably.
5. Godot 4.5 supports 16 KB page size (Android 15+ / 2025 Play requirement) — keep this true; do not break it with hand-rolled native builds.
6. Always test renderer fallback assumptions on-device: the Vulkan→D3D12→GL fallback chain is not reliable on mobile; the manifest/export profile matters.
7. GDScript is first-class on the Android editor; auth concerns are none (offline), but keep content local.

## WORKFLOW
1. Confirm which target of the chain you are touching: editor host, engine runtime, export packaging, or device.
2. Consult authoritative docs for the specific setting (renderer, export, permission, page-size) before changing it.
3. Apply the smallest change; re-verify references and settings (SOP-003).
4. Label all claims: desktop validation is not device proof (SOP-005).

## IMPLEMENTATION GUIDANCE
- Renderer note: Forward+ = desktop only. Mobile = Vulkan/D3D12/Metal, half-float → strong tablet perf. Compatibility/GL = OpenGL, widest driver reach, no compute shaders, no normal-roughness buffer, no VRS/DOF/decals, depth pre-pass default. Choose by evidence, not by habit.
- In-editor on-device UX is tablet-oriented (TouchActionsPanel); script editing is in-engine only.
- Multi-monitor/desktop-only features (e.g., remote debugger sessions) are not a given on the Android editor — verify before depending on them.
- Content under Electron GUIs, cloud, accounts, telemetry: prohibited by product identity.

## ANTI-PATTERNS
- Setting `rendering_method` without checking renderer contracts or device profile.
- Assuming the Vulkan fallback will rescue a wrong manifest on device.
- Carrying over NOMADIC CREED project settings into BLACK VECTOR (separate project, separate config; a fact noted, never reused).
- Treating desktop editor behavior as Android editor behavior.

## KNOWN FAILURE MODES
- Editor/build tool failures on-device (gradle, GABE) → use GABE log/console evidence; never guess from exit codes alone.
- Renderer mismatch causing black/invalid output on some GPUs → validate on the actual device family; record device + driver.
- Export missing all-files permission on Android Go → relocate project to Documents/Downloads.

## VERIFICATION
- Static: settings match the doctrine decision (BV-D001) and authoritative docs.
- Device: packaging and rendering validated on the target tablet before any runtime claim (SOP-005; pending debt otherwise).

## STOP CONDITIONS
If an engine/tool constraint is unclear from authoritative docs, or a device profile contradicts the renderer default, STOP and re-confirm the decision with evidence before proceeding.

## PERFORMANCE
- Budget-facing: keep runtime costs within SOP-004 budgets; on-device editor perf is not a runtime metric.

## DEVICE
- All runtime verification against actual tablet hardware; record device model + GPU/driver when it matters.

## DEPENDENCIES
- Authoritative docs (docs.godotengine.org: Android editor, renderers; godotengine.org GABE article), GABE app on device, Godot 4.5+.

## RELATED SKILLS
- BV-SKILL-014 mobile-graphics-atmosphere (renderer contracts in depth)
- SOP-003 godot-change-procedure; SOP-004 mobile-performance
- developers-way (governing)