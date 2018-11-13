class BeatRootService
  BASE_URL = "https://sync-api.beatroot.com"

  def initialze(params)
    @account = params[:account]
    @token = params[:token]
  end

end
