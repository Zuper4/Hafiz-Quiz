import 'package:flutter/material.dart';
import '../models/surah.dart';

class OptionButton extends StatelessWidget {
  final Surah surah;
  final bool isSelected;
  final bool isCorrect;
  final bool isAnswered;
  final VoidCallback onTap;

  const OptionButton({
    super.key,
    required this.surah,
    required this.isSelected,
    required this.isCorrect,
    required this.isAnswered,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? borderColor;
    Color? textColor;

    if (isAnswered) {
      if (isCorrect) {
        backgroundColor = Colors.green.withOpacity(0.2);
        borderColor = Colors.green;
        textColor = Colors.green.shade800;
      } else if (isSelected) {
        backgroundColor = Colors.red.withOpacity(0.2);
        borderColor = Colors.red;
        textColor = Colors.red.shade800;
      }
    } else if (isSelected) {
      backgroundColor = Theme.of(context).colorScheme.primaryContainer;
      borderColor = Theme.of(context).colorScheme.primary;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: isAnswered ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor ??
                    Theme.of(context).colorScheme.outline.withOpacity(0.3),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (isAnswered && isCorrect)
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  )
                else if (isAnswered && isSelected)
                  const Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 24,
                  )
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                    ),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        surah.transliteration,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        surah.nameEnglish,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: textColor?.withOpacity(0.8) ??
                                  Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.7),
                            ),
                      ),
                    ],
                  ),
                ),
                Text(
                  surah.nameArabic,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: textColor,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
