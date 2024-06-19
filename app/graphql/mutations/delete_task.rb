module Mutations
  class DeleteTask < BaseMutation
    argument :id, ID, required: true

    field :success, Boolean, null: false
    field :errors, [String], null: false

    def resolve(id:)
      project = Project.find_by(id: id)
      if project&.destroy
        { success: true, errors: [] }
      else
        { success: false, errors: project.errors.full_messages.presence || ["Task not found"] }
      end
    rescue ActiveRecord::RecordNotFound
      { success: false, errors: ["Task not found"] }
    end
  end
end
