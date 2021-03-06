require 'active_support/all'

module Audience
  mattr_accessor :member_class
  mattr_reader :registry do
    HashWithIndifferentAccess.new
  end

  class << self
    def register_segment(name, segment_klass, *args)
      registry[name] = [segment_klass.to_s, args]
    end

    def segment(name)
      raise ArgumentError unless valid_segment?(name)
      build_segment(name)
    end

    def valid_segment?(name)
      registry.key?(name)
    end

    def segment_names
      segments.map(&:name)
    end

    def segments
      registry.keys.map { |name| segment(name) }
    end

    private

    def build_segment(name)
      segment_class_name, args = *registry[name]
      segment_class_name.constantize.new(*args).tap do |segment|
        segment.name = name
      end
    end
  end
end

require 'audience/segment'
require 'audience/segment/base'
require 'audience/segment/all'
require 'audience/segment/none'
require 'audience/segmentable'
require 'audience/railtie' if defined?(Rails)
