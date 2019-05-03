require 'spec_helper'

RSpec.describe "Inky.configuration" do
  it "returns an Inky::Configuration object" do
    expect(Inky.configuration).to be_an_instance_of Inky::Configuration
  end

  describe "=" do
    it "accepts an Inky::Configuration" do
      current_config = Inky.configuration
      config = Inky::Configuration.new

      expect { Inky.configuration = config }.to_not raise_error
      expect(Inky.configuration).to_not eq(current_config)
      expect(Inky.configuration).to eq(config)

      expect { Inky.configuration = {} }.to raise_error(TypeError, "Not an Inky::Configuration")
      expect(Inky.configuration).to eq(config)

      expect { Inky.configuration = current_config }.to_not raise_error
      expect(Inky.configuration).to eq(current_config)
    end
  end

  describe "&block" do
    it "yields the current configuration" do
      current_config = Inky.configuration
      new_config = Inky::Configuration.new

      Inky.configuration = new_config

      Inky.configuration do |config|
        expect(config).to be_an_instance_of Inky::Configuration
        expect(config).to_not eq(current_config)
        expect(config).to eq(new_config)
      end

      Inky.configuration = current_config
    end
  end
end

RSpec.describe "Configuration" do
  describe "#template_engine" do
    it "default value is :erb" do
      expect(Inky::Configuration.new.template_engine).to eq(:erb)
    end
  end

  describe "#template_engine=" do
    it "sets/updates the template_engine" do
      config = Inky::Configuration.new
      config.template_engine = :haml
      expect(config.template_engine).to eq(:haml)
    end

    it "accepts symbols" do
      config = Inky::Configuration.new
      value = []
      expect { config.template_engine = value }.to raise_error(TypeError, "#{value.inspect} (#{value.class}) does not respond to 'to_sym'")
      expect(config.template_engine).to eq(:erb)
    end
  end

  describe "#column_count" do
    it "default value is 12" do
      expect(Inky::Configuration.new.column_count).to eq(12)
    end
  end

  describe "#column_count=" do
    it "sets/updates the column_count" do
      config = Inky::Configuration.new
      config.column_count = 24
      expect(config.column_count).to eq(24)
    end

    it "accepts integers" do
      config = Inky::Configuration.new
      value = :haml
      expect { config.column_count = value }.to raise_error(TypeError, "#{value.inspect} (#{value.class}) does not respond to 'to_int'")
      expect(config.column_count).to eq(12)
    end
  end

  describe "#components" do
    it "defaults to an empty hash" do
      config = Inky::Configuration.new
      expect(config.components).to eq({})
    end
  end

  describe "#components=" do
    it "can set overriden component tags" do
      config = Inky::Configuration.new
      config.components = { button: 'inky-button' }
      expect(config.components).to eq(button: 'inky-button')
    end

    it "will not set an invalid components override" do
      config = Inky::Configuration.new
      [
        nil,
        1,
        "{}",
        false,
        true
      ].each do |value|
        expect { config.components = value }.to raise_error(TypeError, "#{value.inspect} (#{value.class}) does not respond to 'to_hash'")
        expect(config.components).to eq({})
      end
    end
  end
end
