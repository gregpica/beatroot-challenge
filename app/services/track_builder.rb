class TrackBuilder
  def self.build
    builder = new
    yield(builder)
    builder.track
  end

  def initialize
    @track = Track.new
  end

  def set_isrc(isrc)
    @track.isrc = isrc
  end

  def set_title(title)
    @track.title = title
  end

  def set_subtitle(subtitle)
    @track.subtitle = subtitle
  end

  def set_duration(duration)
    @track.duration = duration
  end

  def set_artist_name(artist_name)
    @track.artist_name = artist_name
  end

  def set_direct_contributors(direct_contributors)
    @track.direct_contributors = direct_contributors
  end

  def set_indirect_contributors(indirect_contributors)
    @track.indirect_contributors = indirect_contributors
  end

  def set_record_label_names(record_label_names)
    @track.record_label_names = record_label_names
  end

  def set_p_line(p_line)
    @track.p_line = p_line
  end

  def set_genres(genres)
    @track.genres = genres
  end

  def set_parental_warning_type(parental_warning_type)
    @track.parental_warning_type = parental_warning_type
  end

  def track
    @track
  end
end 
