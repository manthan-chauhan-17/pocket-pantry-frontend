import 'package:flutter/material.dart';
import 'package:pocket_pantry_frontend/core/constants/constants.dart';
import 'package:pocket_pantry_frontend/core/theme/app_theme.dart';
import 'package:pocket_pantry_frontend/core/theme/colors.dart';
import 'package:pocket_pantry_frontend/core/widgets/custom_text.dart';

/// A fully customizable button widget that matches the app's design system.
/// Supports normal, loading, and disabled states with theme-aware colors.
///
/// Features:
/// - Uses Constants for border radius
/// - Theme-aware colors (light/dark mode)
/// - Loading state with spinner
/// - Disabled state
/// - Customizable styling
/// - Icon support
class CustomButton extends StatelessWidget {
  /// The text to display on the button
  final String text;

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Whether the button is in loading state
  final bool isLoading;

  /// Whether the button is enabled
  final bool isEnabled;

  /// Button type - determines default colors
  final ButtonType buttonType;

  /// Custom background color (overrides buttonType default)
  final Color? backgroundColor;

  /// Custom text color (overrides buttonType default)
  final Color? textColor;

  /// Custom border color
  final Color? borderColor;

  /// Border width
  final double borderWidth;

  /// Button height
  final double? height;

  /// Button width (null = full width)
  final double? width;

  /// Border radius (defaults to Constants.borderRadius)
  final double? borderRadius;

  /// Padding inside the button
  final EdgeInsetsGeometry? padding;

  /// Icon to display before the text
  final Widget? prefixIcon;

  /// Icon to display after the text
  final Widget? suffixIcon;

  /// Text style
  final TextStyle? textStyle;

  /// Font size
  final double? fontSize;

  /// Font weight
  final FontWeight? fontWeight;

  /// Loading indicator color
  final Color? loadingColor;

  /// Loading indicator size
  final double? loadingSize;

  /// Whether to show loading text
  final bool showLoadingText;

  /// Loading text (defaults to text if not provided)
  final String? loadingText;

  /// Minimum width of the button
  final double? minWidth;

