import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions'
export const getUserLeagues = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'The function must be called while authenticated.');
    }

    const uid = context.auth.uid;

    try {
        const userLeaguesSnapshot = await admin.firestore().collection('userLeague')
            .where('userId', '==', uid)
            .get();
        if (userLeaguesSnapshot.empty) {
            return [];
        }
        const leagueIds = userLeaguesSnapshot.docs.map(doc => doc.data().leagueId);
        const leagues = [];
        for (const leagueId of leagueIds) {
            const leagueDoc = await admin.firestore().collection('leagues').doc(leagueId).get();
            if (leagueDoc.exists) {
                leagues.push({ leagueId: leagueDoc.id, ...leagueDoc.data(), userId: uid });
            }
        }
        return leagues;
    } catch (error) {
        console.error('Error getting user leagues:', error);
        throw new functions.https.HttpsError('unknown', 'Failed to get user leagues', error);
    }
})

