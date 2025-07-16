import 'dart:convert';
import 'package:flutter/material.dart';

class ContainerSerializer {
  /// Convert Container to JSON Map
  static Map<String, dynamic> toJson(Container container) {
    return {
      'alignment': _alignmentToJson(container.alignment),
      'padding': _edgeInsetsToJson(container.padding),
      'color': container.color?.value,
      'decoration': _decorationToJson(container.decoration),
      'foregroundDecoration': _decorationToJson(container.foregroundDecoration),
      'constraints': _boxConstraintsToJson(container.constraints),
      'margin': _edgeInsetsToJson(container.margin),
      'transform': _matrix4ToJson(container.transform),
      'transformAlignment': _alignmentToJson(container.transformAlignment),
      'clipBehavior': container.clipBehavior.index,
      'child': _widgetToJson(container.child),
    };
  }

  /// Convert JSON Map to Container
  static Container fromJson(Map<String, dynamic> json) {
    return Container(
      width: json['width']?.toDouble(),
      height: json['height']?.toDouble(),
      alignment: _alignmentFromJson(json['alignment']),
      padding: _edgeInsetsFromJson(json['padding']),
      color: json['color'] != null ? Color(json['color'] as int) : null,
      decoration: _decorationFromJson(json['decoration']),
      foregroundDecoration: _decorationFromJson(json['foregroundDecoration']),
      constraints: _boxConstraintsFromJson(json['constraints']),
      margin: _edgeInsetsFromJson(json['margin']),
      transform: _matrix4FromJson(json['transform']),
      transformAlignment: _alignmentFromJson(json['transformAlignment']),
      clipBehavior: json['clipBehavior'] != null 
          ? Clip.values[json['clipBehavior'] as int] 
          : Clip.none,
      child: _widgetFromJson(json['child']),
    );
  }

  /// Convert Container to JSON string
  static String toJsonString(Container container) {
    return jsonEncode(toJson(container));
  }

