import 'package:flutter/material.dart';
import 'package:admobt/l10n/app_localizations.dart';
import 'package:admobt/widgets/stat_card.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)?.welcomeTitle ??
                'Welcome to AdMob Demo',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)?.welcomeSubtitle ??
                'Explore all AdMob ad formats in creative ways',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              StatCard(
                title: 'Banners',
                subtitle: '5 Types',
                color: Colors.blue,
              ),
              SizedBox(width: 12),
              StatCard(
                title: 'Interstitial',
                subtitle: 'Smart Triggers',
                color: Colors.orange,
              ),
              SizedBox(width: 12),
              StatCard(
                title: 'Rewarded',
                subtitle: 'Gamified',
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
