import admin from "firebase-admin";
import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import {getDatabase, ref, update, remove} from "firebase/database";

const db = admin.database();
const dBase = getDatabase();


export default defineEventHandler(async (event) => {

    try {

        const form = formidable();

        const {id, slug} = await new Promise((resolve, reject) => {
            form.parse(event.req, (err, fields, files) => {
                resolve(firstValues(form, fields))
            });
        })

        await remove(ref(dBase, 'comments/' + slug + '/' + id));

        const postCommentsRef = await db.ref('comments/' + slug);

        await postCommentsRef.once('value', async (snapshot) => {

            const commentsCount = snapshot.numChildren();

            await update(ref(dBase, 'posts/' + slug), {
                comments: commentsCount
            })
        })

        return {
            toDel: id,
        };

    } catch (e) {

        event.res.statusCode = 401;
        event.res.end(JSON.stringify({
            msg: 'Unauthenticated'
        }));

    }

})