  /// Whether to expand to full width
  final bool isFullWidth;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.buttonType = ButtonType.primary,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 0,
    this.height,
    this.width,
    this.borderRadius,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.loadingColor,
    this.loadingSize,
    this.showLoadingText = true,
    this.loadingText,
    this.minWidth,
    this.isFullWidth = true,
  });

  /// Primary button constructor (most common use case)
  const CustomButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 0,
    this.height,
    this.width,
    this.borderRadius,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.loadingColor,
    this.loadingSize,
    this.showLoadingText = true,
    this.loadingText,
    this.minWidth,
    this.isFullWidth = true,
  }) : buttonType = ButtonType.primary;

  /// Secondary button constructor
  const CustomButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 0,
    this.height,
    this.width,
    this.borderRadius,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.loadingColor,
    this.loadingSize,
    this.showLoadingText = true,
    this.loadingText,
    this.minWidth,
    this.isFullWidth = true,
  }) : buttonType = ButtonType.secondary;

  /// Outlined button constructor
  const CustomButton.outlined({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 1.5,
    this.height,
    this.width,
    this.borderRadius,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.loadingColor,
    this.loadingSize,
    this.showLoadingText = true,
    this.loadingText,
    this.minWidth,
    this.isFullWidth = true,
  }) : buttonType = ButtonType.outlined;

  /// Text button constructor
  const CustomButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth = 0,
    this.height,
    this.width,
    this.borderRadius,
    this.padding,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.fontSize,
    this.fontWeight,
    this.loadingColor,
    this.loadingSize,
    this.showLoadingText = true,
    this.loadingText,
    this.minWidth,
    this.isFullWidth = false,
  }) : buttonType = ButtonType.text;

  Color _getBackgroundColor(BuildContext context) {
    if (!isEnabled || isLoading) {
      return AppTheme.isAppThemeDarkMode(context)
          ? AppColors.darkSurfaceVariant
          : AppColors.surfaceVariant;
    }

    if (backgroundColor != null) {
      return backgroundColor!;
    }

    final colorScheme = AppTheme.getColor(context);
    switch (buttonType) {
      case ButtonType.primary:
        return colorScheme.primary;
      case ButtonType.secondary:
        return colorScheme.secondary;
      case ButtonType.outlined:
      case ButtonType.text:
        return Colors.transparent;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (!isEnabled || isLoading) {
      return AppTheme.isAppThemeDarkMode(context)
          ? AppColors.darkOnSurfaceVariant
          : AppColors.onSurfaceVariant;
    }

    if (textColor != null) {
      return textColor!;
    }

    final colorScheme = AppTheme.getColor(context);
    switch (buttonType) {
      case ButtonType.primary:
        return colorScheme.onPrimary;
      case ButtonType.secondary:
        return colorScheme.onSecondary;
      case ButtonType.outlined:
      case ButtonType.text:
        return colorScheme.primary;
    }
  }

  Color _getBorderColor(BuildContext context) {
    if (borderColor != null) {
      return borderColor!;
    }

    if (!isEnabled || isLoading) {
      return AppTheme.isAppThemeDarkMode(context)
          ? AppColors.darkOutline
          : AppColors.outline;
    }

    final colorScheme = AppTheme.getColor(context);
    switch (buttonType) {
      case ButtonType.primary:
      case ButtonType.secondary:
        return Colors.transparent;
      case ButtonType.outlined:
        return colorScheme.primary;
      case ButtonType.text:
        return Colors.transparent;
    }
  }

  Color _getLoadingColor(BuildContext context) {
    if (loadingColor != null) {
      return loadingColor!;
    }
    return _getTextColor(context);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? 50.0;
    final effectiveBorderRadius = borderRadius ?? Constants.borderRadius;
    final effectivePadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0);

    final buttonContent = isLoading
        ? _buildLoadingContent(context)
        : _buildNormalContent(context);

    final buttonWidget = Container(
      height: effectiveHeight,
      width: isFullWidth ? (width ?? double.infinity) : width,
      constraints: minWidth != null
          ? BoxConstraints(minWidth: minWidth!)
          : null,
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        border: borderWidth > 0
            ? Border.all(color: _getBorderColor(context), width: borderWidth)
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: (isEnabled && !isLoading) ? onPressed : null,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          child: Container(
            padding: effectivePadding,
            child: Center(child: buttonContent),
          ),
        ),
      ),
    );

    return buttonWidget;
  }

  Widget _buildNormalContent(BuildContext context) {
    final List<Widget> children = [];

    // Prefix icon
    if (prefixIcon != null) {
      children.add(prefixIcon!);
      children.add(const SizedBox(width: 8));
    }

    // Text
    children.add(
      CustomText(
        text,
        fontSize: fontSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.w600,
        color: textStyle?.color ?? _getTextColor(context),
        textAlign: TextAlign.center,
      ),
    );

    // Suffix icon
    if (suffixIcon != null) {
      children.add(const SizedBox(width: 8));
      children.add(suffixIcon!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildLoadingContent(BuildContext context) {
    final List<Widget> children = [];

    // Loading spinner
    children.add(
      SizedBox(
        width: loadingSize ?? 20,
        height: loadingSize ?? 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(_getLoadingColor(context)),
        ),
      ),
    );

    // Loading text
    if (showLoadingText) {
      children.add(const SizedBox(width: 12));
      children.add(
        CustomText(
          loadingText ?? text,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeight.w600,
          color: textStyle?.color ?? _getTextColor(context),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}

/// Button type enum
enum ButtonType {
  /// Primary button - filled with primary color
  primary,

  /// Secondary button - filled with secondary color
  secondary,

  /// Outlined button - transparent with border
  outlined,

  /// Text button - transparent, no border
  text,
}
