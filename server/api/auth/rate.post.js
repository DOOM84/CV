import admin from "firebase-admin";
import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import {useCookie} from "h3";
import {getDatabase, ref, set, update, remove, get, query} from "firebase/database";

const db = admin.database();
const dBase = getDatabase();


export default defineEventHandler(async (event) => {

    try {

        const token = useCookie(event.req, 'token')

        const {uid} = await admin.auth().verifyIdToken(token);

        const form = formidable();

        const {slug} = await new Promise((resolve, reject) => {
            form.parse(event.req, (err, fields, files) => {
                resolve(firstValues(form, fields))
            });
        })

        const postLikesRefSnap = await get(query(ref(dBase, 'likes/' + slug + '/' + uid)));

        const isLiked = !!postLikesRefSnap.val();

        if (isLiked) {
            await remove(ref(dBase, 'likes/' + slug + '/' + uid));
        } else {
            await set(ref(dBase, 'likes/' + slug + '/' + uid), true);
        }

        const userRef = await db.ref('likes/' + slug);

        const likes = await new Promise((resolve, reject) => {
            userRef.once('value', async (snapshot) => {
                const likes = snapshot.numChildren()

                update(ref(dBase, 'posts/' + slug), {
                    likes: likes
                }).then(() => {
                    resolve(likes)
                });
            })
        })

        return {
            likes,
            isLiked: !isLiked
        }
    } catch (e) {
        event.res.statusCode = 401;
        event.res.end(JSON.stringify({
            msg: 'Unauthenticated'
        }));
    }

})
