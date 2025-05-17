import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// A global scroll service that can be used across the entire app
/// for consistent scrolling behavior and animations.
class ScrollService extends GetxService {
  // Collection to store named scroll controllers for different screens
  final Map<String, ScrollController> _horizontalControllers = {};
  final Map<String, ScrollController> _verticalControllers = {};

  // Default animation durations and curves
  static const Duration defaultDuration = Duration(milliseconds: 500);
  static const Duration slowDuration = Duration(milliseconds: 800);
  static const Duration fastDuration = Duration(milliseconds: 300);
  static const Curve defaultCurve = Curves.easeInOut;

  /// Initialize the service with pre-defined controllers for common screens
  void init() {
    // Pre-register common screens
    registerScreen('subscription');
    registerScreen('home');
    registerScreen('profile');
    registerScreen('settings');
    // Add more screens as needed
  }

  /// Register controllers for a new screen
  void registerScreen(String screenName) {
    if (!_horizontalControllers.containsKey(screenName)) {
      _horizontalControllers[screenName] = ScrollController();
    }

    if (!_verticalControllers.containsKey(screenName)) {
      _verticalControllers[screenName] = ScrollController();
    }
  }

  /// Get a horizontal controller for a specific screen
  ScrollController getHorizontalController(String screenName) {
    if (!_horizontalControllers.containsKey(screenName)) {
      registerScreen(screenName);
    }
    return _horizontalControllers[screenName]!;
  }

  /// Get a vertical controller for a specific screen
  ScrollController getVerticalController(String screenName) {
    if (!_verticalControllers.containsKey(screenName)) {
      registerScreen(screenName);
    }
    return _verticalControllers[screenName]!;
  }

  /// Scroll to a specific position horizontally
  void scrollHorizontalTo({
    required String screenName,
    required double position,
    Duration? duration,
    Curve curve = defaultCurve,
  }) {
    final controller = getHorizontalController(screenName);
    if (!controller.hasClients) return;

    controller.animateTo(
      position,
      duration: duration ?? defaultDuration,
      curve: curve,
    );
  }

  /// Scroll to a specific position vertically
  void scrollVerticalTo({
    required String screenName,
    required double position,
    Duration? duration,
    Curve curve = defaultCurve,
  }) {
    final controller = getVerticalController(screenName);
    if (!controller.hasClients) return;

    controller.animateTo(
      position,
      duration: duration ?? defaultDuration,
      curve: curve,
    );
  }

  /// Scroll to the beginning of a horizontal list
  void scrollHorizontalToStart({
    required String screenName,
    Duration? duration,
    Curve curve = defaultCurve,
  }) {
    scrollHorizontalTo(
      screenName: screenName,
      position: 0,
      duration: duration,
      curve: curve,
    );
  }

  /// Scroll to the end of a horizontal list
  void scrollHorizontalToEnd({
    required String screenName,
    Duration? duration,
    Curve curve = defaultCurve,
  }) {
    final controller = getHorizontalController(screenName);
    if (!controller.hasClients) return;

    scrollHorizontalTo(
      screenName: screenName,
      position: controller.position.maxScrollExtent,
      duration: duration,
      curve: curve,
    );
  }

  /// Scroll to the top of a vertical list
  void scrollVerticalToTop({
    required String screenName,
    Duration? duration,
    Curve curve = defaultCurve,
  }) {
    scrollVerticalTo(
      screenName: screenName,
      position: 0,
      duration: duration,
      curve: curve,
    );
  }

  /// Scroll to the bottom of a vertical list
  void scrollVerticalToBottom({
    required String screenName,
    Duration? duration,
    Curve curve = defaultCurve,
  }) {
    final controller = getVerticalController(screenName);
    if (!controller.hasClients) return;

    scrollVerticalTo(
      screenName: screenName,
      position: controller.position.maxScrollExtent,
      duration: duration,
      curve: curve,
    );
  }

  /// Scroll to a specific item in a list with fixed item sizes
  void scrollHorizontalToItem({
    required String screenName,
    required int itemIndex,
    required double itemWidth,
    double itemSpacing = 0,
    Duration? duration,
    Curve curve = defaultCurve,
  }) {
    scrollHorizontalTo(
      screenName: screenName,
      position: (itemWidth + itemSpacing) * itemIndex,
      duration: duration,
      curve: curve,
    );
  }

  /// Scroll to a specific item in a vertical list with fixed item sizes
  void scrollVerticalToItem({
    required String screenName,
    required int itemIndex,
    required double itemHeight,
    double itemSpacing = 0,
    Duration? duration,
    Curve curve = defaultCurve,
  }) {
    scrollVerticalTo(
      screenName: screenName,
      position: (itemHeight + itemSpacing) * itemIndex,
      duration: duration,
      curve: curve,
    );
  }

  /// Schedule a scroll action with delay
  void scheduleScroll({
    required Function scrollAction,
    required int delayMilliseconds,
  }) {
    Future.delayed(Duration(milliseconds: delayMilliseconds), () {
      scrollAction();
    });
  }

  /// Chain multiple scroll actions with delays
  void chainScrollActions({
    required List<Function> actions,
    required List<int> delays,
  }) {
    if (actions.length != delays.length) {
      throw ArgumentError('Actions and delays must have the same length');
    }

    int cumulativeDelay = 0;
    for (int i = 0; i < actions.length; i++) {
      cumulativeDelay += delays[i];
      scheduleScroll(
        scrollAction: actions[i],
        delayMilliseconds: cumulativeDelay,
      );
    }
  }

  /// Dispose all controllers when service is closed
  @override
  void onClose() {
    _horizontalControllers.forEach((_, controller) => controller.dispose());
    _verticalControllers.forEach((_, controller) => controller.dispose());
    _horizontalControllers.clear();
    _verticalControllers.clear();
    super.onClose();
  }
}
