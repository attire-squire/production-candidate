import React from 'react';
import {Input, Button} from 'semantic-ui-react';
import axios from 'axios';
// import {Link} from 'react-router-dom';

class EnterZip extends React.Component {

    state = {
        zip: ''
    }

    _searchZip = () => {
        let {zip} = this.state
        if (zip && /[0-9]/.test(zip) && zip.length === 5) {
            axios.get(`/api/v1/checkavailability/${zip}`).then(response => {
                window.sessionStorage.setItem('zip', zip)
                this.props.history.push('/signup')
            }).catch(err => {
                alert('The zip code you entered is not available at this time.')
            })
        } else {
            alert('Please enter a valid zip code!')
        }
    }

    render(){
        return (
            <div className="EnterZip">
                <main className="zip_container">
                    <h1>Enter your zip code to see if we serve your area!</h1>
                    <Input value={this.state.zip} onChange={e => this.setState({zip: e.target.value})} placeholder="Zip Code" size="massive" fluid={false}/>
                    <br />
                    <Button onClick={this._searchZip}>Check Zip Code</Button>
                </main>
            </div>
        )
    }
}

export default EnterZip;