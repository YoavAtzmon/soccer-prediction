import 'package:cloud_functions/cloud_functions.dart';
import 'package:namer_app/config/env.dart';
import 'package:namer_app/models/user_league.dart';

class UserLeaguesService {
  final FirebaseFunctions _functions = EnvironmentConfig().functions;

  Future<List<UserLeagueProps>> _getUserLeagues(String uid) async {
    try {
      final HttpsCallableResult result =
          await _functions.httpsCallable("getUserLeagues").call(uid);
      final List<dynamic> data = result.data as List<dynamic>;

      return data
          .map((item) => UserLeagueProps.fromMap(
              Map<String, dynamic>.from(item as Map<Object?, Object?>)))
          .toList();
    } catch (e) {
      print('Error in _getUserLeagues: $e');
      rethrow;
    }
  }

  Future<List<UserLeagueProps>> Function(String) get getUserLeagues =>
      _getUserLeagues;
}
