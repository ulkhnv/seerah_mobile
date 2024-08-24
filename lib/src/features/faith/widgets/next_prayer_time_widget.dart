import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seerah_mobile/src/features/faith/widgets/timer_widget.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import 'faith_container_widget.dart';

class NextPrayerTimeWidget extends ConsumerWidget {
  final int index;
  final String time;

  const NextPrayerTimeWidget(this.index, this.time, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = S.of(context);
    final theme = Theme.of(context);
    return FaithContainerWidget(
      verticalPadding: 16,
      horizontalPadding: 12,
      color: lightGrey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${lang.next}: ${_getName(context, index)}",
            style: theme.textTheme.bodyMedium,
          ),
          TimerWidget(time, index == 0),
        ],
      ),
    );
  }

  String _getName(BuildContext context, int index) {
    switch (index) {
      case 0:
        return S.of(context).fajr;
      case 1:
        return S.of(context).sunrise;
      case 2:
        return S.of(context).zuhr;
      case 3:
        return S.of(context).asr;
      case 4:
        return S.of(context).magrib;
      case 5:
        return S.of(context).isha;
      default:
        return "";
    }
  }
}
