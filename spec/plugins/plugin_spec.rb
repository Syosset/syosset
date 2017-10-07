require 'rails_helper'
require "test_implementations/plugin_test"

module Syosset::Plugins
  RSpec.describe Plugin do
    it "can access plugin information" do
      expect(TestPlugin.plugin_name).to eq "Test Plugin"
      expect(TestPlugin.plugin_description).to eq "The coolest test ever"
    end

    it "can inject plugin behavior into a plugable model" do
      plugable = PlugableModel.new
      expect { plugable.coolio = true }.to change { plugable.coolio }.from(false).to(true)
    end
  end
end
