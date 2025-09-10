import 'package:flutter/material.dart';
import 'package:admobt/widgets/stat_item.dart';

class GameStats extends StatelessWidget {
  final int lives;
  final int score;
  final bool isPremiumUnlocked;
  final double? elevation;

  const GameStats({
    super.key,
    required this.lives,
    required this.score,
    required this.isPremiumUnlocked,
    this.elevation = 4,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StatItem(
              label: 'Lives',
              value: lives.toString(),
              color: Colors.red,
              icon: Icons.favorite,
            ),
            StatItem(
              label: 'Score',
              value: score.toString(),
              color: Colors.blue,
              icon: Icons.star,
            ),
            StatItem(
              label: 'Premium',
              value: isPremiumUnlocked ? 'Yes' : 'No',
              color: isPremiumUnlocked ? Colors.green : Colors.grey,
              icon: isPremiumUnlocked ? Icons.check_circle : Icons.lock,
            ),
          ],
        ),
      ),
    );
  }
}
