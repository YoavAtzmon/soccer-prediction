import 'package:cloud_functions/cloud_functions.dart';
import 'package:namer_app/config/env.dart';
import 'package:namer_app/models/league.dart';
import 'package:namer_app/models/user.dart';

class LeagueService {
  final FirebaseFunctions _functions = EnvironmentConfig().functions;
  Future<String> _createLeague(LeagueProps leagueData) async {
    try {
      var resJson = leagueData.toJson();
      var res = await _functions.httpsCallable("createLeague").call(resJson);
      return res.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _deleteLeague(String leagueId) async {
    try {
      await _functions.httpsCallable("deleteLeague").call(leagueId);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserProps>> _getLeagueUsers(String leagueId) async {
    try {
      final HttpsCallableResult result =
          await _functions.httpsCallable("getLeagueUsers").call(leagueId);
      final List<dynamic> data = result.data;

      return data
          .map((item) => UserProps.fromMap(Map<String, dynamic>.from(item)))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> Function(String) get deleteLeague => _deleteLeague;
  Future<String> Function(LeagueProps) get createLeague => _createLeague;
  Future<List<UserProps>> Function(String) get getLeagueUsers =>
      _getLeagueUsers;
}
