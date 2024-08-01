import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { log } from 'firebase-functions/logger';
export const leaveLeague = functions.https.onCall(async (leagueId: string, context) => {
    const uid = context.auth?.uid;
    log(`User ${uid} leaving league ${leagueId}`);
    try {
        const userLeagueRef = admin.firestore().collection('userLeague').where('userId', '==', uid).where('leagueId', '==', leagueId).limit(1);
        const snapshot = await userLeagueRef.get();

        if (snapshot.empty) {
            throw new functions.https.HttpsError('not-found', 'User is not in this league.');
        }

        await snapshot.docs[0].ref.delete();

        return { success: true, message: 'Successfully left the league.' };
    } catch (error) {
        throw new functions.https.HttpsError('unknown', 'Error leaving league.', error);
    }

});