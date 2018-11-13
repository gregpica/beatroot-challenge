class BeatRootService
  BASE_URL = "https://sync-api.beatroot.com"

  def initialze(params)
    @account = params[:account]
    @token = params[:token]
  end

  def get_tracks
    api_path = "#{BASE_URL}/accounts/#{@account}/tracks"
    RestClient.get(api_path, :Authorization => "Token token=#{@token}")
  end

  def get_track(id)
    api_path = "#{BASE_URL}/accounts/#{@account}/tracks/#{id}"
    RestClient.get(api_path, :Authorization => "Token token=#{@token}")
  end 
end
