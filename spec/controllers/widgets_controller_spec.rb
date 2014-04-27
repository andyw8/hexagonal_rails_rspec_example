require 'spec_helper'

describe WidgetsController do
  describe "GET index" do
    it "assigns all widgets as @widgets" do
      widgets = double('widgets')
      allow(Widget).to receive(:all).and_return(widgets)
      get :index, {}
      expect(assigns(:widgets)).to eq(widgets)
    end
  end

  let(:widget) { double('widget') }

  describe "GET show" do
    it "assigns the requested widget as @widget" do
      allow(Widget).to receive(:find).with("7").and_return(widget)
      get :show, {:id => 7}
      expect(assigns(:widget)).to eq(widget)
    end
  end

  describe "GET new" do
    it "assigns a new widget as @widget" do
      get :new, {}
      expect(assigns(:widget)).to be_a_new(Widget)
    end
  end

  describe "GET edit" do
    it "assigns the requested widget as @widget" do
      allow(Widget).to receive(:find).with("7").and_return(widget)
      get :edit, {:id => 7}
      expect(assigns(:widget)).to eq(widget)
    end
  end

  let(:valid_attributes) { { "name" => "MyString" } }

  describe "POST create" do
    it "attempts to creates a new widget" do
      # spec fails with 'Missing template widgets/create' unless we stub :render
      allow(controller).to receive(:render)
      expect(WidgetCreator).to receive(:make).with(controller, valid_attributes)
      post :create, {:widget => valid_attributes}
    end

    context "on success" do
      it "redirects to the created widget" do
        expect(controller).to receive(:redirect_to).with(widget)
        controller.make_succeeded(widget)
      end
    end

    context "on failure" do
      it "assigns a newly created but unsaved widget as @widget" do
        # spec fails with '@_response is nil' unless we stub :render
        allow(controller).to receive(:render)
        controller.make_failed(widget)
        expect(assigns(:widget)).to eq(widget)
      end

      it "re-renders the 'new' template" do
        expect(controller).to receive(:render).with(:new)
        controller.make_failed(widget)
      end
    end
  end

  describe "PUT update" do
    it "attempts to update the widget" do
      allow(Widget).to receive(:find).with("7").and_return(widget)
      # spec fails with 'Missing template widgets/update' unless we stub :render
      allow(controller).to receive(:render)
      expect(WidgetUpdater).to receive(:update).with(controller, widget, { "name" => "MyString" })
      put :update, {:id => 7, :widget => { "name" => "MyString" }}
    end

    context "on success" do
      it "redirects to the widget" do
        expect(controller).to receive(:redirect_to).with(widget)
        controller.update_succeeded(widget)
      end
    end

    context "on failure" do
      it "assigns the requested widget as @widget" do
        # spec fails with '@_response is nil' unless we stub :redirect_to
        allow(controller).to receive(:render)
        controller.update_failed(widget)
        expect(assigns(:widget)).to eq(widget)
      end

      it "re-renders the 'edit' template" do
        expect(controller).to receive(:render).with(:edit)
        controller.update_failed(widget)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested widget" do
      expect(Widget).to receive(:find).with("7").and_return(widget)
      expect(widget).to receive(:destroy)
      delete :destroy, {:id => 7}
    end

    it "redirects to the widgets list" do
      # spec fails with 'Missing template widgets/destroy' unless we stub :render
      allow(controller).to receive(:render)
      allow(Widget).to receive(:find).with("7").and_return(widget)
      allow(widget).to receive(:destroy)
      expect(controller).to receive(:redirect_to).with(widgets_url)
      delete :destroy, {:id => 7}
    end
  end
end
