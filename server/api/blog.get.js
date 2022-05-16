import {
    getDatabase,
    ref,
    get,
    query,
    orderByChild,
    limitToLast,
    endAt,
} from "firebase/database";

const db = getDatabase();


export default defineEventHandler(async (event) => {

    try {
        const perPage = 10;

        let {lastTimeStamp, itemsLength} = useQuery(event)

        let posts = [];

        if (!lastTimeStamp) {
            const postsSnap = await get(query(ref(db, 'posts'), orderByChild('createdAt'), limitToLast(perPage)));

            postsSnap.forEach((arr) => {
                posts.push(arr.val())
            })

        } else {

            posts = await getNextPage(lastTimeStamp, +itemsLength + perPage);

        }

        posts = posts.map(post => {delete post.body; return post})//.filter((post)=>post.status)

        posts.sort((a, b) => {
            return b.createdAt - a.createdAt;
        });

        return {
            posts,
        };

    } catch (e) {
        event.res.statusCode = 404;
        event.res.end('Error occured');
    }

})

async function getNextPage(lastTimeStamp, limit) {

    const postsSnap = await get(query(ref(db, 'posts'), orderByChild('createdAt'), endAt(lastTimeStamp), limitToLast(limit)));
    const list = [];

    postsSnap.forEach(snapshot => {
        let value = snapshot.val();
        value.key = snapshot.key;
        let listItemExist = false;
        list.forEach(element => {
            if (element.key === value.key) {
                listItemExist = true;
            }
        });
        if (!listItemExist) {
            list.push(value);

        } else {
            console.log("item already exist not adding");
        }
    });

    return list;
}
