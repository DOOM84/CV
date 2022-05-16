import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import {getDatabase, ref, push, update} from "firebase/database";
import * as yup from 'yup';
import prepareFileInfo from "~/helpers/upload/prepareFileInfo";
import uploadFile from "~/helpers/upload/uploadFile";

const schema = yup.object({

    created: yup.object({

        ru_name: yup.string('Название (рус) должно быть строкой')
            .trim('Введите название (рус)').required('Введите название (рус)'),
        ua_name: yup.string('Название (укр) должно быть строкой')
            .trim('Введите название (укр)').required('Введите название (укр)'),
        en_name: yup.string('Название (англ) должно быть строкой')
            .trim('Введите название (англ)').required('Введите название (англ)'),
        ru_details: yup.string('Описание (рус) должно быть строкой')
            .trim('Введите описание (рус)').required('Введите описание (рус)'),
        ua_details: yup.string('Описание (укр) должно быть строкой')
            .trim('Введите описание (укр)').required('Введите описание (укр)'),
        en_details: yup.string('Описание (англ) должно быть строкой')
            .trim('Введите описание (англ)').required('Введите описание (англ)'),
        link: yup.string('Ссылка должны быть строкой')
            .trim('Введите ссылку').required('Введите ссылку'),
    })
})

const dBase = getDatabase();

export default defineEventHandler(async (event) => {

    const form = formidable({
        encoding: 'utf-8',
        keepExtensions: true,
        // 3 mb for news image and attachments. override otherwise
        maxFileSize: 3 * 1024 * 1024,
    });

    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];

    const {files, fields, err} = await new Promise((resolve, reject) => {
        form.parse(event.req, (err, fields, files) => {
            resolve({files: firstValues(form, files), fields: firstValues(form, fields), err})
        });
    })

    const created = JSON.parse(fields.data);

    if (err || !files.file || (files.file && !allowedTypes.includes(files.file.mimetype)) /*|| files.avatar.size > maxFileSize*/) {
        event.res.statusCode = 422;
        event.res.end(JSON.stringify({msg: 'Отсутствует изображение или неверный тип или размер файла превышен'}));
    } else {

        try {

            await schema.validate({
                created
            });

            created.images = {};


                const picPath = prepareFileInfo(files.file.newFilename, '/public/img/projects/original/');

                const {mainImage, thumbnail, thumbMin} =  await uploadFile(files.file, '/public/',  {
                    mainImage: true,
                    mainImagePath: picPath,
                    mainImageWidth: null,
                    mainImageHeight: null,
                    thumbnail: true,
                    thumbnailPath: prepareFileInfo(files.file,
                        '/public/img/projects/thumbnail/',
                        picPath.substring(picPath.lastIndexOf('/')+1)),
                    thumbnailWidth: 400,
                    thumbnailHeight: 275,
                    thumbMin: true,
                    thumbMinPath: prepareFileInfo(files.file,
                        '/public/img/projects/thumbnail/min/',
                        picPath.substring(picPath.lastIndexOf('/')+1)),
                    thumbMinWidth: 30,
                    thumbMinHeight: 20,
                });


                created.images.original = mainImage.substring(mainImage.indexOf('/img'));
                created.images.thumbnail = thumbnail.substring(thumbnail.indexOf('/img'));
                created.images.thumbMin = thumbMin.substring(thumbMin.indexOf('/img'));


            const entry = await push(ref(dBase, 'projects'), created);
            await update(ref(dBase, 'projects/' + entry.key), {id: entry.key});

            return {...created, id: entry.key};

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