require "json"

class GoogleAnalyticsSupport
  SCOPE_NAMES = %w(visitor-level session-level page-level)

  class CustomVar
    def initialize push
      _ignore, @index, @name, @value, @scope = *push
    end

    attr_reader :index, :name, :value, :scope

    def scope_name
      SCOPE_NAMES[scope - 1]
    end
  end

  class Event
    def initialize push
      _ignore, @category, @action, @label, @value, @non_interaction = *push
    end

    attr_reader :category, :action, :label, :value, :non_interaction
  end

  class EventCategory

    def self.of(category)
      @event_categories ||= {}
      @event_categories[category] ||= new(category)

      @event_categories[category]
    end

    def self.all
      @event_categories || []
    end

    def initialize category
      @category = category
      @events = []
    end

    def <<(event)
      @events << event
    end

    def labels
      @events.map(&:label)
    end
  end


  def account
    @account ||= pushes_for("_setAccount").first.last
  end

  def domain
    @domain ||= pushes_for("_setDomainName").first.last
  end

  def custom_variables
    @custom_variables ||= Hash[pushes_for("_setCustomVar").map { |push| [push[2], CustomVar.new(push)] }]
  end

  def events
    unless @events
      pushes_for("_trackEvent").each do |push|
        EventCategory.of(push[1]) << Event.new(push)
      end
      @events = EventCategory.all
    end
    @events
  end

  private
  def pushes
    @pushes ||= extract_pushes()
  end

  def pushes_for method
    pushes.select { |push| push.first == method }
  end

  def extract_pushes
    ga_pushes = []
    all('#debug-google-analytics li').each do |li|
      ga_pushes << JSON.parse(li.text)
    end
    ga_pushes
  end
end

