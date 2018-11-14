require 'rails_helper'

RSpec.describe Api::V1::TracksController, type: :controller do
  describe "GET#index" do
    it 'should return a list of all the tracks' do
      VCR.use_cassette('beat_root_get_all_tracks_cassette') do
        get :index
        body = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(response.content_type).to eq "application/json"
        expect(body["tracks"]).to be_an_instance_of(Array)
      end
    end
  end

  describe "GET#show" do
    it 'should return track in XML format with correct id' do
      VCR.use_cassette('beat_root_get_track_cassette') do
        get :show, params: {id: 2}
        response_hash = Hash.from_xml(response.body)

        expect(response.status).to eq 200
        expect(response.content_type).to eq "application/xml"
        expect(response_hash["Track"]["id"]).to eq 2
      end
    end
  end
end
