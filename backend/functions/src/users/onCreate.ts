import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const storeUserData = functions.auth.user().onCreate(async (user) => {
  try {
    await admin.firestore().collection("users").doc(user.uid).set({
      displayName: user.displayName,
      email: user.email,
      photoURL: user.photoURL,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
    }, {merge: true});

    console.log(`User data stored for ${user.uid}`);
    return null;
  } catch (error) {
    console.error("Error storing user data:", error);
    return null;
  }
});
