require 'test_helper'

class DataScopeTest < ActiveSupport::TestCase

  it 'filters correctly with reversed words' do
    phrase = 'Lisp Common'
    skip
  end

  it 'filters correctly with exact match' do
    phrase = '"Thomas Eugene"'
    skip
  end

  it 'filters correctly in different fields' do
    phrase = 'Scripting Microsoft'
    skip
  end

  it 'filters correctly with negative search' do
    phrase = '-array'
    skip
  end

end