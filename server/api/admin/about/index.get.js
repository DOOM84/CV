import {getDatabase, ref, get, query} from "firebase/database";

const db = getDatabase();

export default defineEventHandler(async (event) => {

    try {
        const aboutSnap = await get(query(ref(db, `trainings`)));

        return Object.entries(aboutSnap.val()).map(([key, value]) => value)
            .sort((a, b) => {
                return b.begin - a.begin;
            });


    } catch (e) {
        event.res.statusCode = 404;
        event.res.end('Error occured. Try again later...');
    }

})


