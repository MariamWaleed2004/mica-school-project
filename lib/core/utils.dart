import 'package:flutter/material.dart';

class AppIcons {
  AppIcons._(); 

  static IconData get(String key) {
    switch (key) {
      case 'calendar_month_rounded':
        return Icons.calendar_month_rounded;
      case 'event_rounded':
        return Icons.event_rounded;
      case 'event':
        return Icons.event;

      case 'school_rounded':
        return Icons.school_rounded;
      case 'menu_book_rounded':
        return Icons.menu_book_rounded;
      case 'checkroom_rounded':
        return Icons.checkroom_rounded;
      case 'receipt_long_rounded':
        return Icons.receipt_long_rounded;

      case 'payment_rounded':
        return Icons.payment_rounded;
      case 'account_balance_wallet_rounded':
        return Icons.account_balance_wallet_rounded;
      case 'credit_card_rounded':
        return Icons.credit_card_rounded;
      case 'attach_money_rounded':
        return Icons.attach_money_rounded;

      case 'check_circle_rounded':
        return Icons.check_circle_rounded;
      case 'pending_rounded':
        return Icons.pending_rounded;
      case 'hourglass_top_rounded':
        return Icons.hourglass_top_rounded;
      case 'schedule_rounded':
        return Icons.schedule_rounded;

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