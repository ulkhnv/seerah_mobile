import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/utils.dart';
import '../widgets/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lang.settings,
                style: theme.textTheme.titleLarge,
              ),
              const Gap(24),
              const CityWidget(),
              const Gap(12),
              const LanguageWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
