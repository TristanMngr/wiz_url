class DateTimeConverter
  def initialize(date_time:)
    @date_time = date_time
  end

  def to_string(format: :long)
    if !@date_time.instance_of?(ActiveSupport::TimeWithZone)
      raise "date_time should be an ActiveSupport::TimeWithZone instance"
    end

    case format
    when :long
      @date_time.strftime('%Y-%m-%dT%H:%M')
    when :short
      @date_time.strftime('%H:%M')
    else
      raise "Unknown format"
    end
  end
end
