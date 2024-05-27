# frozen_string_literal: true

module Types
  class ProjectType < Types::BaseObject
    field :title, String
    field :completed, Boolean
    field :tasks, [Types::TaskType]
  end
end
