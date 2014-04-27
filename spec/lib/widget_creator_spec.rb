require 'spec_helper'

describe WidgetCreator do
  describe ".make" do
    let(:listener) { double('listener') }
    let(:params) { double('params') }
    let(:widget) { double('widget') }

    it "instantiates a new Widget with the given params" do
      widget = double('widget').as_null_object
      listener = double('listener').as_null_object

      expect(Widget).to receive(:new).with(params).and_return(widget)
      described_class.make(listener, params)
    end

    context "on success" do
      it "notifies the listener" do
        allow(widget).to receive(:save).and_return(true)
        allow(Widget).to receive(:new).and_return(widget)

        expect(listener).to receive(:make_succeeded).with(widget)

        described_class.make(listener, params)
      end
    end

    context "on failure" do
      it "notifies the listener" do
        allow(widget).to receive(:save).and_return(false)
        allow(Widget).to receive(:new).and_return(widget)

        expect(listener).to receive(:make_failed).with(widget)

        described_class.make(listener, params)
      end
    end

  end
end
