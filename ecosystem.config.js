module.exports = {
    apps: [
        {
            name: 'portf',
            exec_mode: 'cluster',
            instances: 'max',
            script: './.output/server/index.mjs'
        }
    ]
}