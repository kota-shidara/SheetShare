class SalesController < ApplicationController

  before_action :ensure_seller_user, {only: [:step, :append, :check, :confirm, :edit, :update, :destroy]}
  before_action :forbid_confirmed_sale, {only: [:step, :append, :check, :confirm]}
  require 'securerandom'

  def new
    @sale                   = Sale.new
    @train_lines            = TrainLine.all
    @selected_train_line_id = params[:selected_train_line_id]
    @stations               = Station.where(train_line_id: @selected_train_line_id)
  end

  def create
    @sale                = Sale.new(station_params)
    @sale.seller_user_id = current_user.id
    if @sale.save
      redirect_to step_sale_path(@sale.id)
    else
      @train_lines            = TrainLine.all
      @selected_train_line_id = params[:selected_train_line_id]
      @stations               = Station.where(train_line_id: @selected_train_line_id)
      render("sales/new")
    end
  end

  def step
    @sale            = Sale.find(params[:id])
    # データベースが大きくなったときに全てのTrainのデータから探さないように、可能性があるものだけ選別
    @possible_trains = Train.where(train_line_id: @sale.train_line.id)
    @station_trains  = StationTrain.where(station_id: @sale.get_on_station_id, train_id: @possible_trains.ids)
  end

  def append
    @sale = Sale.find(params[:id])
    if @sale.update(extra_information_params)
      redirect_to check_sale_path(@sale.id)
    else
      @possible_trains = Train.where(train_line_id: @sale.train_line.id)
      @station_trains  = StationTrain.where(station_id: @sale.get_on_station_id, train_id: @possible_trains.ids)
      render "sales/step"
    end
  end

  def check
    @sale = Sale.find(params[:id])
    if @sale.transaction_number.nil?
      @transaction_number = (rand(1..9).to_s + format("%03d", SecureRandom.random_number(10**3)).to_s).to_i
    else
      @transaction_number = @sale.transaction_number
    end
  end

  def confirm
    @sale = Sale.find(params[:id])
    @sale.update(confirmation_params)
    flash[:notice] = "座席の売り情報が確定しました。そのまま終点まで座ったまま買い手をお待ち下さい。"
    redirect_to sale_path(@sale.id)
  end

  def show
    @sale = Sale.find(params[:id])
  end

  def edit
    @sale = Sale.find(params[:id])
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update(update_params) && @sale.transaction_number.present?
      redirect_to sale_path(@sale.id)
    elsif @sale.update(update_params)
      redirect_to check_sale_path(@sale.id)
    else
      render "sales/edit"
    end
  end

  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy
    flash[:notice] = "席売り情報を削除しました"
    redirect_to root_path
  end

  def ensure_seller_user
    sale = Sale.find(params[:id])
    if sale.seller_user_id != current_user.id
      redirect_to root_path
      flash[:notice] = "権限がありません"
    end
  end

  def forbid_confirmed_sale
    sale = Sale.find(params[:id])
    if sale.transaction_number.present?
      redirect_to sale_path(sale.id)
      flash[:notice] = "売り情報は既に確定しています"
    end
  end

  private
    def station_params
      params.require(:sale).permit(:get_on_station_id, :get_off_station_id)
    end

    def extra_information_params
      params.require(:sale).permit(:train_id,
                                  :car_number,
                                  :sheet_type,
                                  :sheet_number,
                                  :seller_user_description)
    end

    def confirmation_params
      params.require(:sale).permit(:transaction_number)
    end

    def update_params
      params.require(:sale).permit(:car_number,
                                  :sheet_type,
                                  :sheet_number,
                                  :seller_user_description)
    end

end
