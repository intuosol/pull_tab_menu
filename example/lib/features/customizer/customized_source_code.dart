import 'package:pull_tab_menu/pull_tab_menu.dart';

/// Helper class to generate source code
/// to display in the WidgetSnippet modal
class SourceCodeGenerator {
  SourceCodeGenerator._();

  /// Returns a string representation of the duration
  static String _getDurationAsString(
    Duration duration, {
    bool isSeconds = false,
  }) {
    if (isSeconds) {
      return 'Duration(seconds: ${duration.inSeconds})';
    }
    return 'Duration(milliseconds: ${duration.inMilliseconds})';
  }

  /// Returns a string representation of the configuration
  static String getConfigSourceCode({
    required PullTabMenuConfiguration configuration,
    required String showCurveAsString,
    required String hideCurveAsString,
    required String baseColorAsString,
    required String tabColorAsString,
    required String foregroundColorAsString,
  }) {
    // Define default values
    const PullTabMenuConfiguration defaultConfig = PullTabMenuConfiguration();

    // Start building the result string
    final StringBuffer buffer = StringBuffer();
    buffer.write('PullTabMenuConfiguration(');

    // Only include non-default values
    if (configuration.initialAlignment != defaultConfig.initialAlignment) {
      buffer.write('\n  initialAlignment: ${configuration.initialAlignment},');
    }

    if (configuration.axis != defaultConfig.axis) {
      buffer.write('\n  axis: ${configuration.axis},');
    }

    if (configuration.tabWidth != defaultConfig.tabWidth) {
      buffer.write('\n  tabWidth: ${configuration.tabWidth},');
    }

    if (configuration.tabHeight != defaultConfig.tabHeight) {
      buffer.write('\n  tabHeight: ${configuration.tabHeight},');
    }

    if (configuration.baseColor != defaultConfig.baseColor) {
      buffer.write('\n  baseColor: $baseColorAsString,');
    }

    if (configuration.tabColor != defaultConfig.tabColor) {
      buffer.write('\n  tabColor: $tabColorAsString,');
    }

    if (configuration.tabOpacity != defaultConfig.tabOpacity) {
      buffer.write('\n  tabOpacity: ${configuration.tabOpacity},');
    }

    if (configuration.menuOpacity != defaultConfig.menuOpacity) {
      buffer.write('\n  menuOpacity: ${configuration.menuOpacity},');
    }

    if (configuration.foregroundColor != defaultConfig.foregroundColor) {
      buffer.write('\n  foregroundColor: $foregroundColorAsString,');
    }

    if (configuration.autoHide != defaultConfig.autoHide) {
      buffer.write('\n  autoHide: ${configuration.autoHide},');
    }

    if (configuration.autoHideDelay != defaultConfig.autoHideDelay) {
      buffer.write(
        '\n  autoHideDelay: ${_getDurationAsString(configuration.autoHideDelay, isSeconds: true)},',
      );
    }

    if (configuration.showDuration != defaultConfig.showDuration) {
      buffer.write(
        '\n  showDuration: ${_getDurationAsString(configuration.showDuration)},',
      );
    }

    if (configuration.hideDuration != defaultConfig.hideDuration) {
      buffer.write(
        '\n  hideDuration: ${_getDurationAsString(configuration.hideDuration)},',
      );
    }

    if (configuration.showCurve != defaultConfig.showCurve) {
      buffer.write('\n  showCurve: Curves.$showCurveAsString,');
    }

    if (configuration.hideCurve != defaultConfig.hideCurve) {
      buffer.write('\n  hideCurve: Curves.$hideCurveAsString,');
    }

    if (configuration.borderRadius != defaultConfig.borderRadius) {
      buffer.write('\n  borderRadius: ${configuration.borderRadius},');
    }

    if (configuration.backgroundOverlayOpacity !=
        defaultConfig.backgroundOverlayOpacity) {
      buffer.write(
        '\n  backgroundOverlayOpacity: ${configuration.backgroundOverlayOpacity},',
      );
    }

    if (configuration.useBackgroundOverlay !=
        defaultConfig.useBackgroundOverlay) {
      buffer.write(
        '\n  useBackgroundOverlay: ${configuration.useBackgroundOverlay},',
      );
    }

    if (configuration.itemExtent != defaultConfig.itemExtent) {
      buffer.write('\n  itemExtent: ${configuration.itemExtent},');
    }

    if (configuration.menuBreadth != defaultConfig.menuBreadth) {
      buffer.write('\n  menuBreadth: ${configuration.menuBreadth},');
    }

    if (configuration.closeMenuOnTap != defaultConfig.closeMenuOnTap) {
      buffer.write('\n  closeMenuOnTap: ${configuration.closeMenuOnTap},');
    }

    if (configuration.allowRepositioning != defaultConfig.allowRepositioning) {
      buffer.write(
        '\n  allowRepositioning: ${configuration.allowRepositioning},',
      );
    }

    if (configuration.openOnTabHover != defaultConfig.openOnTabHover) {
      buffer.write('\n  openOnTabHover: ${configuration.openOnTabHover},');
    }

    if (configuration.selectedItemBackgroundColor !=
        defaultConfig.selectedItemBackgroundColor) {
      buffer.write(
        '\n  selectedItemBackgroundColor: ${configuration.selectedItemBackgroundColor},',
      );
    }

    if (configuration.selectedItemBorderColor !=
        defaultConfig.selectedItemBorderColor) {
      buffer.write(
        '\n  selectedItemBorderColor: ${configuration.selectedItemBorderColor},',
      );
    }

    if (configuration.margin != defaultConfig.margin) {
      buffer.write('\n  margin: ${configuration.margin},');
    }

    if (configuration.dividerThickness != defaultConfig.dividerThickness) {
      buffer.write('\n  dividerThickness: ${configuration.dividerThickness},');
    }

    if (configuration.dividerIndent != defaultConfig.dividerIndent) {
      buffer.write('\n  dividerIndent: ${configuration.dividerIndent},');
    }

    buffer.write('\n),');

    return buffer.toString();
  }
}
