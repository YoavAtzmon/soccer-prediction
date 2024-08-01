import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { createUserLeague } from "../userLeagues/createUserLeague";

export const createLeague = functions.https.onCall(async (data: LeagueProps, context) => {
    try {
        const { leagueName, withPayment, paymentLink } = data;
        const uid = context.auth?.uid;
        const leagueRef = await admin.firestore().collection('leagues').add({
            leagueName,
            paymentLink,
            withPayment,
            createdBy: uid,
            createdAt: new Date(),
            admins: [uid],
        });

        await createUserLeague(
            {
                leagueId: leagueRef.id,
                userId: uid!,
            }
        );
        return leagueRef.id;
    } catch (error) {
        return Error('Error creating league' + error?.toString());
    }

})