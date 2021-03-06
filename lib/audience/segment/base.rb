module Audience
  module Segment
    class Base
      attr_accessor :name
      delegate :each, :size, :sample, to: :members

      def initialize(*args)
      end

      def members
        raise NotImplementedError
      end

      def include?(_member)
        raise NotImplementedError
      end

      def add(_member)
        raise NotImplementedError
      end

      def remove(_member)
        raise NotImplementedError
      end
    end
  end
end
