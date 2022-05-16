import getPostsByTag from '~/helpers/manyToMany';
import {get, getDatabase, query, ref} from "firebase/database";

const db = getDatabase();

export default defineEventHandler(async (event) => {
    try {
        const {slug, lastTimeStamp} = useQuery(event);

        const tagSnap = await get(query(ref(db, `tags/${slug}`)));

        if (!tagSnap.val()) {

            const e = new Error('Not found');
            e.code = '404';
            e.statusCode = 404;

            await Promise.reject(e);
        }

        const tag = tagSnap.val();

        const perPage = 10;

        let posts;

        await getPostsByTag(slug, 'tagPosts', 'posts').then(function (res) {

            if (lastTimeStamp) {
                posts = res.filter(post => post.createdAt < lastTimeStamp && !!post.status);
            } else {
                posts = res.filter(post => !!post.status);
            }

            posts = posts.map(post => {delete post.body; return post})

            posts.sort((a, b) => {
                return b.createdAt - a.createdAt;
            });

            posts = posts.slice(0, perPage);

        }).catch(function (error) {
            console.error(error);
        });


        return {
            posts,
            tag
        }
    } catch (e) {

        /*if(e.statusCode === 404){
            //console.log(e.message);

            event.res.statusCode = 404;
            event.res.end('Not found')
        }*/
        event.res.statusCode = 404;
        event.res.end('Not found')
    }
})
