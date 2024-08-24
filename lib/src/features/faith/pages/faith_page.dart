import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:seerah_mobile/src/features/faith/widgets/qibla_tasbih_widget.dart';

import '../../../core/providers/providers.dart';
import '../data/models/prayer_time.dart';
import '../widgets/widgets.dart';

class FaithPage extends ConsumerWidget {
  const FaithPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prayerTimes = ref.watch(prayerTimesProvider);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const LocationDateWidget(),
              const Gap(40),
              ...prayerTimes.when(
                data: (prayerTimes) {
                  final currentIndex =
                      prayerTimes.indexWhere((e) => e.isCurrent);
                  final nextIndex = currentIndex == 5 ? 0 : currentIndex + 1;
                  return [
                    NextPrayerTimeWidget(
                        nextIndex, prayerTimes[nextIndex].time),
                    const Gap(12),
                    ...prayerTimes.asMap().entries.map((entry) {
                      int index = entry.key;
                      PrayerTime prayerTime = entry.value;
                      return PrayerTimeWidget(prayerTime, index);
                    }),
                  ];
                },
                error: (err, stack) => [Text('Error: $err')],
                loading: () => [const CircularProgressIndicator()],
              ),
              const Gap(40),
              const QiblaTasbihWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
