require 'rails_helper'

RSpec.describe 'CreateProject Mutation', type: :request do
   describe 'createProject mutation' do
      let(:query) do
        <<~GQL
          mutation {
            createProject(title: "#{variables[:title]}", completed: #{variables[:completed]}) {
                title
                completed
            }
          }
        GQL
      end

    let(:variables) do
      {
          title: "My Project Title",
          completed: false
      }
    end

    it 'creates a new project' do
      post graphql_path, params: { query: query, variables: variables }
      json = JSON.parse(response.body)
      data = json['data']['createProject']

      expect(data['title']).to eq(variables[:title])
      expect(data['completed']).to eq(variables[:completed])
    end
  end
end
