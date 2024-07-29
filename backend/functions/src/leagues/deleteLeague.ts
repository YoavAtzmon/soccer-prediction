import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const deleteLeague = functions.https.onCall(async (leagueId: string, context) => {
    await admin.firestore().collection('leagues').doc(leagueId).delete();
    await admin.firestore().collection('userLeague').where('leagueId', '==', leagueId).get().then((snapshot) => {
        snapshot.docs.forEach(doc => {
            doc.ref.delete();
        })
    });
})