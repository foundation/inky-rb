module Inky
  module Rails
    VERSION = '1.3.7.6'.freeze
  end
  NODE_VERSION, GEM_VERSION = Rails::VERSION.rpartition('.').map(&:freeze)
end
