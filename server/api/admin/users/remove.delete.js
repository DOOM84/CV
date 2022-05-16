import admin from "firebase-admin";
import formidable from "formidable";
import {firstValues} from 'formidable/src/helpers/firstValues.js';
import {get, getDatabase, query, ref, remove} from "firebase/database";
import fs from "fs";
import setFilePath from "~/helpers/upload/setFilePath";
const dBase = getDatabase();

export default defineEventHandler(async (event) => {

    try {

        const form = formidable();

        const {data} = await new Promise((resolve, reject) => {
            form.parse(event.req, (err, fields, files) => {
                resolve(firstValues(form, fields))
            });
        })

        const {id} = JSON.parse(data);

            const avaSnap = await get(query(ref(dBase, `avatars/${id}`)));

            if (avaSnap.val().path) {
                if (fs.existsSync(setFilePath('/public' + avaSnap.val().path))) {
                    fs.unlinkSync(setFilePath('/public' + avaSnap.val().path));
                }
            }

        await admin.auth().deleteUser(id);
        await remove(ref(dBase, 'avatars/' + id));

        return {id};

    } catch (e) {

        event.res.statusCode = 401;
        event.res.end(JSON.stringify({
            msg: 'Unauthenticated'
        }));
    }

})
