import {
    getDatabase,
    ref,
    get,
    query, orderByChild,
} from "firebase/database";

const db = getDatabase();

export default defineEventHandler(async (event) => {

    try {
        const {slug} = useQuery(event);

        const commentsSnap = await get(query(ref(db, 'comments/' + slug), orderByChild('createdAt')));

        const comments = [];

        commentsSnap.forEach((arr) => {
            comments.push(arr.val());
        })

        for (const comment of comments) {

            const index = comments.indexOf(comment);
            comments[index].user.avatar = await getAvatar(comments[index].user.id)
        }

        comments.sort((a, b) => {
            return a.createdAt - b.createdAt;
        });

        return {
            comments,
        }

    } catch (e) {
        event.res.statusCode = 404;
        event.res.end('Error occured. Try again later...');
    }


})

async function getAvatar(uid) {

    const avaSnap = await get(query(ref(db, 'avatars/' + uid + '/path')));

    return avaSnap.val();
}

