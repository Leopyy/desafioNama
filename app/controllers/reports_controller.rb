class ReportsController < ApplicationController
  def index
    @reports = Report.all
  end

  def new
    @report = Report.new
  end

  def parse
    
  end

  def create
    @report = Report.new(report_params)
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
