import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions'
export const getUserLeagues = functions.https.onCall(async (_, context) => {
    const userLeagues = await admin.firestore().collection('userLeague').where('userId', '==', context.auth?.uid).get();
    return userLeagues.docs.map(doc => doc.data());
})

