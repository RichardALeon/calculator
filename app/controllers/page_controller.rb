class PageController < ApplicationController

  def index
  end

  def execute
    result = Calc.doMath(params[:left],params[:operation],params[:right])
    respond_to do |format|
      msg = { :status => "ok", :result => result }
      format.json { render :json => msg }
    end
  end
end
