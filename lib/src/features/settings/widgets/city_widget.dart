import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/providers/providers.dart';
import '../../../core/utils/utils.dart';
import '../pages/pages.dart';
import 'widgets.dart';

class CityWidget extends ConsumerWidget {
  const CityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = S.of(context);
    final theme = Theme.of(context);
    final city = ref.watch(cityNotifierProvider);
    return SettingsContainer(
      left: Text(
        lang.city,
        style: theme.textTheme.bodyMedium,
      ),
      right: Text(
        city.name,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: primaryGreen,
          fontWeight: FontWeight.bold,
        ),
      ),
      action: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CityPage()),
        );
      },
    );
  }
}
