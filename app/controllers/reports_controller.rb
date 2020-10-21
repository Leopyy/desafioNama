class ReportsController < ApplicationController
  require 'csv'

  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def show
    @report = Report.find(params[:id])
    @income = 0
    @report.items.each do |item|
      @income = @income + (item.quantity * item.price)
    end
  end
       
  def create
    @report = Report.new(report_params)
    if @report.save
      csv_options = { col_sep: "\t", headers: :first_row }
      filepath    = params[:report][:file].tempfile
        CSV.foreach(filepath, csv_options) do |row|
        item = { buyer: row['Comprador'],
                 description: row['Descrição'],
                 price: row['Preço Unitário'],
                 quantity: row['Quantidade'],
                 adress: row['Endereço'],
                 supplyer: row['Fornecedor'] }
        next if item[:price] == nil
        @item = Item.new(item)        
        @item.report = @report
        @item.save
      end
      redirect_to @report, notice: "Arquivo enviado com sucesso"
    else
      render 'new', notice: "Erro. Arquivo não enviado"
    end
  end

  private

  def report_params
    params.require(:report).permit(:title, :file)
  end
end
