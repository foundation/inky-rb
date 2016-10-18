class InkyController < ApplicationController
  layout 'inky_layout', only: [:layout]

  def non_inky
    @partial_name = params[:partial].presence
  end

  %w[simple layout slim].each{ |m| define_method(m){} }
end
