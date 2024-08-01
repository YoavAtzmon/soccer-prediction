import 'package:cloud_functions/cloud_functions.dart';
import 'package:namer_app/config/env.dart';

class LeagueService {
  final FirebaseFunctions _functions = EnvironmentConfig().functions;
  Future<dynamic> _createLeague(Object leagueData) async {
    try {
      var res = await _functions.httpsCallable("createLeague").call(leagueData);
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
  Future<dynamic> Function(Object) get createLeague => _createLeague;
}
