require 'rails_helper'

RSpec.describe 'DeleteProject Mutation', type: :request do
  let!(:project) { Project.create(title: 'Test Project') } # Creates the project
  let(:mutation) do
    <<~GQL
      mutation {
        deleteProject(input: { id: #{project.id} }) {
          success
          errors
        }
      }
    GQL
  end

  it 'deletes a project' do
    expect {
      post graphql_path, params: { query: mutation }
    }.to change { Project.count }.by(-1)

    json_response = JSON.parse(response.body)
    expect(json_response['data']['deleteProject']['success']).to be true
    expect(json_response['data']['deleteProject']['errors']).to be_empty
  end
end
