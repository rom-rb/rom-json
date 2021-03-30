# frozen_string_literal: true

describe ROM::JSON do
  let(:configuration) { ROM::Configuration.new(:json, path) }
  let(:root) { Pathname(__FILE__).dirname.join('..') }
  let(:container) { ROM.container(configuration) }

  subject(:relations) { ROM.container(configuration).relations }

  context 'with single file' do
    let(:path) { "#{root}/fixtures/test_db.json" }

    let(:users_relation) do
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

    before { configuration.register_relation(users_relation) }

    it 'returns mapped struct' do
      jane = relations[:users].by_name('Jane').first

      expect(jane.name).to eql('Jane')
      expect(jane.email).to eql('jane@doe.org')
      expect(jane.roles).
        to eql([{ role_name: 'Member' }, { role_name: 'Admin' }])
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
      [users_relation, tasks_relation].
        each { |relation| configuration.register_relation(relation) }
    end

    it 'returns data from users.json file' do
      expect(relations[:users]).
        to match_array([{ name: 'Jane', email: 'jane@doe.org' }])
    end

    it 'returns data from tasks.json file' do
      expect(relations[:tasks]).to match_array(
        [
          { title: 'Task One' },
          { title: 'Task Two' },
          { title: 'Task Three' }
        ]
      )
    end
  end
end
