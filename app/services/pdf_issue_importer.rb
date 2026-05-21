require 'open3'
require 'json'

class PdfIssueImporter
  Result = Struct.new(:imported, :created_nodes, :failed, :errors, keyword_init: true)

  def initialize(pdf_path)
    @pdf_path = pdf_path
    @workspace = Workspace.find_by!(name: "Vista 553")
    @output_dir = Rails.root.join("tmp/imports")
    FileUtils.mkdir_p(@output_dir)
  end

  def call
    result = Result.new(imported: 0, created_nodes: 0, failed: 0, errors: [])
    json = run_python_parser
    return result unless json

    created_nodes = Set.new

    json.each do |block|
      begin
        node = Node.find_or_create_by!(
          workspace: @workspace,
          name: block["location"],
          node_type: "location"
        )
        created_nodes << node.id

        title = block["description"].to_s.split('.').first || "Issue"
        description = block["description"]
        image_path = block["image_path"]

        # Duplicate prevention
        next if Issue.exists?(node: node, title: title, description: description)

        issue = Issue.create!(
          workspace: @workspace,
          node: node,
          title: title,
          description: description,
          status: :open,
          priority: :medium
        )

        if image_path && File.exist?(image_path)
          issue.files.attach(
            io: File.open(image_path),
            filename: File.basename(image_path)
          )
        end

        result.imported += 1
      rescue => e
        result.failed += 1
        result.errors << { block: block, error: e.message }
      end
    end

    result.created_nodes = created_nodes.size
    result
  end

  private

  def run_python_parser
    python_bin = Rails.root.join("venv/bin/python").to_s
    script = Rails.root.join("scripts/import_inspection_pdf.py")
    stdout, stderr, status = Open3.capture3(python_bin, script.to_s, @pdf_path.to_s)
    unless status.success?
      Rails.logger.error("PDF import failed: #{stderr}")
      return nil
    end
    JSON.parse(stdout)
  rescue => e
    Rails.logger.error("PDF import error: #{e.message}")
    nil
  end
end

