class Api::V1::TracksController < ApiController
  def index
    client = BeatRootService.new({account: ENV['BEATROOT_ACCOUNT'], token: ENV['BEATROOT_TOKEN']})
    response = JSON.parse(client.get_all_tracks)
    render json: response
  end
end
