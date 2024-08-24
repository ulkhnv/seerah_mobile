import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/providers/providers.dart';
import '../../../core/utils/utils.dart';
import '../data/models/models.dart';

class CityPage extends ConsumerStatefulWidget {
  const CityPage({super.key});

  @override
  ConsumerState createState() => _CityPageState();
}

class _CityPageState extends ConsumerState<CityPage> {
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<Color> _textFieldColorNotifier =
      ValueNotifier<Color>(white);
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    _textEditingController.addListener(_handleSearchChange);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _textFieldColorNotifier.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    _textFieldColorNotifier.value = _focusNode.hasFocus ? black5 : white;
  }

  void _handleSearchChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final lang = S.of(context);
    final theme = Theme.of(context);
    final city = ref.watch(cityNotifierProvider);
    final cityNotifier = ref.watch(cityNotifierProvider.notifier);
    final cityListAsyncValue = ref.watch(cityListProvider);

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            "assets/images/settings/arrow-left.png",
            color: primaryGreen,
            width: 30,
            height: 30,
          ),
        ),
        title: _buildSearchTextField(lang.search),
      ),
      body: cityListAsyncValue.when(
        data: (cities) {
          final filteredCities =
              _filterCities(cities, _textEditingController.text);
          return ListView.builder(
            itemCount: filteredCities.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    onTap: () {
                      cityNotifier.setCity(filteredCities[index]);
                    },
                    tileColor: city.slug == filteredCities[index].slug
                        ? lightGreen
                        : white,
                    title: Text(
                      filteredCities[index].name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                          color: city == filteredCities[index]
                              ? darkGreen
                              : black),
                    ),
                    trailing: Visibility(
                      visible: city.slug == filteredCities[index].slug,
                      child: Image.asset(
                        "assets/images/settings/checkmark.png",
                        color: primaryGreen,
                        width: 22,
                        height: 22,
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    color: black5,
                  ),
                ],
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildSearchTextField(String hintText) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(right: 25.0, top: 0),
        child: SizedBox(
          height: 40,
          child: ValueListenableBuilder<Color>(
            valueListenable: _textFieldColorNotifier,
            builder: (context, color, child) {
              return TextField(
                focusNode: _focusNode,
                controller: _textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: hintText,
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
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      "assets/images/settings/search.png",
                      color: darkGrey,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<City> _filterCities(List<City> cities, String query) {
    if (query.isEmpty) {
      return cities;
    }
    return cities
        .where((city) => city.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
  }
}
