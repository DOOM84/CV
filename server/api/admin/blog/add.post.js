import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import slugify from "slugify";
import {getDatabase, ref, update, set} from "firebase/database";

import * as yup from 'yup';
import prepareFileInfo from "~/helpers/upload/prepareFileInfo";
import uploadFile from "~/helpers/upload/uploadFile";

const schema = yup.object({

    added: yup.object({

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

    const added = JSON.parse(fields.data);

    if (err || !files.file || (files.file && !allowedTypes.includes(files.file.mimetype)) /*|| files.avatar.size > maxFileSize*/) {
        event.res.statusCode = 422;
        event.res.end(JSON.stringify({msg: 'Отсутствует изображение или неверный тип или размер файла превышен'}));
    } else {

        try {

            await schema.validate({
                added
            });

            added.slug = slugify(added.ru_title, {strict: true}).toLowerCase();
            added.createdAt = Date.now();
            added.images = {};
            const postCats = {}
            const postTags = {}

            if (added.tags) {
                for (let i = 0; i < added.tags.length; i++) {
                    await update(ref(dBase, 'tags/' + added.tags[i].slug), added.tags[i]);
                }

                for (let i = 0; i < added.tags.length; i++) {
                    postTags[added.tags[i].slug] = true;
                    await update(ref(dBase, 'tagPosts/' + added.tags[i].slug), {[added.slug]: true});
                }

                await set(ref(dBase, 'postTags/' + added.slug), postTags);
            }

            if (added.categories) {

                for (let i = 0; i < added.categories.length; i++) {
                    postCats[added.categories[i]] = true;
                    await update(ref(dBase, 'categoryPosts/' + added.categories[i]), {[added.slug]: true});
                }

                await set(ref(dBase, 'postCategories/' + added.slug), postCats);
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

            added.images.original = mainImage.substring(mainImage.indexOf('/img'));
            added.images.thumbnail = thumbnail.substring(thumbnail.indexOf('/img'));
            added.images.thumbMin = thumbMin.substring(thumbMin.indexOf('/img'));

            const tagsToReturn = added.tags.map(tag => tag.name)

            if (added.tags) {
                added.tags = added.tags.map(tag => tag.slug);
            }

            await set(ref(dBase, 'posts/' + added.slug), added);


            if (added.tags) {
                added.tags = tagsToReturn;
            }

            return added;

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

}})