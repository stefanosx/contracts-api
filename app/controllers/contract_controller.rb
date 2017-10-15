class ContractController < ApplicationController
  acts_as_token_authentication_handler_for User

  before_action :have_access, only: [:show, :destroy]

  def create
    contract = current_user.contracts.create(vendor: params[:vendor], starts_on: params[:starts_on],
                                             ends_on:params[:ends_on], price: params[:price])
    if contract.id.present?
      render json: {message: "Contract created" }
    else
      render json: {message: "Contract did not created", error: {messages: contract.errors.full_messages}},
        status: 422
    end
  end

  def show
    render json: contract.to_json
  end

  def destroy
    vendor = contract.vendor
    contract.destroy
    render json: {message: "Contract #{vendor} deleted successfully"}
  end
  
  private

  def have_access
    unless contract.present? && current_user.id == contract.user_id
      render json: {error: {message: "Contract not found!!"}}
    end
  end

  def contract
    @contract ||= Contract.find_by_id(params[:id])
  end
end
