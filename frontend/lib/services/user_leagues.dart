import 'package:cloud_functions/cloud_functions.dart';
import 'package:namer_app/config/env.dart';
import 'package:namer_app/models/league.dart';

class UserLeaguesService {
  final FirebaseFunctions _functions = EnvironmentConfig().functions;

  Future<List<LeagueProps>> _getUserLeagues() async {
    try {
      final HttpsCallableResult result =
          await _functions.httpsCallable("getUserLeagues").call();
      final List<dynamic> data = result.data;

      return data
          .map((item) => LeagueProps.fromMap(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      print('Error in _getUserLeagues: $e');
      rethrow;
    }
  }

  Future<dynamic> _joinLeague(String leagueCode) async {
    try {
      final res = await _functions.httpsCallable("joinLeague").call(leagueCode);
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> _leaveLeague(String leagueId) async {
    try {
      final res = await _functions.httpsCallable("leaveLeague").call(leagueId);
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> Function(String) get leaveLeague => _leaveLeague;
  Future<dynamic> Function(String) get joinLeague => _joinLeague;
  Future<List<LeagueProps>> Function() get getUserLeagues => _getUserLeagues;
}
