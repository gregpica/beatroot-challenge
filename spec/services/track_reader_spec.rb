require 'rails_helper'

RSpec.describe TrackReader do
  describe "#construct" do
    json =  {
      "title" => "Sweet Lorraine",
      "subtitle" => "live at the O2",
      "duration" => 202,
      "explicit" => true,
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
        },
        {
          "name" => "Not genre",
          "classification" => "Not genre"
        }
      ]
    }

    context "it returns a Track instance with parsed properties" do
      track =  TrackReader.new(json).construct

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

      it "sets parsed record_label_name" do
        expect(track.record_label_name).to eq("Harrison James Music")
      end

      it "sets parsed p_line" do
        parsed_p_line = {
          year: "2010",
          text: "2010 Harrison James Music"
        }
        expect(track.p_line).to eq(parsed_p_line)
      end

      it "sets parsed genres" do
        expect(track.genres).to eq(["Dance", "Tech House"])
      end

      it "sets parsed parental_warning_type when explicit" do
        expect(track.parental_warning_type).to eq("Explicit")
      end

      it "sets parsed parental_warning_type when not explicit" do
        not_explicit_json = { "explicit" => false }
        not_explicit_track = TrackReader.new(not_explicit_json).construct
        expect(not_explicit_track.parental_warning_type).to eq("NotExplicit")
      end
    end
  end
end
