class InkyController < ApplicationController
  layout 'inky_layout', only: [:layout]

  def non_inky
    @partial_name = params[:partial].presence
  end

  %w[simple layout slim explicit_slim explicit_builder].each{ |m| define_method(m){} }
end
