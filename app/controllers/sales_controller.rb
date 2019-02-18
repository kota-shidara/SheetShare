class SalesController < ApplicationController

  def new
    @sale = Sale.new
    @train_lines = TrainLine.all
    @selected_train_line_id = params[:selected_train_line_id]
    @stations = Station.where(train_line_id: @selected_train_line_id)
  end

  def create
    @sale = Sale.new(station_params)
    @sale.seller_user_id = current_user.id
    if @sale.save
      redirect_to("/sales/#{@sale.id}/step2")
    else
      @train_lines = TrainLine.all
      @selected_train_line_id = params[:selected_train_line_id]
      @stations = Station.where(train_line_id: @selected_train_line_id)
      render("sales/new")
    end
  end

  def step2
    @sale = Sale.find(params[:id])
    train_line_id = @sale.train_line_id
    # データベースが大きくなったときに全てのTrainのデータから探さないように、可能性があるものだけ選別
    @possible_trains = Train.where(train_line_id: train_line_id)
    @station_trains = StationTrain.where(station_id: @sale.get_on_station_id).where(train_id: @possible_trains.ids)
  end

  def update
    @sale = Sale.find(params[:id])
    if @sale.update(extra_information_params)
      redirect_to("/sales/#{@sale.id}/check")
    else
      train_line_id = @sale.train_line_id
      @possible_trains = Train.where(train_line_id: train_line_id)
      @station_trains = StationTrain.where(station_id: @sale.get_on_station_id).where(train_id: @possible_trains.ids)
      render "sales/step2"
    end
  end

  def check
    @sale = Sale.find(params[:id])
  end

  def confirm
    @sale = Sale.find(params[:id])
    @sale.update(confirmation_params)
    flash[:notice] = "座席の売り情報が確定しました。そのまま終点まで座ったまま買い手をお待ち下さい。"
    # TODO 本当はここでroot_pathに通さず、取引完了を待つ画面に飛ばす
    redirect_to root_path
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
      params.require(:sale).permit(:confirmation)
    end
end
