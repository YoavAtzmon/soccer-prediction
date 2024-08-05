import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const getLeagueUsers = functions.https.onCall(async (leagueId: string) => {
    try {

        const league = await admin.firestore().collection('leagues').doc(leagueId).get();
        const members = league.data()?.members || [];
        const users = await Promise.all(members.map(async (memberId: string) => {
            const user = await admin.firestore().collection('users').doc(memberId).get();
            return user.data();
        }));
        return users;
    } catch (error) {
        return Error('Error getting league users' + error?.toString());
    }
})