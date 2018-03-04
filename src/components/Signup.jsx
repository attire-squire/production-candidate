import React from 'react';
import {Input} from 'semantic-ui-react';

class Signup extends React.Component {
    render(){
        return (
            <div className="Signup">
            <section className="header_content">
                <h1>Enter your zip code to see if we serve your area!</h1>
            </section>
                <main className="zip_container">
                    <Input placeholder="Zip Code" size="massive" fluid={false}/>
                </main>
            </div>
        )
    }
}

export default Signup;