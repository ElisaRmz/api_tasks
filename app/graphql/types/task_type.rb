# frozen_string_literal: true

module Types
  class TaskType < Types::BaseObject
    field :title, String
    field :description, String
    field :completed, Boolean
  end
end
