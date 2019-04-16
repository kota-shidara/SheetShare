class PurchasesController < ApplicationController
  before_action :forbid_unlogged_in_user
  
  def step1
    @q = TrainLine.ransack(params[:q])
    @results = @q.result(distinct: true)
  end

  def step2
    if params[:direction].empty?
      @q = TrainLine.ransack(params[:q])
      @results = @q.result(distinct: true)
      render 'step1'
    else
      @direction  = params[:direction]
      @train_line = TrainLine.find(params[:train_line_id])
      @stations   = Station.where(train_line_id: @train_line.id)
    end
  end

  def index
    @sales = Sale.where(train_id: Train.where(train_line_id: params[:train_line_id], direction: params[:direction]).pluck(:id))
    @near_station = Station.find(params[:station_id])
  end

  def confirm
    @sale = Sale.find(params[:sale_id])
    if @sale.transaction_number == params[:purchase][:transaction_number].to_i
      @sale.update(buyer_user_id: current_user.id )
      redirect_to thanks_purchases_path
      flash[:notice] = "取引が完了しました！"
    else
      flash[:notice] = "取引番号が正しくありません。"
      render "sales/show"
    end
  end

  private
    def confirm_params
      params.require(:purchase).permit(:transaction_number)
    end
end
