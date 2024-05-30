require 'rails_helper'

RSpec.describe 'Tasks Query', type: :request do
  let(:query) do
    <<~GQL
    query GetTasks($projectId: ID!) {
        project(id: $projectId) {
          title
          tasks {
            id
            title
          }
        }
      }
    GQL
  end

  let(:project) { Project.create!(title: 'Example Project') }
  let!(:tasks) do
    [
      Task.create!(title: 'Task 1', description: "Task 1", project: project),
      Task.create!(title: 'Task 2', description: "Task 2", project: project),
      Task.create!(title: 'Task 3', description: "Task 2", project: project)
    ]
  end

  it 'returns tasks for a specific project' do
    post '/graphql', params: { query: query, variables: { projectId: project.id } }

    json = JSON.parse(response.body)
    data = json['data']['project']['tasks']

    expect(data.size).to eq(3)
    data.each_with_index do |task, index|
      expect(task['title']).to eq(tasks[index].title)
    end
  end
end
