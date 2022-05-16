import {getAuth, signInWithEmailAndPassword} from "firebase/auth";
import formidable from "formidable";
import { firstValues } from 'formidable/src/helpers/firstValues.js';
import * as yup from 'yup';

const schema = yup.object({
    credentials: yup.object({
        email: yup.string('error_email').trim('error_email').email('error_email').required('error_email'),
        password: yup.string('error_pass_length')
            .trim('error_pass_length')
            .min(6, 'error_pass_length')
            .required('error_pass_length'),
    }),
});

export default defineEventHandler(async (event) => {

    const form = formidable();

    const credentials = await new Promise((resolve, reject) => {

        form.parse(event.req, (err, fields, files) => {
            const fieldsSingle = firstValues(form, fields);
            resolve(fieldsSingle)
        });
    })

    const auth = getAuth();

    try {

        await schema.validate({
            credentials,
        });

        const userCredential = await signInWithEmailAndPassword(auth, credentials.email, credentials.password)

        return  {
            login: userCredential.user.displayName,
            // email: userCredential.user.email,
            avatar: userCredential.user.photoURL,
            token: userCredential.user.accessToken
        }

    } catch (e) {
        if (e.path) {
            event.res.statusCode = 422;
            event.res.end(JSON.stringify({
                msg: e.errors[0]
            }));
        } else {
            event.res.statusCode = 403;
            event.res.end(e.code);
        }

    }

})