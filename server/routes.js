const axios = require('axios');
const twilio = require('./twilio');


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

function changeTextMsg (rawMsg, params) {
    let rx = /\|{2}[A-z]*\|{2}/g;
    let paramList = rawMsg.match(rx).map(e => e.replace(/\|{2}/g, ''))
    
    let counter = 0;
    return rawMsg.split('||').map(e => {
      if (Object.keys(params).includes(e)) {
        e = params[paramList[counter]]
        counter++
      }
      return e
    }).join('')
  }

  function generateUrl() {
    let chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz';
    let url = []
    for (var i = 0; i < 8; i++) {
        url.push(chars.charAt(~~(Math.random() * chars.length)))
    }
    return 'http://attiresquire.com/schedule/' + url.join('')
  }

module.exports = function(app) {
    const config = app.get('config')
    
    app.get('/api/v1/checkavailability/:zip', (req, res) => {
        app.get('db').check_availability([req.params.zip]).then(response => {
            //check if is currently in database

            if (!response.length) {
                // not in database
                axios.get(`https://www.zipcodeapi.com/rest/${process.env.ZIPCODE_API_KEY}/radius.json/${req.params.zip}/10/mile`).then(resp => {
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

    app.post('/api/v1/sendblast/', (req, res) => {
        app.get('db').get_blast_numbers().then(recipients => {
            
            let texts = recipients.map((e,i,a) => {
                let url = generateUrl()
                return axios.get(`https://api-ssl.bitly.com/v3/shorten?access_token=${process.env.BITLY_KEY}&longUrl=${url}`).then(response => {
                    e.link = response.data.data.url
                    e.msg = changeTextMsg(req.body.msg, e)
                    return e
                }).catch(console.log)
            })

            Promise.all(texts).then(results => {
                let addDB = results.map(e => {
                    return app.get('db').add_custom_links([e.id, e.link])
                })

                return Promise.all(addDB).then(response => {
                    twilio.sendBlast(results).then(response => {
                        res.status(200).send(response)
                    }).catch(console.log)
                })
            })        
        })
    })

    app.get('/api/v1/getSchedule/:id', (req, res) => {
        let url = `http://bit.ly/${req.params.id}`

        app.get('db').get_user_by_url([url]).then(response => {
            res.status(200).json({
                success: true,
                msg: response[0] || null,
                err: null
            })
        })
    })

}