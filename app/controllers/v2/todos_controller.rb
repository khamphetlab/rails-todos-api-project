class V2::TodosController < ApplicationController
  def index
    json_response({ message: 'Hello man, this is todos v2' })
  end
end
