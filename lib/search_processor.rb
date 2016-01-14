class SearchProcessor
  WEIGHTS = {exact: 100, words: 1}

  def initialize(phrase)
    @phrase = phrase
    @criteria = init_criteria
  end

  def get_node_weight(source)
    node = source.is_a?(String) ? {str: source} : source
    node_weight = 0

    node.each_value do |v|
      weight = get_string_weight(v) if v
      return nil if weight.nil?
      node_weight += weight
    end
    node_weight == 0 ? nil : node_weight
  end

  private

  def init_criteria
    criteria = {}
    tmp_phrase = ' ' + @phrase.downcase
    # Get exact matches words
    criteria[:exact] = tmp_phrase.scan(/"([^"]+)"/).collect { |v| v.first.downcase }

    # Remove exact matches from the search string
    criteria[:exact].each { |val| tmp_phrase.slice! "\"#{val}\"" }

    # Get exclude words
    criteria[:exclude] = tmp_phrase.scan(/\s\-(\w+)/).collect { |v| v.first.downcase }

    # Remove exclude matches from the search string
    criteria[:exclude].each { |val| tmp_phrase.slice! "-#{val}" }

    # Get rest of words to search by
    # Still space to improve and play with rules, e.g. to exclude/include small words. Refer to business rules
    criteria[:words] = tmp_phrase.scan(/(\w{2,})/).collect { |v| v.first.downcase }

    criteria
  end

  def get_string_weight(str)
    weight = 0
    white_str = " #{str} "

    @criteria[:exclude].each do |val|
      return nil if /\W#{Regexp.escape(val)}\W/i =~ white_str
    end

    @criteria[:exact].each do |val|
      /\W#{Regexp.escape(val)}\W/i =~ white_str ? (weight += WEIGHTS[:exact]) : ''
    end

    # TODO: recheck business logic if we should return nodes ONLY IF ALL words matched
    # if so just add return 0 and update tests here and for exact match above
    @criteria[:words].each do |val|
      /\W#{Regexp.escape(val)}\W/i =~ white_str ? (weight += WEIGHTS[:words]) : ''
    end
    weight
  end
end
