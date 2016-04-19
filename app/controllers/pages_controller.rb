class PagesController < ApplicationController
  def front
    redirect_to staff_root_path if current_assistant
  end
end