class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :load_workspaces

  layout -> { turbo_frame_request? ? "application" : "application" }

  private

  def load_workspaces
    @workspaces = Workspace.limit(10).order(created_at: :desc)
  end
end
