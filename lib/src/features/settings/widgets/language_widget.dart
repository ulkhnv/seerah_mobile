import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/constants.dart';
import '../../../core/providers/providers.dart';
import '../../../core/utils/utils.dart';
import 'widgets.dart';

class LanguageWidget extends ConsumerWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = S.of(context);
    final theme = Theme.of(context);

    return SettingsContainer(
      left: Text(
        lang.language,
        style: theme.textTheme.bodyMedium,
      ),
      right: Text(
        lang.current_language,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: primaryGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
      action: () => _showLanguageModal(context, theme, ref),
    );
  }

  void _showLanguageModal(
      BuildContext context, ThemeData theme, WidgetRef ref) {
    final languageNotifier = ref.read(languageNotifierProvider.notifier);
    final currentLanguage = ref.read(languageNotifierProvider);

    showModalBottomSheet(
      elevation: 0,
      backgroundColor: white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        final mediaQuery = MediaQuery.of(context);
        final hasBottomPadding =
            mediaQuery.viewInsets.bottom > 0 || mediaQuery.padding.bottom > 0;

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 10, bottom: hasBottomPadding ? 0 : 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: middleGrey,
                  width: 35,
                  height: 3,
                ),
                const Gap(10),
                _buildLanguageOption(
                  context,
                  theme,
                  currentLanguage,
                  'Қазақша',
                  'kk',
                  languageNotifier.setLanguage,
                ),
                _buildLanguageOption(
                  context,
                  theme,
                  currentLanguage,
                  'Русский',
                  'ru',
                  languageNotifier.setLanguage,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
      BuildContext context,
      ThemeData theme,
      String currentLanguage,
      String name,
      String code,
      void Function(String) onLanguageChanged) {
    return GestureDetector(
      onTap: () {
        onLanguageChanged(code);
        Navigator.of(context).pop();
      },
      child: Container(
        color: currentLanguage == code ? lightGreen : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: theme.textTheme.bodyMedium,
              ),
              Visibility(
                visible: currentLanguage == code,
                child: Image.asset(
                  "assets/images/settings/checkmark.png",
                  color: primaryGreen,
                  width: 22,
                  height: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
