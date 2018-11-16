require 'rails_helper'

RSpec.describe TrackXmlConverter do
  describe "#construct" do
    context "it returns an xml string using Track instance properties" do
      it "includes isrc" do
        track = Track.new
        track.isrc = "GBG3H1000203"
        converted = TrackXmlConverter.new(track).convert
        xml = <<~EOXML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ISRC>GBG3H1000203</ISRC>
        </Track>
        EOXML
        expect(converted).to eq(xml)
      end

      it "includes title info" do
        track = Track.new
        track.title = "Sweet Lorraine"
        track.subtitle = "live at the O2"
        converted = TrackXmlConverter.new(track).convert
        xml = <<~EOXML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ReferenceTitle>
            <TitleText>Sweet Lorraine</TitleText>
            <SubTitle>live at the O2</SubTitle>
          </ReferenceTitle>
        </Track>
        EOXML
        expect(converted).to eq(xml)
      end

      it "includes duration" do
        track = Track.new
        track.duration = "PT00H03M22S"
        converted = TrackXmlConverter.new(track).convert
        xml = <<~EOXML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <Duration>PT00H03M22S</Duration>
        </Track>
        EOXML
        expect(converted).to eq(xml)
      end

      it "includes artist name" do
        track = Track.new
        track.artist_name = "Tony Crombie feat. Robert Robertson"
        converted = TrackXmlConverter.new(track).convert
        xml = <<~EOXML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ArtistName>Tony Crombie feat. Robert Robertson</ArtistName>
        </Track>
        EOXML
        expect(converted).to eq(xml)
      end

      it "includes direct contributors" do
        track = Track.new
        track.direct_contributors = [
          {
            name: "Tony Crombie",
            roles: ["Artist"]
          },
          {
            name: "Robert Robertson",
            roles: ["Artist"]
          }
        ]
        converted = TrackXmlConverter.new(track).convert
        xml = <<~EOXML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <Contributor>
            <Name>Tony Crombie</Name>
            <Role>Artist</Role>
          </Contributor>
          <Contributor>
            <Name>Robert Robertson</Name>
            <Role>Artist</Role>
          </Contributor>
        </Track>
        EOXML
        expect(converted).to eq(xml)
      end

      it "includes indirect contributors" do
        track = Track.new
        track.indirect_contributors = [
          {
            name: "June Blane",
            roles: ["Composer"]
          },
          {
            name: "Marty Ford",
            roles: ["Lyricist"]
          },
        ]
        converted = TrackXmlConverter.new(track).convert
        xml = <<~EOXML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <IndirectContributor>
            <Name>June Blane</Name>
            <Role>Composer</Role>
          </IndirectContributor>
          <IndirectContributor>
            <Name>Marty Ford</Name>
            <Role>Lyricist</Role>
          </IndirectContributor>
        </Track>
        EOXML
        expect(converted).to eq(xml)
      end

      it "includes record label name" do
        track = Track.new
        track.record_label_name = "Harrison James Music"
        converted = TrackXmlConverter.new(track).convert
        xml = <<~EOXML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <RecordLabelName>Harrison James Music</RecordLabelName>
        </Track>
        EOXML
        expect(converted).to eq(xml)
      end

      it "includes p line" do
        track = Track.new
        track.p_line = {
          year: "2010",
          text: "2010 Harrison James Music"
        }
        converted = TrackXmlConverter.new(track).convert
        xml = <<~EOXML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <PLine>
            <Year>2010</Year>
            <PLineText>2010 Harrison James Music</PLineText>
          </PLine>
        </Track>
        EOXML
        expect(converted).to eq(xml)
      end

      it "includes genres" do
        track = Track.new
        track.genres = ["Dance", "Tech House"]
        converted = TrackXmlConverter.new(track).convert
        xml = <<~EOXML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <Genre>Dance</Genre>
          <Genre>Tech House</Genre>
        </Track>
        EOXML
        expect(converted).to eq(xml)
      end

      it "includes parental warning type" do
        track = Track.new
        track.parental_warning_type = "Explicit"
        converted = TrackXmlConverter.new(track).convert
        xml = <<~EOXML
        <?xml version="1.0" encoding="UTF-8"?>
        <Track>
          <ParentalWarningType>Explicit</ParentalWarningType>
        </Track>
        EOXML
        expect(converted).to eq(xml)
      end 
    end
  end
end
