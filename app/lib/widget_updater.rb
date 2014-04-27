class WidgetUpdater
  def self.update(listener, widget, params)
    if widget.update(params)
      listener.update_succeeded(widget)
    else
      listener.update_failed(widget)
    end
  end
end
