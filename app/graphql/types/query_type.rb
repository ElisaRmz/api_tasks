# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :project, Types::ProjectType, null: true do
      description "Obtains a project with their ID."
      argument :id, ID, required: true, description: "ID of the project."
    end

    def project(id:)
      Project.find(id)
    end

    field :projects, [Types::ProjectType], null: true do
      description "Obtains a list of projects."
    end

    def projects
      Project.all
    end

    field :tasks, [Types::TaskType], null: true do
      description "Obtains a list of tasks."
    end

    def tasks
      Task.all
    end
  end
end
