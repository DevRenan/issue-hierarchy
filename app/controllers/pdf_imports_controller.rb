class PdfImportsController < ApplicationController
  def new
  end

  def create
    if params[:pdf].blank?
      redirect_to new_pdf_import_path, alert: "Selecione um PDF para importar."
      return
    end

    pdf = params[:pdf]
    tmp_path = Rails.root.join("tmp/imports", pdf.original_filename)
    FileUtils.mkdir_p(tmp_path.dirname)
    File.open(tmp_path, "wb") { |f| f.write(pdf.read) }

    result = PdfIssueImporter.new(tmp_path).call

    render :result, locals: { result: result }
  end
end

