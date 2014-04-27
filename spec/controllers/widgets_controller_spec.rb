require 'spec_helper'

describe WidgetsController do
  let(:valid_attributes) { { "name" => "MyString" } }
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all widgets as @widgets" do
      widget = Widget.create! valid_attributes
      get :index, {}, valid_session
      assigns(:widgets).should eq([widget])
    end
  end

  describe "GET show" do
    it "assigns the requested widget as @widget" do
      widget = Widget.create! valid_attributes
      get :show, {:id => widget.to_param}, valid_session
      assigns(:widget).should eq(widget)
    end
  end

  describe "GET new" do
    it "assigns a new widget as @widget" do
      get :new, {}, valid_session
      assigns(:widget).should be_a_new(Widget)
    end
  end

  describe "GET edit" do
    it "assigns the requested widget as @widget" do
      widget = Widget.create! valid_attributes
      get :edit, {:id => widget.to_param}, valid_session
      assigns(:widget).should eq(widget)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Widget via WidgetCreator" do
        expect(WidgetCreator).to receive(:make).with(controller, valid_attributes)
        post :create, {:widget => valid_attributes}, valid_session
      end
    end

    describe ".make_succeeded" do
      let(:widget) { double('widget') }

      it "assigns a newly created widget as @widget" do
        # spec fails with '@_response is nil' unless we stub :redirect_to
        allow(controller).to receive(:redirect_to)
        controller.make_succeeded(widget)
        assigns(:widget).should eq(widget)
      end

      it "redirects to the created widget" do
        expect(controller).to receive(:redirect_to).with(widget)
        controller.make_succeeded(widget)
      end
    end

    describe ".make_failed" do
      let(:widget) { double('widget') }

      it "assigns a newly created but unsaved widget as @widget" do
        # spec fails with '@_response is nil' unless we stub :render
        allow(controller).to receive(:render)
        controller.make_failed(widget)
        assigns(:widget).should eq(widget)
      end

      it "re-renders the 'new' template" do
        expect(controller).to receive(:render).with(:new)
        controller.make_failed(widget)
      end
    end
  end

  describe "PUT update" do
    it "updates the requested widget via WidgetUpdater" do
      widget = Widget.create! valid_attributes
      # is it better to pass widget or widget.id?
      expect(WidgetUpdater).to receive(:update).with(controller, widget, { "name" => "MyString" })
      put :update, {:id => widget.to_param, :widget => { "name" => "MyString" }}, valid_session
    end

    describe ".updated_succeeded" do
      let(:widget) { double('widget') }

      it "assigns the requested widget as @widget" do
        # spec fails with '@_response is nil' unless we stub :redirect_to
        allow(controller).to receive(:redirect_to)
        controller.update_succeeded(widget)
        assigns(:widget).should eq(widget)
      end

      it "redirects to the widget" do
        expect(controller).to receive(:redirect_to).with(widget)
        controller.update_succeeded(widget)
      end
    end

    describe ".updated_failed" do
      let(:widget) { double('widget') }

      it "assigns the requested widget as @widget" do
        # spec fails with '@_response is nil' unless we stub :redirect_to
        allow(controller).to receive(:render)
        controller.update_failed(widget)
        assigns(:widget).should eq(widget)
      end

      it "re-renders the 'edit' template" do
        expect(controller).to receive(:render).with(:edit)
        controller.update_failed(widget)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested widget" do
      widget = Widget.create! valid_attributes
      expect {
        delete :destroy, {:id => widget.to_param}, valid_session
      }.to change(Widget, :count).by(-1)
    end

    it "redirects to the widgets list" do
      widget = Widget.create! valid_attributes
      delete :destroy, {:id => widget.to_param}, valid_session
      response.should redirect_to(widgets_url)
    end
  end

end
