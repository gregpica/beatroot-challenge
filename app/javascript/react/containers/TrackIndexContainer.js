import React from 'react';
import trackClient from '../clients/track';
import TrackIndexTile from '../components/TrackIndexTile';
import FileSaver from 'file-saver';

class TrackIndexContainer extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      tracks: []
    }
    
    this.downloadXml = this.downloadXml.bind(this);
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

  downloadXml(id) {
    trackClient.getTrackXml(id)
      .then(response => response.text())
      .then(xmlString => {
        return new Blob([xmlString], {type : 'application/xml'})
      })
      .then(blob => FileSaver.saveAs(blob, `track_${id}.xml`))
      .catch(error => console.error(`Error in fetch: ${error.message}`));
  }

  getTrackIndexTiles() {
    return this.state.tracks.map(track => {
      return <TrackIndexTile
        key={track.id}
        title={track.full_title}
        artist={track.artist.name}
        downloadXml={() => this.downloadXml(track.id)}
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
