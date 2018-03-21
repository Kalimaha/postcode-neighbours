require 'faker'

module Faker
  class Address < Base
    class << self
      def suburb
        fetch('address, suburb')
      end
    end
  end
end
