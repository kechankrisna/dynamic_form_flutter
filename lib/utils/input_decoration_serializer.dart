import 'dart:convert';
import 'package:dynamic_form/dynamic_form.dart';
import 'package:dynamic_form/utils/container_serializer.dart';
import 'package:flutter/material.dart';

class InputDecorationSerializer {
  /// Convert InputDecoration to JSON Map
  static Map<String, dynamic> toJson(InputDecoration decoration) {
    return {
      'labelText': decoration.labelText,
      'hintText': decoration.hintText,
      'helperText': decoration.helperText,
      'errorText': decoration.errorText,
      'prefixText': decoration.prefixText,
      'suffixText': decoration.suffixText,
      'counterText': decoration.counterText,
      'semanticCounterText': decoration.semanticCounterText,
      'isCollapsed': decoration.isCollapsed,
      'isDense': decoration.isDense,
      'filled': decoration.filled,
      'enabled': decoration.enabled,
      'alignLabelWithHint': decoration.alignLabelWithHint,
      'floatingLabelBehavior': decoration.floatingLabelBehavior?.index,
      'floatingLabelAlignment':
          _floatingLabelAlignmentToString(decoration.floatingLabelAlignment),
      'helperMaxLines': decoration.helperMaxLines,
      'hintMaxLines': decoration.hintMaxLines,
      'errorMaxLines': decoration.errorMaxLines,
      'fillColor': decoration.fillColor?.value,
      'focusColor': decoration.focusColor?.value,
      'hoverColor': decoration.hoverColor?.value,
      'iconColor': decoration.iconColor?.value,
      'prefixIconColor': decoration.prefixIconColor?.value,
      'suffixIconColor': decoration.suffixIconColor?.value,
      'prefixIcon': _widgetToJson(decoration.prefixIcon),
      'suffixIcon': _widgetToJson(decoration.suffixIcon),
      'prefix': _widgetToJson(decoration.prefix),
      'suffix': _widgetToJson(decoration.suffix),
      'contentPadding': _edgeInsetsToJson(decoration.contentPadding),
      'prefixIconConstraints':
          _boxConstraintsToJson(decoration.prefixIconConstraints),
      'suffixIconConstraints':
          _boxConstraintsToJson(decoration.suffixIconConstraints),
      'constraints': _boxConstraintsToJson(decoration.constraints),
      'labelStyle': _textStyleToJson(decoration.labelStyle),
      'floatingLabelStyle': _textStyleToJson(decoration.floatingLabelStyle),
      'helperStyle': _textStyleToJson(decoration.helperStyle),
      'hintStyle': _textStyleToJson(decoration.hintStyle),
      'errorStyle': _textStyleToJson(decoration.errorStyle),
      'prefixStyle': _textStyleToJson(decoration.prefixStyle),
      'suffixStyle': _textStyleToJson(decoration.suffixStyle),
      'counterStyle': _textStyleToJson(decoration.counterStyle),
    };
  }

