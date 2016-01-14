require 'test_helper'
require 'search_processor'

class SearchProcessorTest < ActiveSupport::TestCase

  let (:sp) { SearchProcessor.new('single word "exact match" -exclude and something else Niklaus "Delphi"') }

  it 'returns correct weight for a single word' do
    node = 'sample single match'
    assert_equal SearchProcessor::WEIGHTS[:words], sp.get_node_weight(node)
  end

  it 'returns correct weight for an exact match' do
    node = 'simple sing for exact match'
    assert_equal SearchProcessor::WEIGHTS[:exact], sp.get_node_weight(node)
  end

  it 'returns nil for exclude search' do
    node = 'simple sing work for exact match but some exclude'
    assert_equal nil, sp.get_node_weight(node)
  end

  it 'returns correct weight for a hash string' do
    node = {
        "Name": "Delphi",
        "Type": "Compiled, Object-oriented class-based, Reflective",
        "Designed by": "Apple, Niklaus Wirth, Anders Hejlsberg"
    }
    assert_equal SearchProcessor::WEIGHTS[:exact] + SearchProcessor::WEIGHTS[:words], sp.get_node_weight(node)
  end
end