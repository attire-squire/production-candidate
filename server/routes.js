const axios = require('axios');

function handleRes (res, data, type) {
    res.status(200).json({
        success: true,
        err: null,
        data: data,
        type: type
    })
}

function handleErr (res, err, type) {
    res.status(400).json({
        success: false,
        err: err,
        type: type
    })
}

module.exports = function(app) {
    const config = app.get('config')
    
    app.get('/api/v1/checkavailability/:zip', (req, res) => {
        app.get('db').check_availability([req.params.zip]).then(response => {
            //check if is currently in database

            if (!response.length) {
                // not in database
                axios.get(`https://www.zipcodeapi.com/rest/${config.zip_api_key}/radius.json/${req.params.zip}/10/mile`).then(resp => {
                    // gather list of nearby zip codes

                    let respArr = resp.data.zip_codes.map(e => e.zip_code).join(',')
                    app.get('db').check_availability_in(respArr).then(fin => {
                        // check if any of the nearby zip codes are in the database

                        if (fin.length) {
                            // if yes, return good

                            handleRes(res, fin, 'nearby')
                        } else {
                            // if no, add to potential database, then return bad response

                            let potentialData = resp.data.zip_codes.filter(e => e.zip_code === req.params.zip)[0]
                            app.get('db').add_potential([potentialData.zip_code, potentialData.city, potentialData.state]).then(ress => {
                                // added to 'potential' database, then response that we don't serve area

                                handleErr(res, null, 'no service')
                            })
                        }
                    })
                }).catch(err => handleErr(res, err.data, 'invalid zip'))

            } else {
                // is in original database call, so return good

                handleRes(res, response, 'direct')
            }
        })
    })

    app.post('/api/v1/signup', (req, res) => {
        const {first, last, phone, zip} = req.body
        app.get('db').signup_customer([first, last, phone, zip]).then(response => {
            let r = response[0]
            console.log(`===== NEW SIGNUP =====\nUser: ${r.id} | ${r.first_name} ${r.last_name} | AT ${new Date()}\n`)

            res.status(200).json({
                success: true,
                err: null,
                user: r
            })
        })
    })
}