import 'package:morningbrew/widgets/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future savedSettings(SavedSettings savedSettings) async {
    final pref = await SharedPreferences.getInstance();

    await pref.setString('ticker1', savedSettings.ticker1);
    await pref.setString('ticker2', savedSettings.ticker2);
  }
}

Future<SavedSettings> getSettings() async {
  final pref = await SharedPreferences.getInstance();
  final ticker1 = pref.getString('ticker1') ?? 'amd';
  final ticker2 = pref.getString('ticker2') ?? 'tsla';
  return SavedSettings(ticker1: ticker1, ticker2: ticker2);
}
