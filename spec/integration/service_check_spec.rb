require_relative '../spec_helper'

describe Dogapi::Client do
  BODY = { check: 'app.is_ok', host_name: 'app1', status: 0 }.freeze
  ARGS = BODY.values

  describe '#service_check' do
    it_behaves_like 'an api method with options',
                    :service_check, ARGS,
                    :post, '/check_run', BODY
  end
end
