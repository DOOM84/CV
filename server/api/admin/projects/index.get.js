import {
    getDatabase,
    ref,
    get,
    query,
} from "firebase/database";

const db = getDatabase();

export default defineEventHandler(async (event) => {

    try {
        const projectsSnap = await get(query(ref(db, `projects`)));

        return Object.entries(projectsSnap.val()).map(([key, value]) => value)

    } catch (e) {

        event.res.statusCode = 404;
        event.res.end('Error occured. Try again later...');
    }

})