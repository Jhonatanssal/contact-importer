# frozen_string_literal: true

class ContactsController < ApplicationController
  def show
    @contact = Contact.find(params[:id])
  end

  def upload; end
end
