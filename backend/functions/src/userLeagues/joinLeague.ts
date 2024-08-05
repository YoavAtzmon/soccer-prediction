import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { log } from 'firebase-functions/logger';
export const joinLeague = functions.https.onCall(async (leagueId: string, context) => {
    const uid = context.auth?.uid as string;
    try {
        const leagueRef = admin.firestore().collection('leagues').doc(leagueId);
        const userRef = admin.firestore().collection('users').doc(uid);
        const league = await leagueRef.get();
        const user = await userRef.get();
        const userLeagues = user.data()?.leagues || [];
        const leagueMembers = league.data()?.members || [];
        if (league.exists) {
            if (leagueMembers.includes?.(uid) || userLeagues.includes?.(leagueId)) {
                throw new functions.https.HttpsError('already-exists', 'User is already in this league.');
            }
            await leagueRef.update({
                members: [...leagueMembers, uid]
            });
            await userRef.update({
                leagues: [...userLeagues, leagueId]
            });
            return { message: `User ${uid} joined league ${leagueId}` };
        } else {
            throw new functions.https.HttpsError('unknown', 'Error joining league. league does not exist');
        }
    } catch (error) {
        log(`'Error joining league.' ${error}`);
        throw new functions.https.HttpsError('unknown', 'Error joining league.', error);
    }

});