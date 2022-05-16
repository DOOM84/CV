import {getDatabase, ref, get, query} from "firebase/database";

const db = getDatabase();

export default defineEventHandler(async (event) => {

    try {
        const categoriesSnap = await get(query(ref(db, `categories`)));
        const categoriesArray = [];
        categoriesSnap.forEach((arr) => {
            categoriesArray.push(arr.val());
        })

        return categoriesArray;

    } catch (e) {
        //console.log(e);
        event.res.statusCode = 404;
        event.res.end('Error occured. Try again later...');
    }

})

