import {
    getDatabase,
    ref,
    get,
    query,
} from "firebase/database";
import getTagsByPost from '~/helpers/manyToMany';
const db = getDatabase();
import {useCookie} from "h3";
import admin from "firebase-admin";

export default defineEventHandler(async (event) => {

    try {

        const token = useCookie(event.req, 'token');

        const {slug} = useQuery(event);

        const postSnap = await get(query(ref(db, `posts/${slug}`)));

        if (!postSnap.val() || !postSnap.val().status) {

            const e = new Error('Not found');
            e.code = '404';
            e.statusCode = 404;

            await Promise.reject(e);
        }

        const adminDb = admin.database();

        let isLiked

        try {
            const {uid} = await admin.auth().verifyIdToken(token);
            const postLikesRef = await adminDb.ref('likes/' + slug + '/' + uid);

            isLiked = await new Promise((resolve, reject) => {
                postLikesRef.once('value', async (snap) => {
                    resolve(!!snap.val())
                })
            })
        } catch (e) {
            isLiked = false;
        }

        const post = postSnap.val();

        post.isLiked = isLiked;

        let postTags;

        await getTagsByPost(slug, 'postTags', 'tags').then(function (res) {
            postTags = res;
        }).catch(function (error) {
            console.error(error);
        });

        event.res.setHeader('Content-Type', 'application/json');

       return  {
            post,
            postTags,
        };

    } catch (e) {


        /*if(e.statusCode === 404){
            //console.log(e.message);

            event.res.statusCode = 404;
            event.res.end('Not found')
        }*/

        event.res.statusCode = 404;
        event.res.end('Not found')

        //event.res.statusCode = 404;
       // event.res.end('Error occured. Try again later...');
    }

})

