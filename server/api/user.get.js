import admin from 'firebase-admin';
import {useCookie} from "h3";

export default defineEventHandler(async (event) => {
    try {

        const token = useCookie(event.req, 'token');

        const userInfo = await admin.auth().verifyIdToken(token);
        const user = await admin.auth().getUser(userInfo.uid);

        return {
            login: user.displayName,
            avatar: user.photoURL//!user.photoURL ? null : user.photoURL,
        }
    }catch (e) {
        event.res.writeHead(401, {
            "Set-Cookie": `token=; HttpOnly; path=/; max-age=0`,
        });
        //res.statusCode = 401;
        event.res.end(JSON.stringify({msg: 'no or expired token'}));
    }
})