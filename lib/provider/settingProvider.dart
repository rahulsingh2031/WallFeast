import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallpaper_gallery/modal/setting.dart';

class SettingStateNotifier extends StateNotifier<Setting> {
  SettingStateNotifier() : super(Setting());
  Future<void> initializeOnLoad() async {
    if (state.hasInitialized) return;
    state = await Setting.initialize();
  }

  Future<void> setSetting(Setting setting) async {
    await Setting.setSetting(setting);
    state = setting;
  }
}

final settingProvider = StateNotifierProvider<SettingStateNotifier, Setting>(
    (ref) => SettingStateNotifier());
