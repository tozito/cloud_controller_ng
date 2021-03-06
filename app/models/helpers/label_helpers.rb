module VCAP::CloudController
  class LabelHelpers
    KEY_SEPARATOR = '/'.freeze
    REQUIREMENT_SPLITTER = /(?:\(.*?\)|[^,])+/.freeze
    KEY_CHARACTERS = %r{[\w\-\.\_\/]+}.freeze

    IN_PATTERN = /\A(?<key>.*?) in \((?<values>.*)\)\z/.freeze                     # foo in (bar,baz)
    NOT_IN_PATTERN = /\A(?<key>.*?) notin \((?<values>.*)\)\z/.freeze              # funky notin (uptown,downtown)
    EQUAL_PATTERN = /\A(?<key>#{KEY_CHARACTERS})(==?)(?<values>.*)\z/.freeze       # foo=bar or foo==bar
    NOT_EQUAL_PATTERN = /\A(?<key>#{KEY_CHARACTERS})(!=)(?<values>.*)\z/.freeze    # foo!=bar
    EXISTS_PATTERN = /^\A(?<key>#{KEY_CHARACTERS})(?<values>)\z/.freeze            # foo
    NOT_EXISTS_PATTERN = /\A!(?<key>#{KEY_CHARACTERS})(?<values>)\z/.freeze        # !foo

    REQUIREMENT_OPERATOR_PAIRS = [
      { pattern: IN_PATTERN, operator: :in },
      { pattern: NOT_IN_PATTERN, operator: :notin },
      { pattern: EQUAL_PATTERN, operator: :equal },
      { pattern: NOT_EQUAL_PATTERN, operator: :not_equal },
      { pattern: EXISTS_PATTERN, operator: :exists }, # foo
      { pattern: NOT_EXISTS_PATTERN, operator: :not_exists },
    ].freeze

    class << self
      def extract_prefix(label_key)
        return [nil, label_key] unless label_key.include?(KEY_SEPARATOR)

        prefix, name = label_key.split(KEY_SEPARATOR)
        name ||= ''
        [prefix, name]
      end
    end
  end
end
