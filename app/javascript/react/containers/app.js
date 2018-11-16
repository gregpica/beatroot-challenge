import React from 'react'
import { Route, Switch, BrowserRouter } from 'react-router-dom';
import TrackIndexContainer from './TrackIndexContainer';

export const App = (props) => {
  return (
    <BrowserRouter>
      <Switch>
        <Route path='/' component={TrackIndexContainer} />
        <Route path='/tracks' component={TrackIndexContainer} />
      </Switch>
    </BrowserRouter>
  )
}

export default App
