import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';
import '../../qibla/pages/pages.dart';
import '../../tasbih/pages/pages.dart';
import 'faith_container_widget.dart';

class QiblaTasbihWidget extends StatelessWidget {
  const QiblaTasbihWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute<QiblaPage>(
                    builder: (context) => const QiblaPage()));
          },
          child: FaithContainerWidget(
            width: 160,
            height: 105,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/faith/kaaba.png",
                  width: 45,
                  height: 45,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  S.of(context).qibla,
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
        ),
        const SizedBox(width: 10,),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute<TasbihPage>(builder: (context) => const TasbihPage()));
          },
          child: FaithContainerWidget(
            width: 160,
            height: 105,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/faith/tasbih.png",
                  width: 45,
                  height: 45,
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(S.of(context).tasbih, style: const TextStyle(fontSize: 20))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
