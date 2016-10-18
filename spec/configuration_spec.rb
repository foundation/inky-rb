require 'spec_helper'

RSpec.describe "Configuration" do
  around do |spec|
    Inky.configure do |config|
      old = config.template_engine
      spec.run
      config.template_engine = old
    end
  end

  it "default value is :erb" do
    Inky::Configuration.new.template_engine = :erb
  end

  describe "#configuration=" do
    it "can set value" do
      config = Inky::Configuration.new
      config.template_engine = :haml
      expect(config.template_engine).to eq(:haml)
    end
  end

  describe "#configuration=" do
    before do
      Inky.configure do |config|
        config.template_engine = :haml
      end
    end

    it "returns :haml as configured template_engine" do
      template_engine = Inky.configuration.template_engine

      expect(template_engine).to be_a(Symbol)
      expect(template_engine).to eq(:haml)
    end
  end
end
