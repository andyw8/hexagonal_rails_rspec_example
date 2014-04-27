require 'spec_helper'

describe WidgetUpdater do
  describe ".update" do
    let(:listener) { double('listener') }
    let(:params) { double('params') }
    let(:widget) { double('widget') }

    it "handles success" do
      allow(widget).to receive(:update).with(params).and_return(true)

      expect(listener).to receive(:update_succeeded).with(widget)

      described_class.update(listener, widget, params)
    end

    it "handles failure" do
      allow(widget).to receive(:update).with(params).and_return(false)

      expect(listener).to receive(:update_failed).with(widget)

      described_class.update(listener, widget, params)
    end
  end
end
