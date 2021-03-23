require 'spec_helper'

require 'rom/lint/spec'

describe ROM::JSON do
  let(:configuration) { ROM::Configuration.new(:json, path) }
  let(:root) { Pathname(__FILE__).dirname.join('..') }
  let(:container) { ROM.container(configuration) }

  subject(:rom) { container }

  context 'with single file' do
    let(:path) { "#{root}/fixtures/test_db.json" }

    let(:relation) do
      Class.new(ROM::JSON::Relation) do
        schema(:users) do
          attribute :name, ROM::Types::String
          attribute :email, ROM::Types::String
          attribute :roles, ROM::Types::Array
        end

        auto_struct true

        def by_name(name)
          restrict(name: name)
        end
      end
    end

    before { configuration.register_relation(relation) }

    describe 'Relation#first' do
      it 'returns mapped struct' do
        jane = rom.relations[:users].by_name('Jane').first

        expect(jane.name).to eql('Jane')
        expect(jane.email).to eql('jane@doe.org')
        expect(jane.roles).
          to eql([{ role_name: 'Member' }, { role_name: 'Admin' }])
      end
    end
  end

  context 'with muli-file setup' do
    let(:path) { "#{root}/fixtures/db" }

    let(:users_relation) do
      Class.new(ROM::JSON::Relation) do
        schema(:users) do
          attribute :name, ROM::Types::String
          attribute :email, ROM::Types::String
        end
      end
    end

    let(:tasks_relation) do
      Class.new(ROM::JSON::Relation) do
        schema(:tasks) do
          attribute :title, ROM::Types::String
        end
      end
    end

    before do
      configuration.register_relation(users_relation)
      configuration.register_relation(tasks_relation)
    end

    it 'uses one-file-per-relation' do
      expect(rom.relations[:users]).
        to match_array([{ name: 'Jane', email: 'jane@doe.org' }])

      expect(rom.relations[:tasks]).to match_array([
        { title: 'Task One' },
        { title: 'Task Two' },
        { title: 'Task Three' }
      ])
    end
  end
end
