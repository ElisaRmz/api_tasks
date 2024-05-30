# frozen_string_literal: true

module Types
  class TaskType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: false
    field :completed, Boolean
    field :project, Types::ProjectType, null: false
  end
end
