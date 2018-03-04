module.exports = function(app) {
    app.get('/api/v1/test', (req, res) => {
        app.get('db').query('SELECT * FROM customers').then(response => {
            res.status(200).json({
                success: true,
                data: response,
                error: null
            })
        })
    })
}