  /// Convert JSON string to Container
  static Container fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return fromJson(json);
  }

  // Helper methods for AlignmentGeometry
  static Map<String, dynamic>? _alignmentToJson(AlignmentGeometry? alignment) {
    if (alignment == null) return null;
    
    if (alignment == Alignment.topLeft) return {'type': 'topLeft'};
    if (alignment == Alignment.topCenter) return {'type': 'topCenter'};
    if (alignment == Alignment.topRight) return {'type': 'topRight'};
    if (alignment == Alignment.centerLeft) return {'type': 'centerLeft'};
    if (alignment == Alignment.center) return {'type': 'center'};
    if (alignment == Alignment.centerRight) return {'type': 'centerRight'};
    if (alignment == Alignment.bottomLeft) return {'type': 'bottomLeft'};
    if (alignment == Alignment.bottomCenter) return {'type': 'bottomCenter'};
    if (alignment == Alignment.bottomRight) return {'type': 'bottomRight'};
    
    // For custom Alignment
    if (alignment is Alignment) {
      return {
        'type': 'custom',
        'x': alignment.x,
        'y': alignment.y,
      };
    }
    
    return null;
  }

  static AlignmentGeometry? _alignmentFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    switch (json['type']) {
      case 'topLeft': return Alignment.topLeft;
      case 'topCenter': return Alignment.topCenter;
      case 'topRight': return Alignment.topRight;
      case 'centerLeft': return Alignment.centerLeft;
      case 'center': return Alignment.center;
      case 'centerRight': return Alignment.centerRight;
      case 'bottomLeft': return Alignment.bottomLeft;
      case 'bottomCenter': return Alignment.bottomCenter;
      case 'bottomRight': return Alignment.bottomRight;
      case 'custom':
        return Alignment(
          json['x']?.toDouble() ?? 0.0,
          json['y']?.toDouble() ?? 0.0,
        );
      default: return null;
    }
  }

  // Helper methods for EdgeInsetsGeometry
  static Map<String, dynamic>? _edgeInsetsToJson(EdgeInsetsGeometry? edgeInsets) {
    if (edgeInsets == null) return null;
    
    if (edgeInsets is EdgeInsets) {
      return {
        'type': 'EdgeInsets',
        'left': edgeInsets.left,
        'top': edgeInsets.top,
        'right': edgeInsets.right,
        'bottom': edgeInsets.bottom,
      };
    }
    
    return null;
  }

  static EdgeInsetsGeometry? _edgeInsetsFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    switch (json['type']) {
      case 'EdgeInsets':
        return EdgeInsets.fromLTRB(
          json['left']?.toDouble() ?? 0.0,
          json['top']?.toDouble() ?? 0.0,
          json['right']?.toDouble() ?? 0.0,
          json['bottom']?.toDouble() ?? 0.0,
        );
      default: return null;
    }
  }

  // Helper methods for BoxConstraints
  static Map<String, dynamic>? _boxConstraintsToJson(BoxConstraints? constraints) {
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

  // Helper methods for Matrix4
  static Map<String, dynamic>? _matrix4ToJson(Matrix4? matrix) {
    if (matrix == null) return null;
    
    return {
      'values': matrix.storage.toList(),
    };
  }

  static Matrix4? _matrix4FromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    if (json['values'] is List) {
      final List<double> values = (json['values'] as List)
          .map((e) => (e as num).toDouble())
          .toList();
      if (values.length == 16) {
        return Matrix4.fromList(values);
      }
    }
    
    return null;
  }

  // Helper methods for Decoration (BoxDecoration support)
  static Map<String, dynamic>? _decorationToJson(Decoration? decoration) {
    if (decoration == null) return null;
    
    if (decoration is BoxDecoration) {
      return {
        'type': 'BoxDecoration',
        'color': decoration.color?.value,
        'border': _boxBorderToJson(decoration.border),
        'borderRadius': _borderRadiusToJson(decoration.borderRadius),
        'boxShadow': decoration.boxShadow?.map(_boxShadowToJson).toList(),
        'gradient': _gradientToJson(decoration.gradient),
        'backgroundBlendMode': decoration.backgroundBlendMode?.index,
        'shape': decoration.shape.index,
      };
    }
    
    return null;
  }

  static Decoration? _decorationFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    switch (json['type']) {
      case 'BoxDecoration':
        return BoxDecoration(
          color: json['color'] != null ? Color(json['color'] as int) : null,
          border: _boxBorderFromJson(json['border']),
          borderRadius: _borderRadiusFromJson(json['borderRadius']),
          boxShadow: json['boxShadow'] != null 
              ? (json['boxShadow'] as List).map((e) => _boxShadowFromJson(e)).toList()
              : null,
          gradient: _gradientFromJson(json['gradient']),
          backgroundBlendMode: json['backgroundBlendMode'] != null 
              ? BlendMode.values[json['backgroundBlendMode'] as int]
              : null,
          shape: json['shape'] != null 
              ? BoxShape.values[json['shape'] as int]
              : BoxShape.rectangle,
        );
      default: return null;
    }
  }

  // Helper methods for BoxBorder (handles Border and other BoxBorder types)
  static Map<String, dynamic>? _boxBorderToJson(BoxBorder? border) {
    if (border == null) return null;
    
    if (border is Border) {
      return {
        'type': 'Border',
        'top': _borderSideToJson(border.top),
        'right': _borderSideToJson(border.right),
        'bottom': _borderSideToJson(border.bottom),
        'left': _borderSideToJson(border.left),
      };
    }
    
    return null;
  }

  static BoxBorder? _boxBorderFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    switch (json['type']) {
      case 'Border':
        return Border(
          top: _borderSideFromJson(json['top']) ?? BorderSide.none,
          right: _borderSideFromJson(json['right']) ?? BorderSide.none,
          bottom: _borderSideFromJson(json['bottom']) ?? BorderSide.none,
          left: _borderSideFromJson(json['left']) ?? BorderSide.none,
        );
      default: return null;
    }
  }

  // Helper methods for BorderSide
  static Map<String, dynamic>? _borderSideToJson(BorderSide? borderSide) {
    if (borderSide == null || borderSide == BorderSide.none) return null;
    
    return {
      'color': borderSide.color.value,
      'width': borderSide.width,
      'style': borderSide.style.index,
    };
  }

  static BorderSide? _borderSideFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    return BorderSide(
      color: json['color'] != null ? Color(json['color'] as int) : Colors.black,
      width: json['width'] != null ? (json['width'] as num).toDouble() : 1.0,
      style: json['style'] != null 
          ? BorderStyle.values[json['style'] as int]
          : BorderStyle.solid,
    );
  }

  // Helper methods for BorderRadius
  static Map<String, dynamic>? _borderRadiusToJson(BorderRadiusGeometry? borderRadius) {
    if (borderRadius == null) return null;
    
    if (borderRadius is BorderRadius) {
      return {
        'type': 'BorderRadius',
        'topLeft': _radiusToJson(borderRadius.topLeft),
        'topRight': _radiusToJson(borderRadius.topRight),
        'bottomLeft': _radiusToJson(borderRadius.bottomLeft),
        'bottomRight': _radiusToJson(borderRadius.bottomRight),
      };
    }
    
    return null;
  }

  static BorderRadiusGeometry? _borderRadiusFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    switch (json['type']) {
      case 'BorderRadius':
        return BorderRadius.only(
          topLeft: _radiusFromJson(json['topLeft']) ?? Radius.zero,
          topRight: _radiusFromJson(json['topRight']) ?? Radius.zero,
          bottomLeft: _radiusFromJson(json['bottomLeft']) ?? Radius.zero,
          bottomRight: _radiusFromJson(json['bottomRight']) ?? Radius.zero,
        );
      default: return null;
    }
  }

  // Helper methods for Radius
  static Map<String, dynamic>? _radiusToJson(Radius? radius) {
    if (radius == null) return null;
    
    return {
      'x': radius.x,
      'y': radius.y,
    };
  }

  static Radius? _radiusFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    return Radius.elliptical(
      json['x']?.toDouble() ?? 0.0,
      json['y']?.toDouble() ?? 0.0,
    );
  }

  // Helper methods for BoxShadow
  static Map<String, dynamic> _boxShadowToJson(BoxShadow shadow) {
    return {
      'color': shadow.color.value,
      'offset': {
        'dx': shadow.offset.dx,
        'dy': shadow.offset.dy,
      },
      'blurRadius': shadow.blurRadius,
      'spreadRadius': shadow.spreadRadius,
      'blurStyle': shadow.blurStyle.index,
    };
  }

  static BoxShadow _boxShadowFromJson(Map<String, dynamic> json) {
    return BoxShadow(
      color: json['color'] != null ? Color(json['color'] as int) : Colors.black,
      offset: json['offset'] != null 
          ? Offset(json['offset']['dx']?.toDouble() ?? 0.0, json['offset']['dy']?.toDouble() ?? 0.0)
          : Offset.zero,
      blurRadius: json['blurRadius']?.toDouble() ?? 0.0,
      spreadRadius: json['spreadRadius']?.toDouble() ?? 0.0,
      blurStyle: json['blurStyle'] != null 
          ? BlurStyle.values[json['blurStyle'] as int]
          : BlurStyle.normal,
    );
  }

  // Helper methods for Gradient
  static Map<String, dynamic>? _gradientToJson(Gradient? gradient) {
    if (gradient == null) return null;
    
    if (gradient is LinearGradient) {
      return {
        'type': 'LinearGradient',
        'begin': _alignmentToJson(gradient.begin),
        'end': _alignmentToJson(gradient.end),
        'colors': gradient.colors.map((c) => c.value).toList(),
        'stops': gradient.stops,
        'tileMode': gradient.tileMode.index,
      };
    }
    
    if (gradient is RadialGradient) {
      return {
        'type': 'RadialGradient',
        'center': _alignmentToJson(gradient.center),
        'radius': gradient.radius,
        'colors': gradient.colors.map((c) => c.value).toList(),
        'stops': gradient.stops,
        'tileMode': gradient.tileMode.index,
      };
    }
    
    return null;
  }

  static Gradient? _gradientFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    switch (json['type']) {
      case 'LinearGradient':
        return LinearGradient(
          begin: _alignmentFromJson(json['begin']) ?? Alignment.centerLeft,
          end: _alignmentFromJson(json['end']) ?? Alignment.centerRight,
          colors: (json['colors'] as List?)?.map((c) => Color(c as int)).toList() ?? [],
          stops: (json['stops'] as List?)?.map((s) => (s as num).toDouble()).toList(),
          tileMode: json['tileMode'] != null 
              ? TileMode.values[json['tileMode'] as int]
              : TileMode.clamp,
        );
      case 'RadialGradient':
        return RadialGradient(
          center: _alignmentFromJson(json['center']) ?? Alignment.center,
          radius: json['radius']?.toDouble() ?? 0.5,
          colors: (json['colors'] as List?)?.map((c) => Color(c as int)).toList() ?? [],
          stops: (json['stops'] as List?)?.map((s) => (s as num).toDouble()).toList(),
          tileMode: json['tileMode'] != null 
              ? TileMode.values[json['tileMode'] as int]
              : TileMode.clamp,
        );
      default: return null;
    }
  }

  // Helper methods for Widget (basic support)
  static Map<String, dynamic>? _widgetToJson(Widget? widget) {
    if (widget == null) return null;
    
    if (widget is Text) {
      return {
        'type': 'Text',
        'data': widget.data,
        'style': _textStyleToJson(widget.style),
      };
    }
    
    if (widget is Icon) {
      return {
        'type': 'Icon',
        'iconData': _iconDataToJson(widget.icon),
        'size': widget.size,
        'color': widget.color?.value,
      };
    }
    
    return null;
  }

  static Widget? _widgetFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    switch (json['type']) {
      case 'Text':
        return Text(
          json['data'] as String? ?? '',
          style: _textStyleFromJson(json['style']),
        );
      case 'Icon':
        return Icon(
          _iconDataFromJson(json['iconData']),
          size: json['size']?.toDouble(),
          color: json['color'] != null ? Color(json['color'] as int) : null,
        );
      default: return null;
    }
  }

  // Additional helper methods for TextStyle and IconData
  static Map<String, dynamic>? _textStyleToJson(TextStyle? textStyle) {
    if (textStyle == null) return null;
    
    return {
      'fontSize': textStyle.fontSize,
      'fontWeight': textStyle.fontWeight?.index,
      'fontStyle': textStyle.fontStyle?.index,
      'color': textStyle.color?.value,
      'letterSpacing': textStyle.letterSpacing,
      'wordSpacing': textStyle.wordSpacing,
      'height': textStyle.height,
      'fontFamily': textStyle.fontFamily,
    };
  }

  static TextStyle? _textStyleFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    return TextStyle(
      fontSize: json['fontSize']?.toDouble(),
      fontWeight: json['fontWeight'] != null ? FontWeight.values[json['fontWeight'] as int] : null,
      fontStyle: json['fontStyle'] != null ? FontStyle.values[json['fontStyle'] as int] : null,
      color: json['color'] != null ? Color(json['color'] as int) : null,
      letterSpacing: json['letterSpacing']?.toDouble(),
      wordSpacing: json['wordSpacing']?.toDouble(),
      height: json['height']?.toDouble(),
      fontFamily: json['fontFamily'] as String?,
    );
  }

  static Map<String, dynamic>? _iconDataToJson(IconData? iconData) {
    if (iconData == null) return null;
    
    return {
      'codePoint': iconData.codePoint,
      'fontFamily': iconData.fontFamily,
      'fontPackage': iconData.fontPackage,
      'matchTextDirection': iconData.matchTextDirection,
    };
  }

  static IconData? _iconDataFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    return IconData(
      json['codePoint'] as int,
      fontFamily: json['fontFamily'] as String?,
      fontPackage: json['fontPackage'] as String?,
      matchTextDirection: json['matchTextDirection'] as bool? ?? false,
    );
  }
}