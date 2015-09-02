class HumanPlayer
  attr_reader :color
  
  def initialize(color)
    @color = color
  end

  # Reads keypresses from the user including 2 and 3 escape character sequences.
  def self.read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end
  ensure
    STDIN.echo = true
    STDIN.cooked!

    return input
  end

  def self.get_key(cursor_pos)
    c = read_char
    new_pos = cursor_pos.dup
    case c
    when "\e[A"
      # "UP ARROW"
      new_pos[0] -= 1
    when "\e[B"
      # "DOWN ARROW"
      new_pos[0] += 1
    when "\e[C"
      # "RIGHT ARROW"
      new_pos[1] += 1
    when "\e[D"
      # "LEFT ARROW"
      new_pos[1] -= 1
    when "\r"
      new_pos = false
    when "\e"
      Kernel.abort
    end
    new_pos
  end
end
