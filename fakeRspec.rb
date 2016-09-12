def describe(description, &block)
  ExampleGroup.new(block).evaluate!
end

def expect(object)
  Assertion.new(object)
end

# Well this is definitely wrong
module Matchers
  def eq(other)
    Matcher.new(other, :eq)
  end
end

class ExampleGroup
  include Matchers

  def initialize(block)
    @block = block
  end

  def evaluate!
    instance_eval(&@block)
  end

  def it(description, &block)
    block.call
  end
end

class Assertion
  MATCHERS = {
    :eq => :==
  }

  def initialize(object)
    @object = object
  end

  def to(matcher)
    @object.send(MATCHERS[matcher.method], matcher.other)
  end

  def not_to(matcher)
    !to(matcher)
  end
end

# And this is a pile of rubbish
class Matcher
  attr_reader :other, :method

  def initialize(other, method)
    @other = other
    @method = method
  end
end