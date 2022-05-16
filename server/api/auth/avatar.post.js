import fs from "fs";
import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import admin from 'firebase-admin';
import {getDatabase, set, ref} from "firebase/database";

import {
    useCookie
} from 'h3'
import setFilePath from "~/helpers/upload/setFilePath";
import prepareFileInfo from "~/helpers/upload/prepareFileInfo";
import uploadFile from "~/helpers/upload/uploadFile";

const dBase = getDatabase();

export default defineEventHandler(async (event) => {

    const form = formidable({
        encoding: 'utf-8',
        keepExtensions: true,
        // 2 mb for news image and attachments. override otherwise
        maxFileSize: 2 * 1024 * 1024,
    });

    const allowedTypes = ['image/jpeg', 'image/jpg', 'image/png'];
    //const maxFileSize = 2000000;

    const {files, fields, err} = await new Promise((resolve, reject) => {
        form.parse(event.req, (err, fields, files) => {

            resolve({files: firstValues(form, files), fields: firstValues(form, fields), err})
        });
    })

    if (err || !allowedTypes.includes(files.avatar.mimetype) /*|| files.avatar.size > maxFileSize*/) {
        event.res.statusCode = 422;
        event.res.end(JSON.stringify({msg: 'Неверный тип или размер файла превышен'}));
    } else {

        const token = useCookie(event.req, 'token');

        try {

            const {uid} = await admin.auth().verifyIdToken(token);

            const {photoURL} = await admin.auth().getUser(uid);

            const oldAvaPath = photoURL.substring(photoURL.indexOf('/img'));

            if (oldAvaPath !== '/img/avatars/no_avatar.png') {

                if (fs.existsSync(setFilePath('/public' + oldAvaPath))) {
                    fs.unlinkSync(setFilePath('/public' + oldAvaPath));
                }
            }

            const picPath = prepareFileInfo(files.avatar.newFilename, '/public/img/avatars/');

            const {mainImage} =  await uploadFile(files.avatar, '/public/',  {
                mainImage: true,
                mainImagePath: picPath,
                mainImageWidth: 80,
                mainImageHeight: 80
            });

            const newPhotoURL = event.req.headers.origin + mainImage.substring(mainImage.indexOf('/img'));

            await admin.auth().updateUser(uid, {
                photoURL: newPhotoURL,
            })

            await set(ref(dBase, 'avatars/' + uid),
                {path: mainImage.substring(mainImage.indexOf('/img'))});

            return {msg: 'File uploaded and moved!', path: newPhotoURL }

        }catch (e) {
            event.res.setHeader('Content-Type', 'application/json');
            event.res.statusCode = 401;
            event.res.end(JSON.stringify({msg: 'Ошибка! Вы не авторизованы!'}));
        }
    }
})