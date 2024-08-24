import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../data/models/prayer_time.dart';

class PrayerTimeWidget extends StatelessWidget {
  final PrayerTime prayerTime;
  final int index;

  const PrayerTimeWidget(
    this.prayerTime,
    this.index, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: prayerTime.isCurrent ? lightGreen : lightGrey,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Row(
          children: [
            _getImage(),
            const Gap(8),
            _getName(context),
            const Spacer(),
            Text(
              prayerTime.time,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.normal,
                color: prayerTime.isActive ? black : black50,
              ),
            ),
            const Gap(12),
            Image.asset(
              "assets/images/faith/sound_on.png",
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Image _getImage() {
    final String url;

    switch (index) {
      case 0:
        url = "assets/images/faith/fajr.png";
      case 1:
        url = "assets/images/faith/sunrise.png";
      case 2:
        url = "assets/images/faith/zuhr.png";
      case 3:
        url = "assets/images/faith/asr.png";
      case 4:
        url = "assets/images/faith/magrib.png";
      case 5:
        url = "assets/images/faith/isha.png";
      default:
        url = "";
    }
    return Image.asset(
      url,
      color: prayerTime.isActive
          ? (prayerTime.isCurrent ? primaryGreen : black)
          : black50,
      width: 20,
      height: 20,
    );
  }

  Text _getName(BuildContext context) {
    final lang = S.of(context);
    final String name;
    switch (index) {
      case 0:
        name = lang.fajr;
      case 1:
        name = lang.sunrise;
      case 2:
        name = lang.zuhr;
      case 3:
        name = lang.asr;
      case 4:
        name = lang.magrib;
      case 5:
        name = lang.isha;
      default:
        name = "";
    }
    return Text(
      name,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: prayerTime.isActive ? black : black50,
          ),
    );
  }
}
