import * as admin from "firebase-admin";
admin.initializeApp();

export { storeUserData } from "./users/onCreate";
export { createLeague } from "./leagues/createLeague";
export { createUserLeague } from "./userLeagues/createUserLeague";
export { getUserLeagues } from "./userLeagues/getUserLeagues";
export { deleteLeague } from "./leagues/deleteLeague";