class ReportsController < ApplicationController
  require 'csv'

  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def parse
    csv_options = { col_sep: '/t', quote_char: '"', headers: :first_row }
    filepath    = url_for(@report.file)
    @items = []

    CSV.foreach(filepath, csv_options) do |row|
      item = { buyer: row['Comprador'], description: row['Descrição'], price: row['Preço Unitário'], quantitiy: row['Quantidade'], adress: row['Endereço'], supplyer: row['Fornecedor'] }
      @items << item
    end

    return @items
  end
        
  def create
    @report = Report.new(report_params)
    @report.parse
    if @report.save
      flash[:success] = "Arquivo enviado com sucesso"
    else
      flash[:error] = "Erro. Arquivo não enviado"
      render 'new'
    end
  end

  private

  def report_params
    params.require(:report).permit(:title, :file)
  end
end
