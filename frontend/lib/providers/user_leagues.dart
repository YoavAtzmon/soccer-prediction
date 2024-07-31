import 'package:flutter/material.dart';
import 'package:namer_app/models/user_league.dart';
import 'package:namer_app/services/user_leagues.dart';

class UserLeagueProvider extends ChangeNotifier {
  List<UserLeagueProps> userLeagues = [];
  bool isLoading = false;

  void setUserLeagues(List<UserLeagueProps> leagues) {
    userLeagues = leagues;
    notifyListeners();
  }

  Future<dynamic> joinLeague(String leagueCode) async {
    final res = await UserLeaguesService().joinLeague(leagueCode);
    fetchUserLeagues();
    return res;
  }

  Future<void> fetchUserLeagues() async {
    if (isLoading) return; // Prevent multiple simultaneous fetches

    isLoading = true;

    try {
      final leagues = await UserLeaguesService().getUserLeagues();
      setUserLeagues(leagues);
    } catch (e) {
      // Handle error
      print('Error fetching leagues: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
