const getTracks = () => fetch('/api/v1/tracks', {
  credentials: 'same-origin',
  headers: {
    'Content-Type': 'application/json',
    'X-Requested-With': 'XHMLttpRequest'
  }
})

const getTrackXml = (id) => fetch(`/api/v1/tracks/${id}`, {
  credentials: 'same-origin',
  headers: {
    'Content-Type': 'application/xml',
    'X-Requested-With': 'XHMLttpRequest'
  }
})

export default {
  getTracks,
  getTrackXml
}
