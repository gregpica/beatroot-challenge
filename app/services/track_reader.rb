class TrackReader
  def initialize(track_json)
    @track = track_json
  end

  def construct
    TrackBuilder.build do |builder|
      builder.set_isrc(parsed_isrc)
      builder.set_title(parsed_title)
      builder.set_subtitle(parsed_subtitle)
      builder.set_duration(parsed_duration)
      builder.set_artist_name(parsed_artist_name)
      builder.set_direct_contributors(parsed_direct_contributors)
      builder.set_indirect_contributors(parsed_indirect_contributors)
      builder.set_record_label_name(parsed_record_label_name)
      builder.set_p_line(parsed_p_line)
      builder.set_genres(parsed_genres)
      builder.set_parental_warning_type(parsed_parental_warning_type)
    end
  end

  def parsed_isrc
    @track["isrc"]
  end

  def parsed_title
    @track["title"]
  end

  def parsed_subtitle
    @track["subtitle"]
  end

  def parsed_duration
    Time.at(@track["duration"]).gmtime.strftime("PT%HH%MM%SS") if @track["duration"]
  end

  def parsed_artist_name
    @track["artist"]["name"] if @track["artist"]
  end

  def parsed_direct_contributors
    if @track["contributors"].present?
      direct_contributors = @track["contributors"].select{ |contributor| contributor["direct"] == true}
      create_contributor_hashes(direct_contributors)
    end
  end

  def parsed_indirect_contributors
    if @track["contributors"].present?
      indirect_contributors = @track["contributors"].select{ |contributor| contributor["direct"] == false}
      create_contributor_hashes(indirect_contributors)
    end
  end

  def parsed_record_label_name
    @track["record_labels"].first["name"] if @track["record_labels"].present?
  end

  def parsed_p_line
    create_p_line_hash(@track["record_labels"].first["p_line"]) if @track["record_labels"].present?
  end

  def parsed_genres
    if @track["tags"].present?
      @track["tags"].select{ |tag| tag["classification"] == "genre"}.map{ |tag| tag["name"]}
    end
  end

  def parsed_parental_warning_type
    @track["explicit"] ? "Explicit" : "NotExplicit" if @track["explicit"] != nil 
  end

  private

  def create_contributor_hashes(contributors)
    contributors.map do |contributor|
      {
       name: contributor["name"],
       roles: contributor["roles"]
      }
    end
  end

  def create_p_line_hash(p_line)
    {
     year: p_line.split.first,
     text: p_line
    }
  end
end
