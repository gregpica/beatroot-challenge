import React from 'react'

const TrackIndexTile = props => {
  return (
    <div className="row">
      <span className="small-9 columns small-centered">
        <div className="tile row">
          <span className="small-12 columns">
            <span className="small-5 columns">{props.title}</span>
            <span className="small-5 columns">{props.artist}</span>
            <span className="small-2 columns">
              <a href="#" onClick={props.downloadXml}>
                <i className="fas fa-file-download"></i>
              </a>
            </span>
          </span>
        </div>
      </span>
    </div>
  )
}

export default TrackIndexTile
