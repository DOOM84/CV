import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import {getDatabase, ref, remove} from "firebase/database";
import fs from "fs";
import setFilePath from "~/helpers/upload/setFilePath";
import asyncTimeout from "~/helpers/asyncTimeout";

const dBase = getDatabase();

export default defineEventHandler(async (event) => {

    try {

        const form = formidable();

        const {data} = await new Promise((resolve, reject) => {
            form.parse(event.req, (err, fields, files) => {
                resolve(firstValues(form, fields))
            });
        })

        const delData = JSON.parse(data);

        if (delData.id) {
            await remove(ref(dBase, 'projects/' + delData.id));
        }

        if (fs.existsSync(setFilePath('/public' + delData.images.original))) {
            fs.unlinkSync(setFilePath('/public' + delData.images.original));
        }

        if (fs.existsSync(setFilePath('/public' + delData.images.thumbnail))) {
            fs.unlinkSync(setFilePath('/public' + delData.images.thumbnail));
        }

        if (fs.existsSync(setFilePath('/public' + delData.images.thumbMin))) {
            fs.unlinkSync(setFilePath('/public' + delData.images.thumbMin));
        }


        await asyncTimeout(() => {}, 2000);

        return  {
            id: delData.id
        };

    } catch (e) {

        console.log(e);

        event.res.statusCode = 401;
        event.res.end(JSON.stringify({
            msg: 'Unauthenticated'
        }));
    }

})
