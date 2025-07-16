import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';

class IconSerializer {
  /// Convert Icon to JSON Map
  static Map<String, dynamic> toJson(Icon icon) {
    return {
      'icon': _iconDataToJson(icon.icon),
      'size': icon.size,
      'fill': icon.fill,
      'weight': icon.weight,
      'grade': icon.grade,
      'opticalSize': icon.opticalSize,
      'color': icon.color?.value,
      'shadows': icon.shadows?.map(_shadowToJson).toList(),
      'semanticLabel': icon.semanticLabel,
      'textDirection': icon.textDirection?.index,
    };
  }

  /// Convert JSON Map to Icon
  static Icon fromJson(Map<String, dynamic> json) {
    return Icon(
      _iconDataFromJson(json['icon']),
      size: json['size'] != null ? (json['size'] as num).toDouble() : null,
      fill: json['fill'] != null ? (json['fill'] as num).toDouble() : null,
      weight: json['weight'] != null ? (json['weight'] as num).toDouble() : null,
      grade: json['grade'] != null ? (json['grade'] as num).toDouble() : null,
      opticalSize: json['opticalSize'] != null ? (json['opticalSize'] as num).toDouble() : null,
      color: json['color'] != null ? Color(json['color'] as int) : null,
      shadows: json['shadows'] != null 
          ? (json['shadows'] as List).map((e) => _shadowFromJson(e)).toList()
          : null,
      semanticLabel: json['semanticLabel'] as String?,
      textDirection: json['textDirection'] != null 
          ? TextDirection.values[json['textDirection'] as int]
          : null,
    );
  }

  /// Convert Icon to JSON string
  static String toJsonString(Icon icon) {
    return jsonEncode(toJson(icon));
  }

  /// Convert JSON string to Icon
  static Icon fromJsonString(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return fromJson(json);
  }

  // Helper methods for IconData
  static Map<String, dynamic>? _iconDataToJson(IconData? iconData) {
    if (iconData == null) return null;
    
    return {
      'codePoint': iconData.codePoint,
      'fontFamily': iconData.fontFamily,
      'fontPackage': iconData.fontPackage,
      'matchTextDirection': iconData.matchTextDirection,
      'fontFamilyFallback': iconData.fontFamilyFallback,
    };
  }

