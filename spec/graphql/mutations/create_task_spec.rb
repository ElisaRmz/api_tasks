require 'rails_helper'

RSpec.describe 'CreateTask Mutation', type: :request do
   describe 'createTask mutation' do
      let(:query) do
        <<~GQL
        mutation($title: String!, $description: String!, $projectId: ID!) {
          createTask(title: $title, description: $description, projectId: $projectId) {
            id
            title
            description
            completed
            project {
              id
              title
            }
          }
        }
      GQL
    end

    let(:project) { Project.create(title: 'Example Project') }

    it 'creates a task within a project' do
      variables = { title: 'New Task', description: 'Task description', completed: false, projectId: project.id }

      post '/graphql', params: { query: query, variables: variables }

      json = JSON.parse(response.body)
      data = json['data']['createTask']

      expect(data['title']).to eq('New Task')
      expect(data['project']['id']).to eq(project.id.to_s)
    end
  end
end
