class Grammar
  attr_accessor :states

  def initialize
    @states = []
  end

  def rules
    {
      'S' => 'abCefG',
      'C' => 'cd',
      'G' => 'g'
    }
  end

  def is_terminal?(definition)
    definition !~ /[A-Z]/
  end

  def find_definiton(key, position)
    return rules[key][position]
  end

  def find_next(state)
    step = { key: state[:key], position: state[:position] + 1 }
    definition = find_definiton(step[:key], step[:position])

    { definition: definition, state: step }
  end

  def validate(source_code)

    source_code.each_char do |char|
      if @states.empty?
        state = { key: 'S', position: -1 }
      else
        state = @states.last
      end

      if subs_states = state[:subs]
        binding.pry
        last = subs_states.last; while (s = last[:subs]) do  last = s.last end
        has_subs = true
      end


      response = find_next(state)
      d = response[:definition]

      unless d
        state = @states.last
        has_subs = false

        response = find_next(state)
        d = response[:definition]
      end

      if !is_terminal?(d)
        step = { key: d, position: -1 }
        new_response =  find_next(step)

        response[:state][:subs] ||= []
        response[:state][:subs] << new_response[:state]
        d = new_response[:definition]
      end

      if has_subs
        @states.last[:subs] << response[:state]
      else
        @states << response[:state]
      end

      p d
      p @states
    end
  end
end
