require_relative "./base"

module Inky
  module Components
    class Inky < Base

      def transform(component, inner)
        inky.release_the_kraken(inner)
      end
      
    end
  end
end