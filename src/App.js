import React from 'react';
import './styles/main.css';
import {Switch, Route} from 'react-router-dom';
import {Menu, Button} from 'semantic-ui-react';

import EnterZip from './components/EnterZip';
import Signup from './components/Signup';
import Schedule from './components/Schedule';

class App extends React.Component {
  render() {
    return (
      <div className="App">
        <Menu size="large">
          <Menu.Item>
            <img src="https://fillmurray.com/30/30" alt="Attire Squire"/>
          </Menu.Item>
          <Menu.Item position="right">
            <Button primary>Log in</Button>
          </Menu.Item>
        </Menu>

        <Switch>
          <Route exact path="/" component={EnterZip} />
          <Route path="/signup" component={Signup} />
          <Route path="/schedule/:id" component={Schedule} />
        </Switch>
      </div>
    );
  }
}

export default App;
