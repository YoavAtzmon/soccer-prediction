import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { log } from "firebase-functions/logger";

export const createLeague = functions.https.onCall(async (data: LeagueProps, context) => {
    log(`Creating league: ${data}`);
    try {
        const { leagueName, withPayment, paymentLink, leaguePhotoURL } = data;
        const uid = context.auth?.uid;
        const userRef = await admin.firestore().collection('users').doc(uid as string).get();
        const userRefLeagues = userRef.data()?.leagues || [];
        const leagueRef = await admin.firestore().collection('leagues').add({
            leagueName,
            paymentLink,
            withPayment,
            createdBy: uid,
            createdAt: new Date(),
            admins: [uid],
            members: [uid],
            leaguePhotoURL
        });
        await admin.firestore().collection('users').doc(uid as string).update({
            leagues: [...userRefLeagues, leagueRef.id]
        });
        return leagueRef.id;
    } catch (error) {
        log(`Error creating league: ${error}`);
        return Error('Error creating league' + error?.toString());
    }

})