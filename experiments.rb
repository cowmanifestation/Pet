class LoopBreaker
  def break_loop
    loop do
      return "Do something."
    end
  end
end

l = LoopBreaker.new
l.break_loop
