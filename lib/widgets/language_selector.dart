import 'package:flutter/material.dart';
import 'package:admobt/l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language, color: Colors.white),
      tooltip: 'Select Language',
      onSelected: (Locale locale) {
        // This would typically update the app's locale
        // For now, we'll just show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Language changed to: ${locale.languageCode.toUpperCase()}',
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem<Locale>(
          value: Locale('en'),
          child: Text('English'),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('es'),
          child: Text('Español'),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('fr'),
          child: Text('Français'),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('de'),
          child: Text('Deutsch'),
        ),
      ],
    );
  }
}
