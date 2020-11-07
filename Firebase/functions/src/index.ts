const functions = require('firebase-functions');
const admin = require('firebase-admin');
import { Response } from 'express'

admin.initializeApp();

// handle incoming reqs to /addMeasurement
exports.addMeasurement = functions.https.onRequest(async (req: { body:Record<string, any> }, res: Response) => {
    const itemWeight = req.body["weight"]
    const scale = req.body["scale"]

    admin.database().ref('/measurements/' + scale + '/inputs').push({
        weight: itemWeight,
      }).then(() => {
        console.log('New measurement added');
        res.json({ text: "ADded" });
      })
        .catch((error: any) => {
            // Re-throwing the error as an HttpsError so that the client gets the error details.
            throw new functions.https.HttpsError('unknown', error.message, error);
        });
  });

  // handle the scale ID properly. Eventually the scales would auth themselves via client app
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