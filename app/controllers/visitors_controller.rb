class VisitorsController < ApplicationController

  def new
    @visitor = Visitor.new
    if params[:referer_token].present?
      referer = Visitor.find_by_refer_token(params[:referer_token]) or not_found
      referer.increment!(:refer_visit_count)
    end
  end

  def create
    @visitor = Visitor.new(visitor_params)
    @visitor.ip_address = request.remote_ip
    binding.pry
    if @visitor.save
      redirect_to root_path, notice: "Signed up #{@visitor.email}."
    else
      render :new
    end
  end

  private
    def visitor_params
      params.require(:visitor).permit(:email, :referer_token)
    end

end
