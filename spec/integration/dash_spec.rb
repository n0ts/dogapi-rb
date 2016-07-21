require_relative '../spec_helper'

describe Dogapi::Client do
  DASH_ID = 424_242
  TITLE = 'My awesome dashboard'.freeze
  DESCRIPTION = 'Lorem ipsum'.freeze
  GRAPHS = [{
    'definition' => {
      'events' => [],
      'requests ' => [
        { 'q' => 'avg:system.mem.free{*}' }
      ],
      'viz' => 'timeseries'
    },
    'title' => 'Average Memory Free'
  }].freeze
  TEMPLATE_VARIABLES = [{
    'name' => 'host1',
    'prefix' => 'host',
    'default' => 'host:my-host'
  }].freeze

  BODY = {
    title: TITLE,
    description: DESCRIPTION,
    graphs: GRAPHS,
    template_variables: TEMPLATE_VARIABLES
  }.freeze
  ARGS = BODY.values

  describe '#create_dashboard' do
    it_behaves_like 'an api method',
                    :create_dashboard, ARGS,
                    :post, '/dash', BODY
  end

  describe '#update_dashboard' do
    it_behaves_like 'an api method',
                    :update_dashboard, [DASH_ID] + ARGS,
                    :put, "/dash/#{DASH_ID}", BODY
  end

  describe '#get_dashboard' do
    it_behaves_like 'an api method',
                    :get_dashboard, [DASH_ID],
                    :get, "/dash/#{DASH_ID}"
  end

  describe '#get_dashboards' do
    it_behaves_like 'an api method',
                    :get_dashboards, [],
                    :get, '/dash'
  end

  describe '#delete_dashboard' do
    it_behaves_like 'an api method',
                    :delete_dashboard, [DASH_ID],
                    :delete, "/dash/#{DASH_ID}"
  end
end
