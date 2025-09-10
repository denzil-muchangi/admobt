import 'package:flutter/material.dart';

class TriggerCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onPressed;
  final String buttonText;
  final Color? iconColor;
  final Color? buttonColor;
  final Color? buttonTextColor;

  const TriggerCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onPressed,
    this.buttonText = 'Trigger',
    this.iconColor = Colors.deepPurple,
    this.buttonColor = Colors.deepPurple,
    this.buttonTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: iconColor),
        title: Text(title),
        subtitle: Text(description),
        trailing: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            foregroundColor: buttonTextColor,
          ),
          child: Text(buttonText),
        ),
      ),
    );
  }
}
