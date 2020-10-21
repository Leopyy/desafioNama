class ReportsController < ApplicationController
  require 'csv'

  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end
       
  def create
    @report = Report.new(report_params)
    if @report.save     
      
      csv_options = { col_sep: "\t", headers: :first_row }
      filepath    = params[:report][:file].tempfile
  
      CSV.foreach(filepath, csv_options) do |row|
        item = { buyer: row['Comprador'], description: row['Descrição'], price: row['Preço Unitário'], quantity: row['Quantidade'], adress: row['Endereço'], supplyer: row['Fornecedor'] }
        @item = Item.new(item)
        @item.report = @report
        @item.save
      end

      flash[:success] = "Arquivo enviado com sucesso"
      # redirect_to show
      
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
