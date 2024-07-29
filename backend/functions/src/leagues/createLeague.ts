import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { createUserLeague } from "../userLeagues/createUserLeague";

export const createLeague = functions.https.onCall(async (data: LeagueProps, context) => {
    const { name, withAccessCode, payment } = data;
    const uid = context.auth?.uid;
    const leagueRef = await admin.firestore().collection('leagues').add({
        name,
        withAccessCode,
        payment,
        createdBy: uid,
        createdAt: new Date(),
        admins: [uid],
    });

    const userLeagueRef = await createUserLeague(
        {
            leagueName: name,
            leagueId: leagueRef.id,
            userId: uid!,
            leaguePhotoURL: '',
            isAdmin: true,
        }
    );
    return userLeagueRef.writeTime;
})