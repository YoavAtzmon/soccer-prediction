import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { log } from 'firebase-functions/logger';

export const leaveLeague = functions.https.onCall(async (leagueId: string, context) => {
    const uid = context.auth?.uid as string;

    try {
        const leagueRef = admin.firestore().collection('leagues').doc(leagueId);
        const userRef = admin.firestore().collection('users').doc(uid);

        const league = await leagueRef.get();
        const user = await userRef.get();

        const userLeagues = user.data()?.leagues || [];
        const leagueMembers = league.data()?.members || [];

        if (league.exists) {
            if (!leagueMembers.includes(uid) || !userLeagues.includes(leagueId)) {
                throw new functions.https.HttpsError('not-found', 'User is not in this league.');
            }

            await leagueRef.update({
                members: leagueMembers.filter((memberId: string) => memberId !== uid)
            });

            await userRef.update({
                leagues: userLeagues.filter((id: string) => id !== leagueId)
            });

            return { message: `User ${uid} left league ${leagueId}` };
        } else {
            throw new functions.https.HttpsError('not-found', 'League does not exist');
        }
    } catch (error) {
        log(`Error leaving league: ${error}`);
        throw new functions.https.HttpsError('unknown', 'Error leaving league.', error);
    }
});