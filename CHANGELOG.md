## 0.2.2

- Revised package description and screenshots

## 0.2.1

Bug fixes:

- Fixed issue with automatic assigning of the menu axis based on item count

## 0.2.0

Breaking changes and significant improvements:

- **Breaking**: Renamed `itemSize` to `itemExtent` for better semantics
- **Breaking**: Renamed `allowDragging` to `allowRepositioning` for clarity
- **Breaking**: Renamed `verticalPadding` to `margin` for consistency
- **Breaking**: Renamed `useOverlay` to `useBackgroundOverlay` for clarity
- **Breaking**: Renamed `overlayOpacity` to `backgroundOverlayOpacity` for clarity
- **Breaking**: Replaced `animationDuration` and `animationCurve` with separate show/hide animation parameters (`showDuration`, `showCurve`, `hideDuration`, `hideCurve`)
- **Breaking**: Removed `elevation` and `maxMenuHeightFactor` parameters
- Fixed automatic menu positioning and edge detection
- Improved menu item rendering and tooltip positioning
- Enhanced animation control with separate show/hide animation parameters

## 0.1.1

Bug fixes and enhancements:

- Replaced TabPosition with new MenuAlignment enum offering six positioning options
- Fixed automatic menu positioning and edge detection
- Fixed menu animation when sliding in/out
- Fixed issue with the assigned menu axis not overriding the default axis
- Improved menu item rendering and tooltip positioning
- Removed dependency on shared_preferences

## 0.1.0

Initial release of the Pull Tab Menu package with the following features:

- Edge-anchored pull tab with customizable appearance
- Multiple menu positions (centerLeft, centerRight, topLeft, topRight, bottomLeft, bottomRight)
- Slide-out menu with smooth animations
- Support for both vertical and horizontal menu layouts
- Menu items with icons, tooltips, and tap actions
- Built-in divider support
- Material Design 3 theme integration
- Auto-hide functionality with configurable delay
- Configurable animations (duration and curves)
- Gesture-based interactions (tap, swipe, drag)
- Hover interactions for desktop/web platforms
- Optional background overlay
- Smart automatic layout selection based on item count
- Programmatic control via controller
- Customizable colors, opacity, and dimensions
- Elevation and border radius styling options
