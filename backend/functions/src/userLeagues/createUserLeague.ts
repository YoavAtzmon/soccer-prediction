import * as admin from "firebase-admin";

export const createUserLeague = async (data: UserLeagueProps) => {
    const { leagueId, userId } = data;
    const userLeagueRef = await admin.firestore().collection('userLeague').doc(leagueId + '_' + userId).set({
        leagueId,
        userId,
        createdAt: new Date(),
    });
    return userLeagueRef;
}