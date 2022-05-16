import formidable from "formidable";
import {firstValues} from 'formidable/src/helpers/firstValues.js';
import {getDatabase, ref, remove} from "firebase/database";

const dBase = getDatabase();

export default defineEventHandler(async (event) => {

    try {

        const form = formidable();

        const {slug} = await new Promise((resolve, reject) => {
            form.parse(event.req, (err, fields, files) => {
                resolve(firstValues(form, fields))
            });
        })

        if (slug) {
            await remove(ref(dBase, 'categories/' + slug));
        }

        return {
            slug
        }

    } catch (e) {
        event.res.statusCode = 401;
        event.res.end(JSON.stringify({
            msg: 'Unauthenticated'
        }));
    }

})