  static IconData? _iconDataFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    
    return IconData(
      json['codePoint'] as int,
      fontFamily: json['fontFamily'] as String?,
      fontPackage: json['fontPackage'] as String?,
      matchTextDirection: json['matchTextDirection'] as bool? ?? false,
      fontFamilyFallback: json['fontFamilyFallback'] != null 
          ? (json['fontFamilyFallback'] as List).cast<String>()
          : null,
    );
  }

  // Helper methods for Shadow
  static Map<String, dynamic> _shadowToJson(Shadow shadow) {
    return {
      'color': shadow.color.value,
      'offset': {
        'dx': shadow.offset.dx,
        'dy': shadow.offset.dy,
      },
      'blurRadius': shadow.blurRadius,
    };
  }

  static Shadow _shadowFromJson(Map<String, dynamic> json) {
    return Shadow(
      color: json['color'] != null ? Color(json['color'] as int) : Colors.black,
      offset: json['offset'] != null 
          ? Offset(
              json['offset']['dx'] != null ? (json['offset']['dx'] as num).toDouble() : 0.0, 
              json['offset']['dy'] != null ? (json['offset']['dy'] as num).toDouble() : 0.0
            )
          : Offset.zero,
      blurRadius: json['blurRadius'] != null ? (json['blurRadius'] as num).toDouble() : 0.0,
    );
  }

  // Helper method to create Icon from commonly used icon names
  static Icon createFromIconName(String iconName, {
    double? size,
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
    String? semanticLabel,
    TextDirection? textDirection,
  }) {
    IconData? iconData = _getIconDataFromName(iconName);
    
    return Icon(
      iconData,
      size: size,
      fill: fill,
      weight: weight,
      grade: grade,
      opticalSize: opticalSize,
      color: color,
      shadows: shadows,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }

  // Helper method to get IconData from string name
  static IconData? _getIconDataFromName(String iconName) {
    // Common Material Icons mapping
    switch (iconName.toLowerCase()) {
      // Navigation
      case 'arrow_back': return Icons.arrow_back;
      case 'arrow_forward': return Icons.arrow_forward;
      case 'arrow_upward': return Icons.arrow_upward;
      case 'arrow_downward': return Icons.arrow_downward;
      case 'chevron_left': return Icons.chevron_left;
      case 'chevron_right': return Icons.chevron_right;
      case 'expand_less': return Icons.expand_less;
      case 'expand_more': return Icons.expand_more;
      case 'menu': return Icons.menu;
      case 'close': return Icons.close;
      case 'home': return Icons.home;
      case 'search': return Icons.search;
      
      // Actions
      case 'add': return Icons.add;
      case 'remove': return Icons.remove;
      case 'edit': return Icons.edit;
      case 'delete': return Icons.delete;
      case 'save': return Icons.save;
      case 'download': return Icons.download;
      case 'upload': return Icons.upload;
      case 'share': return Icons.share;
      case 'copy': return Icons.copy;
      case 'cut': return Icons.cut;
      case 'paste': return Icons.paste;
      case 'undo': return Icons.undo;
      case 'redo': return Icons.redo;
      case 'refresh': return Icons.refresh;
      case 'sync': return Icons.sync;
      
      // UI Elements
      case 'check': return Icons.check;
      case 'check_circle': return Icons.check_circle;
      case 'cancel': return Icons.cancel;
      case 'clear': return Icons.clear;
      case 'done': return Icons.done;
      case 'error': return Icons.error;
      case 'warning': return Icons.warning;
      case 'info': return Icons.info;
      case 'help': return Icons.help;
      case 'settings': return Icons.settings;
      case 'more_vert': return Icons.more_vert;
      case 'more_horiz': return Icons.more_horiz;
      case 'filter_list': return Icons.filter_list;
      case 'sort': return Icons.sort;
      case 'view_list': return Icons.view_list;
      case 'view_module': return Icons.view_module;
      case 'grid_view': return Icons.grid_view;
      
      // Communication
      case 'phone': return Icons.phone;
      case 'email': return Icons.email;
      case 'message': return Icons.message;
      case 'chat': return Icons.chat;
      case 'send': return Icons.send;
      case 'mail': return Icons.mail;
      case 'call': return Icons.call;
      case 'videocam': return Icons.videocam;
      
      // Content
      case 'create': return Icons.create;
      case 'drafts': return Icons.drafts;
      case 'inbox': return Icons.inbox;
      case 'archive': return Icons.archive;
      case 'unarchive': return Icons.unarchive;
      case 'bookmark': return Icons.bookmark;
      case 'bookmark_border': return Icons.bookmark_border;
      case 'favorite': return Icons.favorite;
      case 'favorite_border': return Icons.favorite_border;
      case 'star': return Icons.star;
      case 'star_border': return Icons.star_border;
      case 'thumb_up': return Icons.thumb_up;
      case 'thumb_down': return Icons.thumb_down;
      
      // Media
      case 'play_arrow': return Icons.play_arrow;
      case 'pause': return Icons.pause;
      case 'stop': return Icons.stop;
      case 'skip_next': return Icons.skip_next;
      case 'skip_previous': return Icons.skip_previous;
      case 'fast_forward': return Icons.fast_forward;
      case 'fast_rewind': return Icons.fast_rewind;
      case 'volume_up': return Icons.volume_up;
      case 'volume_down': return Icons.volume_down;
      case 'volume_off': return Icons.volume_off;
      case 'volume_mute': return Icons.volume_mute;
      case 'music_note': return Icons.music_note;
      case 'audiotrack': return Icons.audiotrack;
      case 'library_music': return Icons.library_music;
      
      // File/Folder
      case 'folder': return Icons.folder;
      case 'folder_open': return Icons.folder_open;
      case 'insert_drive_file': return Icons.insert_drive_file;
      case 'description': return Icons.description;
      case 'picture_as_pdf': return Icons.picture_as_pdf;
      case 'image': return Icons.image;
      case 'photo': return Icons.photo;
      case 'photo_camera': return Icons.photo_camera;
      case 'camera_alt': return Icons.camera_alt;
      case 'video_library': return Icons.video_library;
      case 'movie': return Icons.movie;
      
      // Security
      case 'lock': return Icons.lock;
      case 'lock_open': return Icons.lock_open;
      case 'visibility': return Icons.visibility;
      case 'visibility_off': return Icons.visibility_off;
      case 'fingerprint': return Icons.fingerprint;
      case 'vpn_key': return Icons.vpn_key;
      case 'security': return Icons.security;
      
      // Person/Account
      case 'person': return Icons.person;
      case 'person_add': return Icons.person_add;
      case 'people': return Icons.people;
      case 'account_circle': return Icons.account_circle;
      case 'account_box': return Icons.account_box;
      case 'group': return Icons.group;
      case 'supervisor_account': return Icons.supervisor_account;
      
      // Location
      case 'location_on': return Icons.location_on;
      case 'location_off': return Icons.location_off;
      case 'place': return Icons.place;
      case 'map': return Icons.map;
      case 'directions': return Icons.directions;
      case 'navigation': return Icons.navigation;
      case 'explore': return Icons.explore;
      case 'travel_explore': return Icons.travel_explore;
      
      // Time/Date
      case 'access_time': return Icons.access_time;
      case 'schedule': return Icons.schedule;
      case 'today': return Icons.today;
      case 'date_range': return Icons.date_range;
      case 'event': return Icons.event;
      case 'alarm': return Icons.alarm;
      case 'timer': return Icons.timer;
      case 'hourglass_empty': return Icons.hourglass_empty;
      
      // Shopping/Commerce
      case 'shopping_cart': return Icons.shopping_cart;
      case 'add_shopping_cart': return Icons.add_shopping_cart;
      case 'shopping_bag': return Icons.shopping_bag;
      case 'store': return Icons.store;
      case 'payment': return Icons.payment;
      case 'credit_card': return Icons.credit_card;
      case 'monetization_on': return Icons.monetization_on;
      case 'attach_money': return Icons.attach_money;
      
      // Weather
      case 'wb_sunny': return Icons.wb_sunny;
      case 'wb_cloudy': return Icons.wb_cloudy;
      case 'beach_access': return Icons.beach_access;
      case 'ac_unit': return Icons.ac_unit;
      case 'grain': return Icons.grain;
      
      default: return null;
    }
  }

  // Helper method to get icon name from IconData
  static String? getIconName(IconData? iconData) {
    if (iconData == null) return null;
    
    // This is a reverse lookup - in a real app, you might want to maintain a bidirectional map
    final Map<int, String> codePointToName = {
      Icons.arrow_back.codePoint: 'arrow_back',
      Icons.arrow_forward.codePoint: 'arrow_forward',
      Icons.home.codePoint: 'home',
      Icons.search.codePoint: 'search',
      Icons.menu.codePoint: 'menu',
      Icons.close.codePoint: 'close',
      Icons.add.codePoint: 'add',
      Icons.remove.codePoint: 'remove',
      Icons.edit.codePoint: 'edit',
      Icons.delete.codePoint: 'delete',
      Icons.save.codePoint: 'save',
      Icons.settings.codePoint: 'settings',
      Icons.person.codePoint: 'person',
      Icons.email.codePoint: 'email',
      Icons.phone.codePoint: 'phone',
      Icons.favorite.codePoint: 'favorite',
      Icons.star.codePoint: 'star',
      Icons.visibility.codePoint: 'visibility',
      Icons.visibility_off.codePoint: 'visibility_off',
      Icons.lock.codePoint: 'lock',
      Icons.play_arrow.codePoint: 'play_arrow',
      Icons.pause.codePoint: 'pause',
      Icons.check.codePoint: 'check',
      Icons.error.codePoint: 'error',
      Icons.warning.codePoint: 'warning',
      Icons.info.codePoint: 'info',
      // Add more mappings as needed
    };
    
    return codePointToName[iconData.codePoint];
  }

  // Method to create Icon with simplified JSON structure using icon names
  static Map<String, dynamic> toSimpleJson(Icon icon) {
    return {
      'iconName': getIconName(icon.icon),
      'iconData': icon.icon != null ? _iconDataToJson(icon.icon) : null,
      'size': icon.size,
      'fill': icon.fill,
      'weight': icon.weight,
      'grade': icon.grade,
      'opticalSize': icon.opticalSize,
      'color': icon.color?.value,
      'shadows': icon.shadows?.map(_shadowToJson).toList(),
      'semanticLabel': icon.semanticLabel,
      'textDirection': icon.textDirection?.index,
    };
  }

  // Method to create Icon from simplified JSON structure
  static Icon fromSimpleJson(Map<String, dynamic> json) {
    IconData? iconData;
    
    // Try to get icon from name first, fallback to iconData
    if (json['iconName'] != null) {
      iconData = _getIconDataFromName(json['iconName'] as String);
    }
    
    if (iconData == null && json['iconData'] != null) {
      iconData = _iconDataFromJson(json['iconData']);
    }
    
    return Icon(
      iconData,
      size: json['size'] != null ? (json['size'] as num).toDouble() : null,
      fill: json['fill'] != null ? (json['fill'] as num).toDouble() : null,
      weight: json['weight'] != null ? (json['weight'] as num).toDouble() : null,
      grade: json['grade'] != null ? (json['grade'] as num).toDouble() : null,
      opticalSize: json['opticalSize'] != null ? (json['opticalSize'] as num).toDouble() : null,
      color: json['color'] != null ? Color(json['color'] as int) : null,
      shadows: json['shadows'] != null 
          ? (json['shadows'] as List).map((e) => _shadowFromJson(e)).toList()
          : null,
      semanticLabel: json['semanticLabel'] as String?,
      textDirection: json['textDirection'] != null 
          ? TextDirection.values[json['textDirection'] as int]
          : null,
    );
  }
}