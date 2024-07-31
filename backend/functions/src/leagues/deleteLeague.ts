import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const deleteLeague = functions.https.onCall(async (leagueId: string, context) => {
    const uid = context.auth?.uid;
    const league = await admin.firestore().collection('leagues').doc(leagueId).get();
    if (league.data()?.admins.includes(uid)) {
        await admin.firestore().collection('leagues').doc(leagueId).delete();
        await admin.firestore().collection('userLeague').where('leagueId', '==', leagueId).get().then((snapshot) => {
            snapshot.docs.forEach(doc => {
                doc.ref.delete();
            })
        });
        return `League ${leagueId} deleted successfully`;
    } else {
        return Error('You are not an admin of this league');
    }
})