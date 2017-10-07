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

    it "can enable a plugin for a plugable" do
      Registry.register TestPlugin
      plugable = PlugableModel.create

      expect { Registry.enable TestPlugin, plugable }.to change { Registry.enabled? TestPlugin, plugable }.from(false).to(true)
    end

    it "notifies callbacks of plugin enable" do
      Registry.register TestPlugin
      plugable = PlugableModel.create

      flag = nil
      Registry.on_enable do |plugin|
        flag = plugin
      end

      expect { Registry.enable TestPlugin, plugable }.to change{ flag }.from(nil).to(TestPlugin)
    end

    it "can disable a plugin for a plugable" do
      Registry.register TestPlugin
      plugable = PlugableModel.create
      Registry.enable TestPlugin, plugable

      expect { Registry.disable TestPlugin, plugable }.to change { Registry.enabled? TestPlugin, plugable }.from(true).to(false)
    end

    it "notifies callbacks of plugin disable" do
      Registry.register TestPlugin
      plugable = PlugableModel.create
      Registry.enable TestPlugin, plugable

      flag = nil
      Registry.on_disable do |plugin|
        flag = plugin
      end

      expect { Registry.disable TestPlugin, plugable }.to change{ flag }.from(nil).to(TestPlugin)
    end
  end
end
