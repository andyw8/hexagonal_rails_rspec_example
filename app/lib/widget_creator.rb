class WidgetCreator
  def self.make(listener, params)
    widget = Widget.new(params)
    if widget.save
      listener.make_succeeded(widget)
    else
      listener.make_failed(widget)
    end
  end
end
