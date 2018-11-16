require 'nokogiri'

class TrackXmlConverter
  def initialize(track)
    @track = track
    @xml = nil
  end

  def convert
    builder = Nokogiri::XML::Builder.new(:encoding => 'UTF-8') do |xml|
      set_xml(xml)
      xml.Track {
        isrc_xml
        title_xml
        duration_xml
        artist_name_xml
        direct_contributors_xml
        indirect_contributors_xml
        record_label_name_xml
        p_line_xml
        genres_xml
        parental_warning_type_xml
      }
    end
    a = builder.to_xml
  end

  private

  def set_xml(xml)
    @xml = xml
  end

  def isrc_xml
    @xml.ISRC @track.isrc if @track.isrc
  end

  def title_xml
     @xml.ReferenceTitle {
        title_text_xml
        subtitle_xml
     } if @track.title
  end

  def title_text_xml
    @xml.TitleText @track.title
  end

  def subtitle_xml
    @xml.SubTitle @track.subtitle
  end

  def duration_xml
    @xml.Duration @track.duration if @track.duration
  end

  def artist_name_xml
    @xml.ArtistName @track.artist_name if @track.artist_name
  end

  def direct_contributors_xml
    if @track.direct_contributors
      @track.direct_contributors.each do |contributor|
        @xml.Contributor {
          contributor_name_xml(contributor)
          contributor_roles_xml(contributor)
        }
      end
    end
  end

  def indirect_contributors_xml
    if @track.indirect_contributors
      @track.indirect_contributors.each do |contributor|
        @xml.IndirectContributor {
          contributor_name_xml(contributor)
          contributor_roles_xml(contributor)
        }
      end
    end
  end

  def contributor_name_xml(contributor)
    @xml.Name contributor[:name] if contributor[:name]
  end

  def contributor_roles_xml(contributor)
    contributor[:roles].each { |role| @xml.Role role } if contributor[:roles].present?
  end

  def record_label_name_xml
    @xml.RecordLabelName @track.record_label_name if @track.record_label_name
  end

  def p_line_xml
    @xml.PLine {
      @xml.Year @track.p_line[:year]
      @xml.PLineText @track.p_line[:text]
    } if @track.p_line
  end

  def genres_xml
    @track.genres.each { |genre| @xml.Genre genre } if @track.genres
  end

  def parental_warning_type_xml
    @xml.ParentalWarningType @track.parental_warning_type if @track.parental_warning_type
  end
end
