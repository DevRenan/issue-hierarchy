class IssuesController < ApplicationController
  include KanbanHelper

  before_action :set_issue, only: %i[ show edit update destroy ]
  before_action :set_workspace, only: %i[ show ]

  # GET /issues or /issues.json
  def index
    @issues = Issue.all
  end

  # GET /issues/1 or /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new(
      workspace_id: params[:workspace_id],
      node_id: params[:node_id]
    )
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues or /issues.json
  def create
    @issue = Issue.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: "Issue was successfully created." }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @issue.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /issues/1 or /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to @issue, notice: "Issue was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @issue.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /issues/1 or /issues/1.json
  def destroy
    @issue.destroy!

    respond_to do |format|
      format.html { redirect_to issues_path, notice: "Issue was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # DELETE /issues/:id/purge_file/:file_id
  def purge_file
    @issue = Issue.find(params[:id])
    file = @issue.files.find(params[:file_id])
    file.purge
    redirect_to @issue, notice: "File removed."
  end

  # GET /issues/kanban
  def kanban
    @nodes = Node.order(:name)
    @selected_node_id = params[:node_id]
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    issues = Issue.all
    if @selected_node_id.present?
      node_ids = Node.self_and_descendant_ids(@selected_node_id)
      issues = issues.by_node(node_ids)
    end
    issues = issues.by_date_range(@start_date, @end_date)
    issues = issues.ordered_by_priority

    @issues_by_status = issues.group_by(&:status)

    # Estatísticas
    @stats = {
      total: issues.count,
      open: issues.select { |i| i.status == "open" }.count,
      in_progress: issues.select { |i| i.status == "in_progress" }.count,
      resolved: issues.select { |i| i.status == "resolved" }.count,
      closed: issues.select { |i| i.status == "closed" }.count,
      critical: issues.select { |i| i.priority == "critical" }.count
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params.expect(:id))
    end

    def set_workspace
      @workspace = @issue&.workspace
    end

    # Only allow a list of trusted parameters through.
    def issue_params
      params.require(:issue).permit(:workspace_id, :node_id, :title, :description, :status, :priority, files: [])
    end
end
