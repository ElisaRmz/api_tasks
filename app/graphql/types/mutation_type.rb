# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_project, Types::ProjectType, null: false do
      description "Creates a new Project"
      argument :title, String, required: true
      argument :completed, Boolean
    end

    def create_project(title:, completed: false)
      Project.create(title: title, completed: completed)
    end
  end
end
