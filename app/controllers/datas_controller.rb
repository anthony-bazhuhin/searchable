class DatasController < ApplicationController
  def index
  end

  def search
    render json: DataScope.filter(params[:phrase]).to_json
  end
end
