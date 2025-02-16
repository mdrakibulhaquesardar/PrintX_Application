import '/resources/widgets/buttons/partials/transparency_button_widget.dart';
import '/resources/widgets/buttons/partials/secondary_button_widget.dart';
import '/resources/widgets/buttons/partials/primary_button_widget.dart';
import '/resources/widgets/buttons/partials/text_only_button_widget.dart';
import '/resources/widgets/buttons/partials/gradient_button_widget.dart';
import '/resources/widgets/buttons/partials/rounded_button_widget.dart';
import '/resources/widgets/buttons/partials/outlined_button_widget.dart' as app;
import '/resources/widgets/buttons/partials/icon_button_widget.dart' as app;
import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class Button {
  /// Primary button
  static Widget primary({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? color,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return PrimaryButton(
            text: text,
            onPressed: pressed,
            color: color,
            width: width,
            height: height,
          );
        });
  }

  /// Secondary button
  static Widget secondary({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? color,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return SecondaryButton(
            text: text,
            onPressed: pressed,
            color: color,
            width: width,
            height: height,
          );
        });
  }

  /// Outlined button
  static Widget outlined({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? borderColor,
    Color? textColor,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
      onSubmit: (onPressed, submitForm),
      onFailure: onFailure,
      showToastError: showToastError,
      loadingStyle: loadingStyle,
      child: (pressed) {
        return app.OutlinedButton(
          text: text,
          onPressed: pressed,
          borderColor: borderColor,
          textColor: textColor,
          width: width,
          height: height,
        );
      },
    );
  }

  /// Text only button
  static Widget textOnly({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? textColor,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return TextOnlyButton(
            text: text,
            onPressed: pressed,
            textColor: textColor,
            width: width,
            height: height,
          );
        });
  }

  /// Icon button
  static Widget icon({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    required Widget icon,
    Color? color,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
      onSubmit: (onPressed, submitForm),
      onFailure: onFailure,
      showToastError: showToastError,
      loadingStyle: loadingStyle,
      child: (pressed) {
        return app.IconButton(
          text: text,
          onPressed: pressed,
          icon: icon,
          color: color,
          width: width,
          height: height,
        );
      },
    );
  }

  /// Gradient button
  static Widget gradient({
    required String text,
    VoidCallback? onPressed,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    (dynamic, Function(dynamic data))? submitForm,
    List<Color> gradientColors = const [Colors.blue, Colors.purple],
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return GradientButton(
            text: text,
            onPressed: pressed,
            gradientColors: gradientColors,
            width: width,
            height: height,
          );
        });
  }

  /// Rounded button
  static Widget rounded({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? color,
    BorderRadius? borderRadius,
    double? width,
    double height = 50,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return RoundedButton(
            text: text,
            onPressed: pressed,
            color: color,
            borderRadius: borderRadius,
            width: width,
            height: height,
          );
        });
  }

  /// Transparency button
  static Widget transparency({
    required String text,
    VoidCallback? onPressed,
    (dynamic, Function(dynamic data))? submitForm,
    Function(dynamic error)? onFailure,
    bool showToastError = true,
    Color? color,
    BorderRadius? borderRadius,
    double? width,
    double height = 30,
    LoadingStyle? loadingStyle,
  }) {
    return ButtonState(
        onSubmit: (onPressed, submitForm),
        onFailure: onFailure,
        showToastError: showToastError,
        loadingStyle: loadingStyle,
        child: (pressed) {
          return TransparencyButton(
            text: text,
            onPressed: pressed,
            color: color,
            width: width,
            height: height,
          );
        });
  }
}
