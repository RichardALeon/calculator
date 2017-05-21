class PageController < ApplicationController
  before_action :init_memory

  def init_memory
    session[:memory] ||= []
  end

  def index
  end

  def execute
    result = Calc.doMath(params[:left],params[:operation],params[:right])
    add_to_memory result
    respond_to do |format|
      msg = { :status => "ok", :result => result, :memory => session[:memory] }
      format.json { render :json => msg }
    end
  end

  def memory
    respond_to do |format|
      msg = { :status => "ok", :memory => session[:memory] }
      format.json { render :json => msg }
    end
  end

  private

  def add_to_memory(result)
    session[:memory].push(result)
    if session[:memory].length > 10
      session[:memory].shift
    end
  end
end
