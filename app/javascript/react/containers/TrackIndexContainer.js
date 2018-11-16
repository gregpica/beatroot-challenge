import React from 'react';
import trackClient from '../clients/track';

class TrackIndexContainer extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      tracks: []
    }
  }

  componentDidMount() {
    trackClient.getTracks()
      .then(response => response.json())
      .then(body => {
        this.setState({
          tracks: body.tracks
        })
      })
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  render() {
    return(
      <div>"Welcome to the TrackIndexContainer"</div>
    )
  }
}

export default TrackIndexContainer
