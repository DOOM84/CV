import {getDatabase, ref, get, query, orderByChild} from "firebase/database";
import getInfoByPost from "~/helpers/manyToMany";

const db = getDatabase();

export default defineEventHandler(async (event) => {

    try {
        const postsSnap = await get(query(ref(db, 'posts'), orderByChild('createdAt')));

        const catsSnap = await get(query(ref(db, 'categories')));

        const tagsSnap = await get(query(ref(db, 'tags')));

        const categories = Object.entries(catsSnap.val()).map(([key, value]) => value);

        const tags = Object.entries(tagsSnap.val()).map(([key, value]) => value);

        const posts = await Promise.all(Object.entries(postsSnap.val()).map(async ([key, value]) => {
            const postCat = await getInfoByPost(value.slug, 'postCategories', 'categories')
            const postTag = await getInfoByPost(value.slug, 'postTags', 'tags');
            return {...value, categories: postCat.map(cat => cat.slug), tags: postTag.map(tag => tag.name)}
        }));

        posts.sort((a, b) => {
            return b.createdAt - a.createdAt;
        });

        return {
            posts: posts,
            tags: tags,
            categories: categories
        };

    } catch (e) {
        event.res.statusCode = 404;
        event.res.end('Error occured. Try again later...');
    }

})