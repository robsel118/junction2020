const functions = require('firebase-functions');
const admin = require('firebase-admin');
import { Response } from 'express'

admin.initializeApp();

// handle incoming reqs to 
exports.addMeasurement = functions.https.onRequest(async (req: { body:Record<string, any> }, res: Response) => {
    const itemWeight = req.body["weight"]
    const scale = req.body["scale"]
    functions.logger.log('We gone some value ' + itemWeight + ' with scale ' + scale);

    admin.database().ref('/measurements/' + scale + '/inputs').push({
        weight: itemWeight,
      }).then(() => {
        console.log('New Message written');
        // Returning the sanitized message to the client.
        res.json({ text: "message added" });
      })
        .catch((error: any) => {
            // Re-throwing the error as an HttpsError so that the client gets the error details.
            throw new functions.https.HttpsError('unknown', error.message, error);
        });
  });
