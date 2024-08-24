import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../core/constants/constants.dart';
import '../../../core/providers/providers.dart';
import '../../../core/utils/utils.dart';
import '../../faith/widgets/widgets.dart';

class TasbihBody extends ConsumerStatefulWidget {

  const TasbihBody({super.key});

  @override
  ConsumerState<TasbihBody> createState() => _TasbihBodyState();
}

class _TasbihBodyState extends ConsumerState<TasbihBody> {
  Color _containerColor = lightGrey;
  Color _indicatorColor = Colors.black.withOpacity(0.05);
  late TasbihNotifier tasbihNotifier;

  @override
  void initState() {
    super.initState();
    tasbihNotifier = ref.watch(tasbihNotifierProvider.notifier);
  }

  @override
  Widget build(BuildContext context) {
    final tasbih = ref.watch(tasbihNotifierProvider);
    return Container(
      color: lightGrey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${tasbih.aim}",
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen),
            ),
            const SizedBox(
              height: 16,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _containerColor,
                  ),
                  child: CircularProgressIndicator(
                    value: tasbih.dhikr / tasbih.aim,
                    strokeWidth: 5,
                    backgroundColor: _indicatorColor,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(primaryGreen),
                  ),
                ),
                Text(
                  "${tasbih.dhikr}",
                  style: const TextStyle(
                      fontSize: 60, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  tasbih.dhikr++;
                  _containerColor = lightGreen;
                  _indicatorColor = lightGreenCover;
                });

                Future.delayed(const Duration(milliseconds: 100), () {
                  setState(() {
                    _containerColor = lightGrey;
                    _indicatorColor = Colors.black.withOpacity(0.05);
                  });
                });
              },
              child: FaithContainerWidget(
                width: MediaQuery.of(context).size.width - 50,
                height: 120,
                borderRadius: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/faith/tasbih.png",
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      S.of(context).dhikr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    tasbihNotifier.saveTasbih();
    super.dispose();
  }
}
