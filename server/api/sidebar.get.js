import {
    getDatabase,
    ref,
    get,
    query,
    limitToLast,
    orderByChild
} from "firebase/database";

const db = getDatabase();


export default defineEventHandler(async (event) => {

    try {
        const recPostsSnap = await get(query(ref(db, 'posts'), orderByChild('createdAt'), limitToLast(3)));

        const recentPosts = Object.entries(recPostsSnap.val())
            .map(([key, value]) => ({
                createdAt: value.createdAt,
                ua_title: value.ua_title,
                ru_title: value.ru_title,
                en_title: value.en_title,
                slug: value.slug,
                images: {thumbnail: value.images.thumbnail}
                ,
            }))//.filter((post)=> !!post.status)
            .sort((a, b) => {
                return b.createdAt - a.createdAt;
            })

        const categoriesSnap = await get(query(ref(db, 'categories')));

        const categories = Object.entries(categoriesSnap.val()).map(([key, value]) => value)
            .filter((cat) => !!cat.status)

        const tagsSnap = await get(query(ref(db, 'tags')));

        const tags = Object.entries(tagsSnap.val()).map(([key, value]) => value)

        return {
            recentPosts,
            categories,
            tags
        }
    } catch (e) {
        event.res.statusCode = 404;
        event.res.end('Error occured. Try again later...');
    }

})
