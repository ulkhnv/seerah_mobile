import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:seerah_mobile/src/core/providers/general_provider.dart';
import 'package:seerah_mobile/src/features/tasbih/data/datasources/tasbih_local_datasource.dart';

import '../../features/tasbih/data/models/tasbih.dart';

final tasbihLocalDataSourceProvider = Provider<TasbihLocalDataSource>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return TasbihLocalDataSource(sharedPreferences: sharedPreferences);
});

class TasbihNotifier extends StateNotifier<Tasbih> {
  final TasbihLocalDataSource tasbihLocalDataSource;

  TasbihNotifier(this.tasbihLocalDataSource)
      : super(Tasbih(aim: 33, dhikr: 0)) {
    getTasbih();
  }

  Future<void> getTasbih() async {
    final tasbih = await tasbihLocalDataSource.getTasbih();
    state = tasbih;
  }

  setTasbih(Tasbih tasbih) {
    state = tasbih;
  }

  saveTasbih() {
    tasbihLocalDataSource.setTasbih(state);

  }

  resetTasbih() {
    state = Tasbih(aim: state.aim, dhikr: 0);
  }
}

final tasbihNotifierProvider =
    StateNotifierProvider<TasbihNotifier, Tasbih>((ref) {
  final tasbihLocalDataSource = ref.read(tasbihLocalDataSourceProvider);
  return TasbihNotifier(tasbihLocalDataSource);
});
