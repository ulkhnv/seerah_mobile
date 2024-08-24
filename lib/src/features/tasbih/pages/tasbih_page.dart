import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seerah_mobile/src/core/providers/providers.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/utils.dart';
import '../data/models/models.dart';
import '../widgets/tasbih_body_widget.dart';

class TasbihPage extends ConsumerStatefulWidget {
  const TasbihPage({super.key});

  @override
  ConsumerState<TasbihPage> createState() => _TasbihPageState();
}

class _TasbihPageState extends ConsumerState<TasbihPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<Color> _textFieldColorNotifier =
      ValueNotifier<Color>(white);
  final FocusNode _focusNode = FocusNode();
  late Tasbih tasbih;
  late TasbihNotifier tasbihNotifier;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    tasbih = ref.watch(tasbihNotifierProvider);
    tasbihNotifier = ref.watch(tasbihNotifierProvider.notifier);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _textFieldColorNotifier.dispose();
    ref.watch(tasbihNotifierProvider.notifier).saveTasbih();
    super.dispose();
  }

  void _handleFocusChange() {
    _textFieldColorNotifier.value = _focusNode.hasFocus ? black5 : white;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context, ref),
      body: const TasbihBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context, WidgetRef ref) {
    return AppBar(
      elevation: 0,
      backgroundColor: white,
      leading: IconButton(
        icon: Image.asset(
          "assets/images/settings/arrow-left.png",
          color: Colors.green,
          width: 30,
          height: 30,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        S.of(context).tasbih,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.normal,
        ),
      ),
      actions: [
        _buildPopupMenu(context, ref),
      ],
    );
  }

  PopupMenuButton<String> _buildPopupMenu(BuildContext context, WidgetRef ref) {

    return PopupMenuButton<String>(
      icon: Image.asset(
        "assets/images/tasbih/ellipsis.png",
        color: darkGrey,
        width: 25,
        height: 25,
      ),
      color: Colors.white,
      elevation: 2,
      offset: const Offset(0, 55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          onTap: () {
            _showEditModal(context, tasbih);
          },
          child: Row(
            children: [
              Text("${tasbih.aim}"),
              const Spacer(),
              Text(
                S.of(context).edit,
                style: const TextStyle(color: primaryGreen),
              ),
            ],
          ),
        ),
        const PopupMenuDivider(
          height: 0,
        ),
        PopupMenuItem<String>(
          onTap: () {
            tasbihNotifier.resetTasbih();
          },
          child: Row(
            children: [
              Text(S.of(context).resetTasbih),
              const Spacer(),
              Image.asset(
                "assets/images/tasbih/reload.png",
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showEditModal(BuildContext context, Tasbih tasbih) {
    _textEditingController.text = tasbih.aim.toString();
    showModalBottomSheet(
      isScrollControlled: true,
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
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: hasBottomPadding ? 0 : 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: middleGrey,
                    width: 35,
                    height: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ValueListenableBuilder<Color>(
                        valueListenable: _textFieldColorNotifier,
                        builder: (context, color, child) {
                          return TextField(
                            textAlign: TextAlign.center,
                            focusNode: _focusNode,
                            controller: _textEditingController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              prefixIcon: GestureDetector(
                                  onTap: () {
                                    final currentValue = int.tryParse(
                                            _textEditingController.text) ??
                                        0;
                                    if (currentValue > 0) {
                                      _textEditingController.text =
                                          (currentValue - 1).toString();
                                    }
                                  },
                                  child: const Icon(
                                    Icons.remove,
                                    color: primaryGreen,
                                  )),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  final currentValue = int.tryParse(
                                          _textEditingController.text) ??
                                      0;
                                  if (currentValue < 1001) {
                                    _textEditingController.text =
                                        (currentValue + 1).toString();
                                  }
                                },
                              ),
                              contentPadding: const EdgeInsets.only(top: 10),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: black10,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: black10,
                                ),
                              ),
                              filled: true,
                              fillColor: color,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
