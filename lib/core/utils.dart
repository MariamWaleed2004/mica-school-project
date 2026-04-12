import 'package:flutter/material.dart';

class AppIcons {
  AppIcons._(); // 🔒 prevents instantiation

  static IconData get(String key) {
    switch (key) {
      case 'calendar_month_rounded':
        return Icons.calendar_month_rounded;

      case 'event_rounded':
        return Icons.event_rounded;

      case 'school_rounded':
        return Icons.school_rounded;

      case 'event':
        return Icons.event;

      case 'person':
        return Icons.person;

      case 'home':
        return Icons.home;

      case 'settings':
        return Icons.settings;

      case 'notifications':
        return Icons.notifications;

      default:
        return Icons.help_outline;
    }
  }
}