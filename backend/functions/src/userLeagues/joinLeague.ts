import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { createUserLeague } from './createUserLeague';
export const joinLeague = functions.https.onCall(async (leagueId: string, context) => {
    const uid = context.auth?.uid;
    try {
        const league = await admin.firestore().collection('leagues').doc(leagueId).get();
        if (league.exists) {
            await createUserLeague({ leagueName: league.data()?.name, leagueId: leagueId, userId: uid!, leaguePhotoURL: '', isAdmin: false });
            return { message: `User ${uid} joined league ${leagueId}` };
        } else {
            throw new functions.https.HttpsError('unknown', 'Error joining league. league does not exist');
        }
    } catch (error) {
        throw new functions.https.HttpsError('unknown', 'Error joining league.', error);
    }

});