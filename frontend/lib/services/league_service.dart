import 'package:cloud_functions/cloud_functions.dart';
import 'package:namer_app/config/env.dart';
import 'package:namer_app/models/league.dart';

class LeagueService {
  final FirebaseFunctions _functions = EnvironmentConfig().functions;
  Future<dynamic> _createLeague(LeagueProps leagueData) async {
    try {
      var json = leagueData.toJson();
      var res = await _functions.httpsCallable("createLeague").call(json);
      return res.data;
    } catch (e) {
      print(e);
    }
  }

  Future<void> _deleteLeague(String leagueId) async {
    try {
      await _functions.httpsCallable("deleteLeague").call(leagueId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> Function(String) get deleteLeague => _deleteLeague;
  Future<dynamic> Function(LeagueProps) get createLeague => _createLeague;
}
