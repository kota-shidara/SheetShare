class PurchasesController < ApplicationController

  def step1
    @q = TrainLine.ransack(params[:q])
    @results = @q.result(distinct: true)
  end
end
