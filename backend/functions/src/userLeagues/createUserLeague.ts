import * as admin from "firebase-admin";

export const createUserLeague = async (data: UserLeagueProps) => {
    const { leagueName, leagueId, userId, leaguePhotoURL } = data;
    const userLeagueRef = await admin.firestore().collection('userLeague').doc(leagueId + '_' + userId).set({
        leagueId,
        userId,
        leagueName,
        leaguePhotoURL,
        createdAt: new Date(),
    });
    return userLeagueRef;
}