require 'test_helper'

class DataScopeTest < ActiveSupport::TestCase

  before do
    file = File.read(Rails.root.join('test', 'fixtures', 'data.json'))
    DataScope.datas = JSON.parse file
  end

  it 'filters correctly with reversed words' do
    phrase = 'Lisp Common'
    expected = ['Common Lisp', 'Lisp']
    assert DataScope.filter(phrase).all? { |h| expected.include? h['Name'] }
  end

  it 'filters correctly with exact match' do
    phrase = '"Thomas Eugene"'
    expected = ['BASIC']
    assert DataScope.filter(phrase).all? { |h| expected.include? h['Name'] }
  end

  it 'filters correctly in different fields' do
    phrase = 'Scripting Microsoft'
    expected = ['JScript', 'VBScript', 'Windows PowerShell']
    assert DataScope.filter(phrase).any? { |h| expected.include? h['Name'] }
  end

  it 'filters correctly with negative search' do
    phrase = 'john -array'
    expected = ['BASIC', 'Haskell', 'Lisp', 'S-Lang']
    assert DataScope.filter(phrase).all? { |h| expected.include? h['Name'] }
  end

end