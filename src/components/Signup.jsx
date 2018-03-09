import React from 'react';
import {Input, Button} from 'semantic-ui-react';
import axios from 'axios';

class Signup extends React.Component {

    state = {
        zip: window.sessionStorage.getItem('zip'),
        phone: undefined,
        validPhone: true,
        first: '',
        last: ''
    }

    _input = e => {
        this.setState({
            [e.target.name]: e.target.value
        })
    }

    _validatePhone = e => {
        let rx = /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/

        this.setState({
            phone: e,
            validPhone: rx.test(e)
        })
    }

    _submitRequest = () => {
        const {validPhone, ...user} = this.state
        user.phone = user.phone.replace(/[-. )(+]/g, '')

        if (user.first && user.last && (user.phone && this.state.validPhone) && user.zip) {
            axios.post('/api/v1/signup', user).then(response => {
                console.log('response:', response.data)
            })
        } else {
            alert('Please enter valid contact information')
        }
    }

    render() {
        return (
            <main className="Signup">
            <div className="content">
                <h2>Sign up now for attire squire!</h2>
                <span>
                    <Input name="first" onChange={e => this._input(e)} value={this.state.first} placeholder="First Name" className="first"/>
                    <Input name="last" onChange={e => this._input(e)} value={this.state.last} placeholder="Last Name" className="last"/>
                </span>
                <Input placeholder="Phone Number" className="phone" onChange={e => this._validatePhone(e.target.value)} error={!this.state.validPhone} />
                <Button onClick={this._submitRequest} >Sign up for Attire Squire</Button>
            </div>
        </main>
        )
    }
}

export default Signup