  /// Convert JSON Map to InputDecoration
  static InputDecoration fromJson(Map<String, dynamic> json) {
    return InputDecoration(
      labelText: json['labelText'] as String?,
      hintText: json['hintText'] as String?,
      helperText: json['helperText'] as String?,
      errorText: json['errorText'] as String?,
      prefixText: json['prefixText'] as String?,
      suffixText: json['suffixText'] as String?,
      counterText: json['counterText'] as String?,
      semanticCounterText: json['semanticCounterText'] as String?,
      isCollapsed: json['isCollapsed'] as bool? ?? false,
      isDense: json['isDense'] as bool?,
      filled: json['filled'] as bool?,
      enabled: json['enabled'] as bool? ?? true,
      alignLabelWithHint: json['alignLabelWithHint'] as bool?,
      floatingLabelBehavior: json['floatingLabelBehavior'] != null
          ? FloatingLabelBehavior.values[json['floatingLabelBehavior'] as int]
          : null,
      floatingLabelAlignment:
          _floatingLabelAlignmentFromString(json['floatingLabelAlignment']),
      helperMaxLines: json['helperMaxLines'] as int?,
      hintMaxLines: json['hintMaxLines'] as int?,
      errorMaxLines: json['errorMaxLines'] as int?,
      fillColor:
          json['fillColor'] != null ? Color(json['fillColor'] as int) : null,
      focusColor:
          json['focusColor'] != null ? Color(json['focusColor'] as int) : null,
      hoverColor:
          json['hoverColor'] != null ? Color(json['hoverColor'] as int) : null,
      iconColor:
          json['iconColor'] != null ? Color(json['iconColor'] as int) : null,
      prefixIconColor: json['prefixIconColor'] != null
          ? Color(json['prefixIconColor'] as int)
          : null,
      suffixIconColor: json['suffixIconColor'] != null
          ? Color(json['suffixIconColor'] as int)
          : null,
      prefixIcon: _widgetFromJson(json['prefixIcon']),
      suffixIcon: _widgetFromJson(json['suffixIcon']),
      prefix: _widgetFromJson(json['prefix']),
      suffix: _widgetFromJson(json['suffix']),
      contentPadding: _edgeInsetsFromJson(json['contentPadding']),
      prefixIconConstraints:
          _boxConstraintsFromJson(json['prefixIconConstraints']),
      suffixIconConstraints:
          _boxConstraintsFromJson(json['suffixIconConstraints']),
      constraints: _boxConstraintsFromJson(json['constraints']),
      labelStyle: _textStyleFromJson(json['labelStyle']),
      floatingLabelStyle: _textStyleFromJson(json['floatingLabelStyle']),
      helperStyle: _textStyleFromJson(json['helperStyle']),
      hintStyle: _textStyleFromJson(json['hintStyle']),
      errorStyle: _textStyleFromJson(json['errorStyle']),
      prefixStyle: _textStyleFromJson(json['prefixStyle']),
      suffixStyle: _textStyleFromJson(json['suffixStyle']),
      counterStyle: _textStyleFromJson(json['counterStyle']),
    );
  }

  // Helper methods for complex types
  static Map<String, dynamic>? _edgeInsetsToJson(
      EdgeInsetsGeometry? edgeInsets) {
    if (edgeInsets == null) return null;
    if (edgeInsets is EdgeInsets) {
      return {
        'left': edgeInsets.left,
        'top': edgeInsets.top,
        'right': edgeInsets.right,
        'bottom': edgeInsets.bottom,
      };
    }
    return null;
  }

