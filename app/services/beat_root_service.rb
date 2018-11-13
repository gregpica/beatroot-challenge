class BeatRootService
  BASE_URL = "https://sync-api.beatroot.com"

  def initialze(params)
    @account = params[:account]
    @token = params[:token]
  end

  def get_all_tracks
    api_path = "#{BASE_URL}/accounts/#{@account}/tracks"
    rest_client_get(api_path)
  end

  def get_track(id)
    api_path = "#{BASE_URL}/accounts/#{@account}/tracks/#{id}"
    rest_client_get(api_path)
  end

  private

  def rest_client_get(api_path)
    RestClient.get(api_path, :Authorization => "Token token=#{@token}")
  end
end
