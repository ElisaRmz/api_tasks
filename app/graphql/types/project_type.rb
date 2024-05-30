# frozen_string_literal: true

module Types
  class ProjectType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :completed, Boolean
    field :tasks, [Types::TaskType], null: true, description: "List of tasks for the project"

    def tasks
      object.tasks
    end
  end
end
