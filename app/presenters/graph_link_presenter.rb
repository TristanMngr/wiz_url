class GraphLinkPresenter
  FRANCE_TIME_ZONE_OFFSET = 2

  def initialize(link:, end_date: Time.now, duration_in_minutes: 60)
    @link = link
    @end_date = end_date
    @duration_in_minutes = duration_in_minutes
  end

  def clicks_by_minutes
    range_for_data.group("to_char(created_at AT TIME ZONE 'UTC+#{FRANCE_TIME_ZONE_OFFSET}', 'HH24:MI')").count
  end

  def build_full_range
    init_full_range.merge(clicks_by_minutes).to_a.reverse.to_h
  end

  def init_full_range
    start_time = (@end_date - @duration_in_minutes.minute).strftime("%H:%M")
    end_time = @end_date.strftime("%H:%M")

    (start_time..end_time).each_with_object({}) do |minute, hash|
      hash[minute] = 0
    end
  end

  def range_for_data
    @link.link_clicks.where(created_at: @end_date - @duration_in_minutes.minutes..@end_date)
  end

  def properties
    return { xtitle: 'minutes', ytitle: "clicks", label: 'clicks', title: @link.url }
  end
end