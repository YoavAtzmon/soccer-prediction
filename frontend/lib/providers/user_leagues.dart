import 'package:flutter/material.dart';
import 'package:namer_app/models/league.dart';
import 'package:namer_app/models/user.dart';
import 'package:namer_app/services/league_service.dart';
import 'package:namer_app/services/user_leagues.dart';

class UserLeagueProvider extends ChangeNotifier {
  List<LeagueProps> userLeagues = [];
  bool isLoading = false;

  void setUserLeagues(List<LeagueProps> leagues) {
    userLeagues = leagues;
  }

  Future<dynamic> joinLeague(String leagueCode) async {
    final res = await UserLeaguesService().joinLeague(leagueCode);
    await fetchUserLeagues();
    return res;
  }

  Future<dynamic> leaveLeague(String leagueId) async {
    final res = await UserLeaguesService().leaveLeague(leagueId);
    await fetchUserLeagues();
    return res;
  }

  LeagueProps? getLeague(String leagueId) {
    try {
      return userLeagues.firstWhere((league) => league.leagueId == leagueId);
    } catch (e) {
      // If no league is found, return null or handle the error as needed
      print("No league found with id: $leagueId");
      return null;
    }
  }

  Future<List<UserProps>> getLeagueUsers(String leagueId) async {
    try {
      final usersList = await LeagueService().getLeagueUsers(leagueId);
      return usersList;
    } catch (e) {
      rethrow;
    }
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
