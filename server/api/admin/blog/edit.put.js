import fs from "fs";
import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import {getDatabase, ref, update, set, get, query, remove} from "firebase/database";

import * as yup from 'yup';
import setFilePath from "~/helpers/upload/setFilePath";
import prepareFileInfo from "~/helpers/upload/prepareFileInfo";
import uploadFile from "~/helpers/upload/uploadFile";

const schema = yup.object({

    updated: yup.object({

        ru_title: yup.string('Название (рус) должно быть строкой')
            .trim('Введите название (рус)').required('Введите название (рус)'),
        ua_title: yup.string('Название (укр) должно быть строкой')
            .trim('Введите название (укр)').required('Введите название (укр)'),
        en_title: yup.string('Название (англ) должно быть строкой')
            .trim('Введите название (англ)').required('Введите название (англ)'),
        ru_subtitle: yup.string('Описание (рус) должно быть строкой')
            .trim('Введите описание (рус)').required('Введите описание (рус)'),
        ua_subtitle: yup.string('Описание (укр) должно быть строкой')
            .trim('Введите описание (укр)').required('Введите описание (укр)'),
        en_subtitle: yup.string('Описание (англ) должно быть строкой')
            .trim('Введите описание (англ)').required('Введите описание (англ)'),
        body: yup.string('Текст должен быть строкой')
            .trim('Введите текст').required('Введите текст'),
        author: yup.string('Автор должен быть строкой')
            .trim('Введите автора').required('Введите автора'),
        source: yup.string('Источник должен быть строкой')
            .trim('Источник должен быть строкой'),
    })
})

const dBase = getDatabase();

export default defineEventHandler(async (event) => {

    const form = formidable({
        encoding: 'utf-8',
        keepExtensions: true,
        maxFileSize: 10 * 1024 * 1024,
    });

    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];

    const {files, fields, err} = await new Promise((resolve, reject) => {
        form.parse(event.req, (err, fields, files) => {
            resolve({files: firstValues(form, files), fields: firstValues(form, fields), err})
        });
    })

    const updated = JSON.parse(fields.data);

    if (err || (files.file && !allowedTypes.includes(files.file.mimetype)) /*|| files.avatar.size > maxFileSize*/) {
        event.res.statusCode = 422;
        event.res.end(JSON.stringify({msg: 'Size limit exceeded or file type is incorrect'}));
    } else {
        try {
            await schema.validate({
                updated
            });

            const postCats = {}
            const postTags = {}
            let tagsToReturn;

            const tagsSnap = await get(query(ref(dBase, 'tags')));

            const tags = Object.entries(tagsSnap.val()).map(([key, value]) => value.slug);

            const catsSnap = await get(query(ref(dBase, 'categories')));

            const categories = Object.entries(catsSnap.val()).map(([key, value]) => value.slug);


            if (updated.tags) {

                for (let i = 0; i < updated.tags.length; i++) {
                    await update(ref(dBase, 'tags/' + updated.tags[i].slug), updated.tags[i]);
                }

                tagsToReturn = updated.tags.map(tag => tag.name);

                updated.tags = updated.tags.map(tag => tag.slug);

                for (let i = 0; i < tags.length; i++) {
                    await remove(ref(dBase, 'tagPosts/' + tags[i] + '/' + updated.slug));
                }

                for (let i = 0; i < updated.tags.length; i++) {
                    postTags[updated.tags[i]] = true;
                    await update(ref(dBase, 'tagPosts/' + updated.tags[i]), {[updated.slug]: true});
                }

                await set(ref(dBase, 'postTags/' + updated.slug), postTags);

            } else {

                for (let i = 0; i < tags.length; i++) {
                    await remove(ref(dBase, 'tagPosts/' + tags[i] + '/' + updated.slug));
                }

                await remove(ref(dBase, 'postTags/' + updated.slug));
            }


            if (updated.categories) {

                for (let i = 0; i < categories.length; i++) {
                    await remove(ref(dBase, 'categoryPosts/' + categories[i] + '/' + updated.slug));
                }

                for (let i = 0; i < updated.categories.length; i++) {
                    postCats[updated.categories[i]] = true;
                    await update(ref(dBase, 'categoryPosts/' + updated.categories[i]), {[updated.slug]: true});
                }

                await set(ref(dBase, 'postCategories/' + updated.slug), postCats);

            } else {

                for (let i = 0; i < categories.length; i++) {
                    await remove(ref(dBase, 'categoryPosts/' + categories[i] + '/' + updated.slug));
                }

                await remove(ref(dBase, 'postCategories/' + updated.slug));
            }

            if (files.file) {

                if (fs.existsSync(setFilePath('/public' + updated.images.original))) {
                    fs.unlinkSync(setFilePath('/public' + updated.images.original));
                }

                if (fs.existsSync(setFilePath('/public' + updated.images.thumbnail))) {
                    fs.unlinkSync(setFilePath('/public' + updated.images.thumbnail));
                }

                if (fs.existsSync(setFilePath('/public' + updated.images.thumbMin))) {
                    fs.unlinkSync(setFilePath('/public' + updated.images.thumbMin));
                }

                const picPath = prepareFileInfo(files.file.newFilename, '/public/img/blog/original/');

                const {mainImage, thumbnail, thumbMin} =  await uploadFile(files.file, '/public/',  {
                    mainImage: true,
                    mainImagePath: picPath,
                    mainImageWidth: 770,
                    mainImageHeight: 415,
                    thumbnail: true,
                    thumbnailPath: prepareFileInfo(files.file,
                        '/public/img/blog/thumbnail/',
                        picPath.substring(picPath.lastIndexOf('/')+1)),
                    thumbnailWidth: 350,
                    thumbnailHeight: 233,
                    thumbMin: true,
                    thumbMinPath: prepareFileInfo(files.file,
                        '/public/img/blog/thumbnail/min/',
                        picPath.substring(picPath.lastIndexOf('/')+1)),
                    thumbMinWidth: 30,
                    thumbMinHeight: 16,
                });

                updated.images.original = mainImage.substring(mainImage.indexOf('/img'));
                updated.images.thumbnail = thumbnail.substring(thumbnail.indexOf('/img'));
                updated.images.thumbMin = thumbMin.substring(thumbMin.indexOf('/img'));

            }

            await update(ref(dBase, 'posts/' + updated.slug), updated)

            if (tagsToReturn) {
                updated.tags = tagsToReturn;
            }

            return updated;

        } catch (e) {

            if (e.path) {
                event.res.statusCode = 422;
                event.res.end(JSON.stringify({
                    msg: e.errors[0]
                }));
            } else {

                event.res.setHeader('Content-Type', 'application/json');
                event.res.statusCode = 401;
                event.res.end(JSON.stringify({msg: 'Ошибка! Вы не авторизованы!'}));

            }
        }
    }

})
