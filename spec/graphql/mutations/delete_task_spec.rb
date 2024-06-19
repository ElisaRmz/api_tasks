require 'rails_helper'

RSpec.describe 'DeleteTask Mutation', type: :request do
  let!(:project) { Project.create(title: 'Test Project') } # Creates the project
  let!(:task) { Task.create(title: 'Task_1', description: 'Description', project_id: project.id) } # Creates the project
  let(:mutation) do
    <<~GQL
      mutation {
        deleteTask(input: { id: #{task.id} }) {
          success
          errors
        }
      }
    GQL
  end

  it 'deletes a task from a project' do
    expect {
      post graphql_path, params: { query: mutation }
    }.to change { Task.count }.by(-1)

    json_response = JSON.parse(response.body)
    expect(json_response['data']['deleteTask']['success']).to be true
    expect(json_response['data']['deleteTask']['errors']).to be_empty
  end
end
