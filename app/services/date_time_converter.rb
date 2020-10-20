class DateTimeConverter
  def initialize(date_time:)
    @date_time = date_time
  end

  def to_string
    raise "time param should be a Time instance" unless @date_time.instance_of?(ActiveSupport::TimeWithZone)

    @date_time.strftime('%Y-%m-%dT%H:%M')
  end
end
