import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/constants.dart';
import '../../../core/providers/providers.dart';
import 'faith_container_widget.dart';

class LocationDateWidget extends ConsumerWidget {
  const LocationDateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final city = ref.watch(cityNotifierProvider);
    return Row(
      children: [
        FaithContainerWidget(
          horizontalPadding: 8.0,
          verticalPadding: 8.0,
          child: Image.asset(
            "assets/images/faith/location.png",
            width: 25,
            height: 25,
            color: primaryGreen,
          ),
        ),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(city.name, style: theme.textTheme.titleMedium),
            Text(
              "Сарсенби, 12 Джумада Ас-сани, 1445",
              style: theme.textTheme.bodySmall?.copyWith(
                color: black75,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
