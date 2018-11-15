require 'rails_helper'

RSpec.describe TrackReader do
  describe "#construct" do
      json =  {
      "title" => "Sweet Lorraine",
      "subtitle" => "live at the O2",
      "duration" => 202,
      "parental_warning" => "not_explicit",
      "isrc" => "GBG3H1000203",
      "artist" => {
        "name" => "Tony Crombie feat. Robert Robertson",
      },
      "record_labels" => [
        {
          "p_line" => "2010 Harrison James Music",
          "name" => "Harrison James Music",
        }
      ],
      "contributors" => [
        {
          "name" => "Tony Crombie",
          "direct" => true,
          "roles" => [
            "Artist"
          ]
        },
        {
          "name" => "Robert Robertson",
          "direct" => true,
          "roles" => [
            "FeaturedArtist"
          ],
        },
        {
        "name" => "June Blane",
        "direct" => false,
        "roles" => [
            "Mixer"
          ],
        }
      ],
      "tags" => [
        {
          "name" => "Dance",
          "classification" => "genre"
        },
        {
          "name" => "Tech House",
          "classification" => "genre"
        }
      ]
    }
    let(:track) { TrackReader.new(json).construct }

    context "it returns a Track instance with parsed properties" do

      it "sets a parsed isrc" do
        expect(track.isrc).to eq("GBG3H1000203")
      end

      it "sets a parsed title" do
        expect(track.title).to eq("Sweet Lorraine")
      end

      it "sets a parsed subtitle" do
        expect(track.subtitle).to eq("live at the O2")
      end

      it "sets a parsed duration" do
        expect(track.duration).to eq("PT00H03M22S")
      end

      it "sets a parsed artist_name" do
        expect(track.artist_name).to eq("Tony Crombie feat. Robert Robertson")
      end

      it "sets parsed direct_contributors" do
        parsed_direct_contributors = [
          {
            name: "Tony Crombie",
            roles: ["Artist"]
          },
          {
            name: "Robert Robertson",
            roles: ["FeaturedArtist"]
          }
        ]
        expect(track.direct_contributors).to eq(parsed_direct_contributors)
      end

      it "sets parsed indirect_contributors" do
        parsed_indirect_contributors = [
          {
            name: "June Blane",
            roles: ["Mixer"]
          }
        ]
        expect(track.indirect_contributors).to eq(parsed_indirect_contributors)
      end
    end
  end
end
