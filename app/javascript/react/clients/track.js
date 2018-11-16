const getTracks = () => fetch('/api/v1/tracks', {
  credentials: 'same-origin',
  headers: {
    'Content-Type': 'application/json',
    'X-Requested-With': 'XHMLttpRequest'
  }
})

export default {
  getTracks
}
