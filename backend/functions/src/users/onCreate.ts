import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const storeUserData = functions.auth.user().onCreate(async (user) => {
  try {
    await admin.firestore().collection("users").doc(user.uid).set({
      displayName: user.displayName,
      email: user.email,
      photoURL: user.photoURL,
      createdAt: new Date(),
    }, { merge: true });
    return null;
  } catch (error) {
    return null;
  }
});
