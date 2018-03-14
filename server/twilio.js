const config = require('../config.json')[process.env.NODE_ENV],
           account = config.twilio_account,
           token = config.twilio_key,
           squireNumber = config.twilio_number,
           client = require('twilio')(account, token);

module.exports = {
    sendBlast: (recipients) => {
        /**
         * @param [Array] recipients - [ {msg: 'Hello Andrew, We will.....', phone: '8015027423'} ]
         */
        if (!recipients || typeof recipients !== 'object') {
            throw new Error('Invalid Prop Types. Expected array, but received ' + typeof recipients)
        }

        return new Promise((resolve, reject) => {
            let messages = [];

            recipients.forEach(e => {
                messages.push(client.messages.create({
                    to: e.phone,
                    from: squireNumber,
                    body: e.msg
                }))
            })

            Promise.all(messages).then(responses => {
                resolve({
                    success: true,
                    messages: responses
                })
            }).catch(err => {
                reject({
                    success: false,
                    err: err
                })
            })
        })

    }
}