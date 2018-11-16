import React from 'react';
import trackClient from '../clients/track';
import TrackIndexTile from '../components/TrackIndexTile';

class TrackIndexContainer extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      tracks: []
    }

    this.getTrackIndexTiles = this.getTrackIndexTiles.bind(this);
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

  getTrackIndexTiles() {
    return this.state.tracks.map(track => {
      return <TrackIndexTile
        key={track.id}
        id={track.id}
        title={track.full_title}
        artist={track.artist.name}
      />
    })
  }

  render() {
    return(
      <div>
        <div className="text-center">
          <h1>BeatRoot Track XML Downloader</h1>
        </div>
        <div>{this.getTrackIndexTiles()}</div>
      </div>
    )
  }
}

export default TrackIndexContainer
