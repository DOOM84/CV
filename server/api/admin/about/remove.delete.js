import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import {getDatabase, ref, remove} from "firebase/database";

const dBase = getDatabase();


export default defineEventHandler(async (event) => {

    try {

        const form = formidable();

        const {id} = await new Promise((resolve, reject) => {
            form.parse(event.req, (err, fields, files) => {
                resolve(firstValues(form, fields))
            });
        })

        if (id) {
            await remove(ref(dBase, 'trainings/' + id));
        }

            return {id};

    } catch (e) {
        event.res.statusCode = 401;
        event.res.end(JSON.stringify({
            msg: 'Unauthenticated'
        }));
    }

})