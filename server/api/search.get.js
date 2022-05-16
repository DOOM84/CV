import {
    getDatabase,
    ref,
    get,
    query,
    orderByChild,
} from "firebase/database";

const db = getDatabase();

export default defineEventHandler(async (event) => {

    try {
        const {term, lastTimeStamp} = useQuery(event);

        let strippedTerm = term.replace(/[`~!@#$%^&*()_|+\-=?;:'",.<>{}\[\]\\\/]/gi, '');

        strippedTerm = strippedTerm.replace(/<\/?("[^"]*"|'[^']*'|[^>])*(>|$)/g, "");

        if (!strippedTerm || strippedTerm.length < 3) {
            return []
        }

        const postsSnap = await get(query(ref(db, 'posts'), orderByChild('createdAt')));

        const perPage = 10;

        const postsToSearch = [];

        postsSnap.forEach((arr) => {

            if (lastTimeStamp) {
                if (arr.val().createdAt < lastTimeStamp) {
                    postsToSearch.push(arr.val())
                }
            } else {
                postsToSearch.push(arr.val());
            }
        })

        postsToSearch.sort((a, b) => {
            return b.createdAt - a.createdAt;
        });

        const regex = new RegExp(strippedTerm, 'gi');

        const filtered = postsToSearch.filter(post => !!post.body.match(regex));

        let posts = filtered.slice(0, perPage);

        posts = posts.map(post => {delete post.body; return post})

        return {
            results: filtered.length,
            posts,
        }
    } catch (e) {
        //console.log(e);
        //res.statusCode = 404;
        //res.end('Error occured. Try again later...');
    }

})
