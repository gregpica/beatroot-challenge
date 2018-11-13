require 'rails_helper'

describe BeatRootService, :vcr => true do

  describe "#get_all_tracks" do
    it "returns a list of tracks" do
      VCR.use_cassette('beetroot_cassette') do
        client = BeatRootService.new({account: ENV['BEATROOT_ACCOUNT'], token: ENV['BEATROOT_TOKEN']})
        response = JSON.parse(client.get_all_tracks)
        expect(response["tracks"]).to be_an_instance_of(Array)
     end
    end
  end
end
