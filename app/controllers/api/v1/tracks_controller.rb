class Api::V1::TracksController < ApiController
  def index
    client = BeatRootService.new({account: ENV['BEATROOT_ACCOUNT'], token: ENV['BEATROOT_TOKEN']})
    response = JSON.parse(client.get_all_tracks)
    render json: response
  end

  def show
    client = BeatRootService.new({account: ENV['BEATROOT_ACCOUNT'], token: ENV['BEATROOT_TOKEN']})
    track_id = params[:id]
    response = JSON.parse(client.get_track(track_id))
    render xml: response["track"].to_xml(root: "Track")
  end
end
