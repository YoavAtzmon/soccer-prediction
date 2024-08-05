import * as admin from "firebase-admin";
admin.initializeApp();

export { storeUserData } from "./users/onCreate";
export { createLeague } from "./leagues/createLeague";
export { getUserLeagues } from "./userLeagues/getUserLeagues";
export { deleteLeague } from "./leagues/deleteLeague";
export { joinLeague } from "./userLeagues/joinLeague";
export { leaveLeague } from "./userLeagues/leaveLeague";
export { getLeagueUsers } from "./leagues/getLeagueUsers";