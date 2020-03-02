module Components
  class CustomBlock < Inky::Components::Base
    
    def transform(component, inner)
      %{<marquee>#{inner}</marquee>}
    end

  end
end