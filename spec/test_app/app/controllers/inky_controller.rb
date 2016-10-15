class InkyController < ApplicationController
  layout 'inky_layout', only: [:layout]

  def simple
  end

  def non_inky
    @partial_name = params[:partial].presence
  end

  def layout
  end
end
