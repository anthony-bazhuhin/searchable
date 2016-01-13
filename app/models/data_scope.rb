class DataScope

  def self.filter(phrase)
    search = SearchProcessor.new(phrase)
    results = []

    datas.select do |node|
      node[:weight] = search.get_node_weight(node)
      results << node if node[:weight]
    end
    results.sort_by { |val| -val[:weight] }
  end

  # Add reload function if there will be a need to reload data
  def self.datas
    @@datas ||= read_datas
  end

  private

  def self.read_datas
    file = File.read(Rails.root.join('db', 'data.json'))
    JSON.parse file
  end
end