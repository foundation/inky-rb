module Components
  class CustomBlockWithNestedBlocks < Inky::Components::Base
    
    def transform(component, inner)
      inky.release_the_kraken(%{<wrapper><button>#{inner}</button></wrapper>})
    end

  end
end