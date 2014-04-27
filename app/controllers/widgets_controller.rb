class WidgetsController < ApplicationController
  before_action :set_widget, only: [:show, :edit, :update, :destroy]

  def index
    @widgets = Widget.all
  end

  def show
  end

  def new
    @widget = Widget.new
  end

  def edit
  end

  def create
    WidgetCreator.make(self, widget_params)
  end

  def update
    WidgetUpdater.update(self, @widget, widget_params)
  end

  def destroy
    @widget.destroy
    redirect_to widgets_url
  end

  def make_succeeded(widget)
    redirect_to widget
  end

  def make_failed(widget)
    @widget = widget
    render :new
  end

  def update_succeeded(widget)
    redirect_to widget
  end

  def update_failed(widget)
    @widget = widget
    render :edit
  end

  private
    def set_widget
      @widget = Widget.find(params[:id])
    end

    def widget_params
      params.require(:widget).permit(:name)
    end
end
