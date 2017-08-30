require 'rails_helper'
require "test_implementations/plugin_test"

module Syosset::Plugins
  RSpec.describe Plugin do
    it "can access plugin information" do
      expect(PluginTest.plugin_name).to eq "Test Plugin"
      expect(PluginTest.plugin_description).to eq "The coolest test ever"
    end
  end
end
