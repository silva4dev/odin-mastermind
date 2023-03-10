class Mastermind
  COLORS = %w[red blue green yellow purple orange]

  def initialize
    @code = generate_code
    @turns_left = 12
  end

  def play
    puts "Welcome to Mastermind!"
    puts "The code consists of four colors: #{COLORS.join(", ")}"
    puts "You have 12 turns to guess the code."

    while @turns_left > 0
      guess = get_guess
      feedback = give_feedback(guess)
      print_feedback(feedback)

      if guess == @code
        puts "Congratulations! You guessed the code!"
        return
      end

      @turns_left -= 1
    end

    puts "Sorry, you didn't guess the code. The code was #{@code.join(", ")}."
  end

  private

  def generate_code
    Array.new(4) { COLORS.sample }
  end

  def get_guess
    puts "Enter your guess:"
    gets.chomp.split
  end

  def give_feedback(guess)
    feedback = []
    remaining_code = @code.dup
    guess.each_with_index do |color, index|
      if color == @code[index]
        feedback << "black"
        remaining_code.delete_at(remaining_code.index(color))
      end
    end
    guess.each_with_index do |color, index|
      next if color == @code[index]
      if remaining_code.include?(color)
        feedback << "white"
        remaining_code.delete_at(remaining_code.index(color))
      end
    end
    feedback
  end

  def print_feedback(feedback)
    if feedback.empty?
      puts "No colors are correct."
    else
      puts "Feedback: #{feedback.join(", ")}"
    end
  end
end
