# frozen_string_literal: true

module Types
  class ProjectType < Types::BaseObject
    field :title, String
    field :finished, Boolean
    field :tasks, [Types::TaskType]
  end
end
