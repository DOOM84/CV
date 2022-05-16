import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import {getDatabase, ref, set} from "firebase/database";
import slugify from "slugify";
import * as yup from 'yup';

const schema = yup.object({

    created: yup.object({

        ru_name: yup.string('Название (рус) должно быть строкой')
            .trim('Введите название (рус)').required('Введите название (рус)'),
        ua_name: yup.string('Название (укр) должно быть строкой')
            .trim('Введите название (укр)').required('Введите название (укр)'),
        en_name: yup.string('Название (англ) должно быть строкой')
            .trim('Введите название (англ)').required('Введите название (англ)'),
    })
})

const dBase = getDatabase();

export default defineEventHandler(async (event) => {

    try {

        const form = formidable();

        const {data} = await new Promise((resolve, reject) => {
            form.parse(event.req, (err, fields, files) => {
                resolve(firstValues(form, fields))
            });
        })

        const created = JSON.parse(data);

        await schema.validate({
            created
        });

        created.slug = slugify(created.ru_name, {strict: true}).toLowerCase();

        if (created) {
            await set(ref(dBase, 'categories/' + created.slug), created);
        }

        return created;

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

})

