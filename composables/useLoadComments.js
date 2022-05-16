import { useState } from '#app';

export const useLoadComments = () => {
    return useState('loadComments ', () => false)
}