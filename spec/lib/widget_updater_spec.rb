require 'spec_helper'

describe WidgetUpdater do
  describe ".update" do
    let(:listener) { double('listener') }
    let(:params) { double('params') }
    let(:widget) { double('widget') }

    it "attempts to update the widget with the given params" do
      listener = double('listener').as_null_object

      expect(widget).to receive(:update).with(params)

      described_class.update(listener, widget, params)
    end

    context "on success" do
      it "notifies the listener" do
        allow(widget).to receive(:update).with(params).and_return(true)

        expect(listener).to receive(:update_succeeded).with(widget)

        described_class.update(listener, widget, params)
      end
    end

    context "on failure" do
      it "notifies the listener" do
        allow(widget).to receive(:update).with(params).and_return(false)

        expect(listener).to receive(:update_failed).with(widget)

        described_class.update(listener, widget, params)
      end
    end
  end
end
