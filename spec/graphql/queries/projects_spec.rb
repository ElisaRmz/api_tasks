require 'rails_helper'

RSpec.describe 'GraphQL', type: :request do
  describe 'projects query' do
    let(:query) do
      <<~GQL
        {
          projects {
            id
            title
            completed
          }
        }
      GQL
    end

    let!(:project) do
      Project.create(
        title: 'Project Title',
        completed: false
      )
    end

    it 'returns a list of projects' do
      post '/graphql', params: { query: query }

      json = JSON.parse(response.body)
      data = json['data']['projects']

      expect(data).to be_an_instance_of(Array)
      expect(data.first['id']).to eq(project.id.to_s)
      expect(data.first['title']).to eq(project.title)
      expect(data.first['completed']).to eq(project.completed)
    end
  end
end
