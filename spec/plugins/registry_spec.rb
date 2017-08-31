require 'rails_helper'
require "test_implementations/plugin_test"

module Syosset::Plugins
  RSpec.describe Registry do

    before(:each) do
      Registry.plugins = []
    end

    it "registers plugins" do
      expect { Registry.register TestPlugin }.to change{ Registry.plugins.empty? }.from(true).to(false)
    end

    it "notifies callbacks of plugin registry" do
      flag = 0
      Registry.on_register do
        flag = 1
      end

      expect { Registry.register TestPlugin }.to change{ flag }.from(0).to(1)
    end
  end
end
