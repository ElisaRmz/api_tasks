module Mutations
  class DeleteProject < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :errors, [String], null: false

    def resolve(id:)
      project = Project.find_by(id: id)
      if project&.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: project.errors.full_messages.presence || ["Project not found"] }
      end
    rescue ActiveRecord::RecordNotFound
      { success: false, errors: ["Project not found"] }
    end
  end
end
