require 'search_processor'

class DataScope
  def self.filter(phrase)
    search = SearchProcessor.new(phrase)
    results = []

    # Go through nodes and keep only ones with some weight
    datas.select do |node|
      weight = search.get_node_weight(node)
      next if weight.nil?
      node_dup = node.dup
      node_dup[:weight] = weight
      results << node_dup
    end
    results.sort_by { |val| -val[:weight] }
  end

  # Add reload function if there will be a need to reload data
  def self.datas
    @@datas ||= read_datas
  end

  # For a testing purpose now
  def self.datas=(data)
    @@datas = data
  end

  def self.read_datas
    file = File.read(Rails.root.join('db', 'data.json'))
    JSON.parse file
  end
  private_class_method :read_datas
end