  static EdgeInsets? _edgeInsetsFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return EdgeInsets.fromLTRB(
      json['left']?.toDouble() ?? 0.0,
      json['top']?.toDouble() ?? 0.0,
      json['right']?.toDouble() ?? 0.0,
      json['bottom']?.toDouble() ?? 0.0,
    );
  }

  static Map<String, dynamic>? _boxConstraintsToJson(
      BoxConstraints? constraints) {
    if (constraints == null) return null;
    return {
      'minWidth': constraints.minWidth,
      'maxWidth': constraints.maxWidth,
      'minHeight': constraints.minHeight,
      'maxHeight': constraints.maxHeight,
    };
  }

  static BoxConstraints? _boxConstraintsFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return BoxConstraints(
      minWidth: json['minWidth']?.toDouble() ?? 0.0,
      maxWidth: json['maxWidth']?.toDouble() ?? double.infinity,
      minHeight: json['minHeight']?.toDouble() ?? 0.0,
      maxHeight: json['maxHeight']?.toDouble() ?? double.infinity,
    );
  }

  static Map<String, dynamic>? _textStyleToJson(TextStyle? textStyle) {
    if (textStyle == null) return null;
    return {
      'fontSize': textStyle.fontSize,
      'fontWeight': textStyle.fontWeight?.index,
      'fontStyle': textStyle.fontStyle?.index,
      'letterSpacing': textStyle.letterSpacing,
      'wordSpacing': textStyle.wordSpacing,
      'height': textStyle.height,
      'color': textStyle.color?.value,
      'backgroundColor': textStyle.backgroundColor?.value,
      'decoration': _textDecorationToString(textStyle.decoration),
      'decorationColor': textStyle.decorationColor?.value,
      'decorationStyle': textStyle.decorationStyle?.index,
      'decorationThickness': textStyle.decorationThickness,
      'fontFamily': textStyle.fontFamily,
    };
  }

  static TextStyle? _textStyleFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return TextStyle(
      fontSize: json['fontSize']?.toDouble(),
      fontWeight: json['fontWeight'] != null
          ? FontWeight.values[json['fontWeight'] as int]
          : null,
      fontStyle: json['fontStyle'] != null
          ? FontStyle.values[json['fontStyle'] as int]
          : null,
      letterSpacing: json['letterSpacing']?.toDouble(),
      wordSpacing: json['wordSpacing']?.toDouble(),
      height: json['height']?.toDouble(),
      color: json['color'] != null ? Color(json['color'] as int) : null,
      backgroundColor: json['backgroundColor'] != null
          ? Color(json['backgroundColor'] as int)
          : null,
      decoration: _textDecorationFromString(json['decoration']),
      decorationColor: json['decorationColor'] != null
          ? Color(json['decorationColor'] as int)
          : null,
      decorationStyle: json['decorationStyle'] != null
          ? TextDecorationStyle.values[json['decorationStyle'] as int]
          : null,
      decorationThickness: json['decorationThickness']?.toDouble(),
      fontFamily: json['fontFamily'] as String?,
    );
  }

  // Helper methods for TextDecoration
  static String? _textDecorationToString(TextDecoration? decoration) {
    if (decoration == null) return null;
    if (decoration == TextDecoration.none) return 'none';
    if (decoration == TextDecoration.underline) return 'underline';
    if (decoration == TextDecoration.overline) return 'overline';
    if (decoration == TextDecoration.lineThrough) return 'lineThrough';

    // Handle combined decorations
    List<String> decorations = [];
    if (decoration.contains(TextDecoration.underline))
      decorations.add('underline');
    if (decoration.contains(TextDecoration.overline))
      decorations.add('overline');
    if (decoration.contains(TextDecoration.lineThrough))
      decorations.add('lineThrough');

    return decorations.isEmpty ? 'none' : decorations.join(',');
  }

  static TextDecoration? _textDecorationFromString(String? decorationString) {
    if (decorationString == null || decorationString == 'none')
      return TextDecoration.none;

    if (decorationString.contains(',')) {
      // Handle combined decorations
      List<String> parts = decorationString.split(',');
      List<TextDecoration> decorations = [];

      for (String part in parts) {
        switch (part.trim()) {
          case 'underline':
            decorations.add(TextDecoration.underline);
            break;
          case 'overline':
            decorations.add(TextDecoration.overline);
            break;
          case 'lineThrough':
            decorations.add(TextDecoration.lineThrough);
            break;
        }
      }

      return TextDecoration.combine(decorations);
    } else {
      // Handle single decoration
      switch (decorationString) {
        case 'underline':
          return TextDecoration.underline;
        case 'overline':
          return TextDecoration.overline;
        case 'lineThrough':
          return TextDecoration.lineThrough;
        default:
          return TextDecoration.none;
      }
    }
  }

  /// Convert InputDecoration to JSON string
  static String toJsonString(InputDecoration decoration) {
    return jsonEncode(toJson(decoration));
  }

  /// Convert JSON string to InputDecoration
  static InputDecoration fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return fromJson(json);
  }

  // Helper methods for FloatingLabelAlignment
  static String? _floatingLabelAlignmentToString(
      FloatingLabelAlignment? alignment) {
    if (alignment == null) return null;
    if (alignment == FloatingLabelAlignment.start) return 'start';
    if (alignment == FloatingLabelAlignment.center) return 'center';
    // For custom alignments, we'll default to start
    return 'start';
  }

  static FloatingLabelAlignment? _floatingLabelAlignmentFromString(
      String? alignmentString) {
    if (alignmentString == null) return null;
    switch (alignmentString) {
      case 'start':
        return FloatingLabelAlignment.start;
      case 'center':
        return FloatingLabelAlignment.center;
      default:
        return FloatingLabelAlignment.start;
    }
  }

  // Helper methods for Widget serialization (limited support)
  static Map<String, dynamic>? _widgetToJson(Widget? widget) {
    if (widget == null) return null;

    if (widget is Icon) {
      return IconSerializer.toJson(widget);
    }

    if (widget is Text) {
      return {
        'type': 'Text',
        'data': widget.data,
        'style': _textStyleToJson(widget.style),
      };
    }

    if (widget is Container) {
      return ContainerSerializer.toJson(widget);
    }

    // For unsupported widgets, return null
    return null;
  }

  static Widget? _widgetFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    switch (json['type']) {
      
      case 'Icon':
      print(json);
        return IconSerializer.fromJson(json);

      case 'Text':
        return Text(
          json['data'] as String? ?? '',
          style: _textStyleFromJson(json['style']),
        );

      case 'Container':
        return ContainerSerializer.fromJson(json);

      default:
        return null;
    }
  }
}
