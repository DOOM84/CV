import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import {get, getDatabase, query, ref, remove} from "firebase/database";
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

        if (delData.slug) {
            await remove(ref(dBase, 'comments/' + delData.slug));
            await remove(ref(dBase, 'likes/' + delData.slug));
            await remove(ref(dBase, 'posts/' + delData.slug));
        }

        const catsSnap = await get(query(ref(dBase, 'categories')));
        const tagsSnap = await get(query(ref(dBase, 'tags')));

        const categories = Object.entries(catsSnap.val()).map(([key, value]) => value.slug);
        const tags = Object.entries(tagsSnap.val()).map(([key, value]) => value.slug);

        for (let i = 0; i < categories.length; i++) {
            await remove(ref(dBase, 'categoryPosts/' + categories[i] + '/' + delData.slug));
        }

        for (let i = 0; i < tags.length; i++) {
            await remove(ref(dBase, 'tagPosts/' + tags[i] + '/' + delData.slug));
        }

        await remove(ref(dBase, 'postCategories/' + delData.slug));

        await remove(ref(dBase, 'postTags/' + delData.slug));

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

        return {
            slug: delData.slug
        };

    } catch (e) {

        event.res.statusCode = 401;
        event.res.end(JSON.stringify({
            msg: 'Unauthenticated'
        }));
    }

})

