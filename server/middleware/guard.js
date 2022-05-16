import database from '~/helpers/dbConn';
database();
import admin from 'firebase-admin';
import * as serviceAccount from "../../helpers/portfolio-86b43-firebase-adminsdk-7ohzi-e4732c6d38.json";

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://portfolio-86b43-default-rtdb.europe-west1.firebasedatabase.app"
});


export default defineEventHandler(async (event) => {

    const toName = event.req.originalUrl.split("/");

    if (toName[2] === 'admin' && (toName[toName.length - 1] === 'add' || toName[toName.length - 1] === 'comdel'
        || toName[toName.length - 1] === 'edit' || toName[toName.length - 1] === 'remove'
        || toName[toName.length - 1] === 'uploader')) {

        try {

            const {access} = await $fetch('/api/check', {params: {token: useCookies(event).token}});

            if (!access) {
                await Promise.reject(Error('No access'));
            }

        } catch (e) {

            event.res.writeHead(403, {
                "Set-Cookie": `token=; HttpOnly; path=/; max-age=0`,
            });

            event.res.end(JSON.stringify({msg: 'no or expired token'}));
        }

    }

})