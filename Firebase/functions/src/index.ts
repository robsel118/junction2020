const functions = require('firebase-functions');
const admin = require('firebase-admin');
import { Response } from 'express'

// For future work with Cloud functions. See proper usage of Promises here:
// https://github.com/firebase/functions-samples/blob/master/fcm-notifications/functions/index.js
// Note to self: dont even try with TypeScript as there doesnt appear to be working type definitions for Firebase -> problems with IDE and linter

admin.initializeApp();

// handle incoming reqs to /addMeasurement
exports.addMeasurement = functions.https.onRequest(async (req: { body:Record<string, any> }, res: Response) => {
    const itemWeight = req.body["weight"]
    const scale = req.body["scale"]

    admin.database().ref('/measurements/' + scale + '/inputs').push({
        weight: itemWeight,
      }).then(() => {
        console.log('New measurement added');
        res.json({ text: "Measurement added" });
      })
        .catch((error: any) => {
            // Re-throwing the error as an HttpsError so that the client gets the error details.
            throw new functions.https.HttpsError('unknown', error.message, error);
        });
  });

  // TODO: handle the scale ID properly. Eventually the scales would auth themselves via client app
  // This function listens to new measurements being created and recalculates aggregated data based on them
  exports.onMeasurement = functions.database.ref('measurements/{scale}/inputs/{input}').onCreate((snapshot: any, context: any) => {
    return getValueFromReference(admin.database().ref("measurements/scale_1/")).then((scale: any) => {
        const itemWeight = snapshot.child('weight').val()
        const avgUse = scale["average_usage"]
        const timesUsed = scale['number_of_uses'] // should reset when new item is added from app
        const currentWeight = scale['current_weight']
        const maxWeight = scale['max_weight']
        const currentUse = currentWeight - itemWeight // naive, doesn't take into account new item scenario
        const newAvg = (avgUse * timesUsed + currentUse) / (timesUsed + 1)
        return Promise.all([
            updateProperties(admin.database().ref("measurements/scale_1/"), 'average_usage', newAvg),
            updateProperties(admin.database().ref("measurements/scale_1/"), 'number_of_uses', timesUsed + 1),
            updateProperties(admin.database().ref("measurements/scale_1/"), 'current_weight', itemWeight),
            updateProperties(admin.database().ref("measurements/scale_1/"), 'remaining_usages', itemWeight / newAvg),
            updateProperties(admin.database().ref("scales/scale_1/"), 'remaining_usages', itemWeight / newAvg),
            updateProperties(admin.database().ref("scales/scale_1/"), 'remaining_percent', currentWeight / maxWeight),
        ])
    });
  });

  // Listens to changes on scale node, if percentage is less than a given threshold, send the user a push notification
  exports.onPecentageChanged = functions.database.ref('scales/{scale}').onWrite((change: any, context: any) => {
    if (!change.after.exists()) {
        return null;
    }

    if (change.after.child('remaining_percent').val() > 0.2) {
        return null;
    }

    // TODO: user a real user id
    return getValueFromReference(admin.database().ref("pns/user_1/")).then((user: any) => {
        const itemName = change.after.child('current_item').val()
        const remainingPercentage = change.after.child('remaining_percent').val()
        const remainingUsages = change.after.child('remaining_usages').val()
        const fcmKey = user["fcm_key"]
        const payload = {
            notification: {
                title: "Item " + itemName + " is running out soon!",
                body: itemName + " only has " + ((remainingPercentage * 100)|0) + "% left. It is about " + remainingUsages + " usages.",
                sound: "default",
            },
        };
        return admin.messaging().sendToDevice(fcmKey, payload);
    });
  });


  /* Helper functions */
  function getValueFromReference(ref:any) {
    return new Promise((resolve) => {
      ref.once('value', (snapshot:any) => {
        resolve(snapshot.val())
      });
    });
  }

  function updateProperties(ref:any, key:any, value: any) {
    return ref.update({
        [key]: value,
    });
}