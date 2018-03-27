import React from 'react';
import axios from 'axios';
import {Form, Button, Card, Image} from 'semantic-ui-react';

class Schedule extends React.Component {

    state = {
        validLink: undefined,
        user: undefined,
        fullName: ''
    }

    componentWillMount() {
        axios.get('/api/v1/getSchedule/' + this.props.match.params.id).then(response => {
            this.setState(() =>{
                if (!response.data.msg) {
                    return { validLink: false }
                }

                const {id, first_name, last_name, phone, city, state_name, street_1, street_2, zip} = response.data.msg
                return {
                    validLink: true,
                    user: response.data.msg,
                    id,
                    fullName: `${first_name} ${last_name}`,
                    phone,
                    state_name,
                    street_1,
                    street_2,
                    zip,
                    city
                }
            })
        })
    }

    _handleInput = e => {
        this.setState({
            [e.target.name]: e.target.value
        })
    }

    _submitForm = () => {
        console.log(this.state)
    }

    render() {
        return (this.state.validLink !== false && this.state.user) ? (
            <div className="Schedule">
                <article className="order_form">
                    <h3>Welcome, {this.state.user.first_name}!</h3>
                    <Form>
                        <Form.Field>
                            <label>Full Name</label>
                            <input placeholder="First Name" name="fullName" value={this.state.fullName} onChange={e => this._handleInput(e)}/>
                        </Form.Field>
                        <Form.Field>
                            <label>Address:</label>
                            <input placeholder="Street" name="street_1" value={this.state.street_1 || ''} onChange={e => this._handleInput(e)}/>
                            <input placeholder="Street 2" name="street_2" value={this.state.street_2 || ''} onChange={e => this._handleInput(e)}/>
                            <input placeholder="City" name="city" value={this.state.city || ''} onChange={e => this._handleInput(e)}/>
                            <input placeholder="State" name="state_name" value={this.state.state_name || ''} onChange={e => this._handleInput(e)}/>
                            <input placeholder="Zip Code" name="zip" value={this.state.zip || ''} onChange={e => this._handleInput(e)}/>
                        </Form.Field>
                        <h3>Select Clothing Items</h3>
                        <Form.Field>
                            <Card fluid={true}>
                                <Card.Content>
                                    <Image floated="right" size="mini" src="https://fillmurray.com/35/35" />
                                    <Card.Header>Suit Jacket</Card.Header>
                                    <Card.Meta>$12.00</Card.Meta>
                                </Card.Content>
                            </Card>
                            <Card fluid={true} color="green">
                                <Card.Content>
                                    <Image floated="right" size="mini" src="https://fillmurray.com/40/40" />
                                    <Card.Header>Slacks</Card.Header>
                                    <Card.Meta>$6.00</Card.Meta>
                                </Card.Content>
                            </Card>
                            <Card fluid={true} color="green">
                                <Card.Content>
                                    <Image floated="right" size="mini" src="https://fillmurray.com/35/35" />
                                    <Card.Header>Dress Shirt</Card.Header>
                                    <Card.Meta>$3.50</Card.Meta>
                                </Card.Content>
                            </Card>
                            <Card fluid={true}>
                                <Card.Content>
                                    <Image floated="right" size="mini" src="https://fillmurray.com/35/35" />
                                    <Card.Header>Tie</Card.Header>
                                    <Card.Meta>$2.00</Card.Meta>
                                </Card.Content>
                            </Card>
                            <Card fluid={true}>
                                <Card.Content>
                                    <Image floated="right" size="mini" src="https://fillmurray.com/35/35" />
                                    <Card.Header>Coat</Card.Header>
                                    <Card.Meta>$14.00</Card.Meta>
                                </Card.Content>
                            </Card>
                        </Form.Field>
                    </Form>
                </article>
            </div>
        ) : (
        <div className="Schedule">
            <h1>Loading...</h1>
        </div>
        )
    }
}

export default Schedule;