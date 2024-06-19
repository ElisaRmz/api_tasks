# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_project, Types::ProjectType, null: false do
      argument :title, String, required: true
      argument :completed, Boolean
    end

    def create_project(title:, completed: false)
      Project.create(title: title, completed: completed)
    end

    field :delete_project, mutation: Mutations::DeleteProject

    field :create_task, Types::TaskType, null: false do
      argument :title, String, required: true
      argument :description, String, required: true
      argument :project_id, ID, required: true
    end

    def create_task(title:, description:, project_id:)
      Task.create(title: title, description: description, project_id: project_id)
    end
  end
end
