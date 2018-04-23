module GetsTracked
  def self.included(base)
    base.class_eval do
      after_create :track_on_create
      after_update :track_on_update
      after_destroy :track_on_destroy
    end
  end

  def track_on_create
    RabbitmqBus.send_to_bus("metrics.#{self.class.name.downcase}", "#{self.class.name.downcase}.create id=#{id}")
  end

  def track_on_update
    RabbitmqBus.send_to_bus("metrics.#{self.class.name.downcase}", "#{self.class.name.downcase}.update id=#{id}")
  end

  def track_on_destroy
    RabbitmqBus.send_to_bus("metrics.#{self.class.name.downcase}", "#{self.class.name.downcase}.delete id=#{id}")
  end
end
