class GraphLinkPresenter
  FR_TIME_ZONE_OFFSET = 2
  GRAPH_RANGE_IN_MINUTES = 60

  attr_accessor :link

  def initialize(link:, end_time:)
    @link = link
    @end_time = get_end_time_for(end_time)
  end

  def get_end_time_for(end_time)
    end_time ? Time.zone.parse(end_time) : Time.zone.now
  end

  def end_time_to_string
    @_end_time_to_string ||=
      ::DateTimeConverter.new(date_time: @end_time).to_string
  end

  def max_end_time_to_string
    @_max_end_time_to_string ||=
      ::DateTimeConverter.new(date_time: Time.zone.now + 1.minute).to_string
  end

  def properties
    { xtitle: 'minutes', ytitle: "clicks", label: 'clicks' }
  end

  def build_full_range
    @_build_full_range ||=
      init_full_range.merge(link_clicks_by_minutes_for_range).to_a.reverse.to_h
  end

  private

  def link_clicks_for_range
    @link.link_clicks.where(created_at: @end_time - GRAPH_RANGE_IN_MINUTES.minutes..@end_time)
  end

  def link_clicks_by_minutes_for_range
    @link_clicks_by_minutes_for_range ||= link_clicks_for_range
      .group("to_char(created_at AT TIME ZONE 'UTC+#{FR_TIME_ZONE_OFFSET}', 'HH24:MI')").count
  end

  def init_full_range
    @time_range_to_string ||= time_range_to_string(start_time: @end_time - GRAPH_RANGE_IN_MINUTES.minute, end_time: @end_time)

    @_init_full_range ||= @time_range_to_string.each_with_object({}) do |minute, hash|
      hash[minute] = 0
    end
  end

  def time_range_to_string(start_time:, end_time:)
    if !start_time.instance_of?(ActiveSupport::TimeWithZone) && end_time.instance_of?(ActiveSupport::TimeWithZone)
      raise "start_time and end_time should be an ActiveSupport::TimeWithZone instance"
    end

    (start_time.to_i..end_time.to_i).step(1.minute).map do |time|
      ::DateTimeConverter.new(date_time: Time.zone.at(time)).to_string(format: :short)
    end
  end
end
