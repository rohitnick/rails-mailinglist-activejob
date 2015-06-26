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
    if @visitor.save
      render json: {visitor: @visitor, status: :created}
    else
      render :new
    end
  end

  private
    def visitor_params
      params.require(:visitor).permit(:email, :referer_token)
    end

end
