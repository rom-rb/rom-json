# frozen_string_literal: true

describe ROM::JSON::Gateway do
  let(:root) { Pathname(__FILE__).dirname.join('..') }

  it_behaves_like 'a rom gateway' do
    let(:identifier) { :json }
    let(:gateway) { ROM::JSON::Gateway }
    let(:uri) { "#{root}/fixtures/test_db.json" }
  end
end
