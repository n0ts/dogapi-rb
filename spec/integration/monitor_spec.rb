require_relative '../spec_helper'

describe Dogapi::Client do
  MONITOR_ID = 42
  MONITOR_TYPE = 'custom type'.freeze
  QUERY = 'avg(last_10m):avg:test.metric.metric{host:test.metric.host} > 5'.freeze

  describe '#monitor' do
    it_behaves_like 'an api method with options',
                    :monitor, [MONITOR_TYPE, QUERY],
                    :post, '/monitor', 'type' => MONITOR_TYPE, 'query' => QUERY
  end

  describe '#update_monitor' do
    it_behaves_like 'an api method with options',
                    :update_monitor, [MONITOR_ID, QUERY],
                    :put, "/monitor/#{MONITOR_ID}", 'query' => QUERY
  end

  describe '#get_monitor' do
    it_behaves_like 'an api method with optional params',
                    :get_monitor, [MONITOR_ID],
                    :get, "/monitor/#{MONITOR_ID}", group_states: %w(custom all)
  end

  describe '#delete_monitor' do
    it_behaves_like 'an api method',
                    :delete_monitor, [MONITOR_ID],
                    :delete, "/monitor/#{MONITOR_ID}"
  end

  describe '#get_all_monitors' do
    it_behaves_like 'an api method with optional params',
                    :get_all_monitors, [],
                    :get, '/monitor', group_states: %w(custom all), tags: ['test', 'key:value']
  end

  describe '#mute_monitors' do
    it_behaves_like 'an api method',
                    :mute_monitors, [],
                    :post, '/monitor/mute_all'
  end

  describe '#unmute_monitors' do
    it_behaves_like 'an api method',
                    :unmute_monitors, [],
                    :post, '/monitor/unmute_all'
  end

  describe '#mute_monitor' do
    it_behaves_like 'an api method',
                    :mute_monitor, [MONITOR_ID],
                    :post, "/monitor/#{MONITOR_ID}/mute", {}
  end

  describe '#unmute_monitor' do
    it_behaves_like 'an api method',
                    :unmute_monitor, [MONITOR_ID],
                    :post, "/monitor/#{MONITOR_ID}/unmute", {}
  end
end
