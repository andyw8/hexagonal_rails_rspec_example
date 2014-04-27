require 'spec_helper'

describe WidgetCreator do
  describe ".make" do
    let(:listener) { double('listener') }
    let(:params) { double('params') }

    it "instantiates a new Widget with the given params" do
      widget = double('widget')
      allow(widget).to receive(:save).and_return(true)
      allow(listener).to receive(:make_succeeded)
      expect(Widget).to receive(:new).with(params).and_return(widget)

      described_class.make(listener, params)
    end

    it "handles success" do
      widget = double('widget', save: true)
      allow(Widget).to receive(:new).and_return(widget)

      expect(listener).to receive(:make_succeeded).with(widget)

      described_class.make(listener, params)
    end

    it "handles failure" do
      widget = double('widget', save: false)
      allow(Widget).to receive(:new).and_return(widget)

      expect(listener).to receive(:make_failed).with(widget)

      described_class.make(listener, params)
    end
  end
end
