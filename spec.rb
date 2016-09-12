require 'test/unit'
require './fakeRspec'

class TestDescribe < Test::Unit::TestCase
  def test_it_can_pass
    describe 'some passing test' do
    end
  end

  def test_it_can_fail
    assert_raises(StandardError) do
      describe 'some error test' do
        it 'raises an error' do
          raise StandardError
        end
      end
    end
  end
end