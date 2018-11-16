class Api::V1::TracksController < ApiController
  def initialize
    @client = BeatRootService.new({account: ENV['BEATROOT_ACCOUNT'], token: ENV['BEATROOT_TOKEN']})
  end

  def index
    response = @client.get_all_tracks
    render json: response
  end

  def show
    track_id = params[:id]
    response = @client.get_track(track_id)
    track_json = JSON.parse(response)["track"]
    track = TrackReader.new(track_json).construct
    track_xml = TrackXmlConverter.new(track).convert
    render xml: track_xml
  end
end
