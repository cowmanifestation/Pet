require "pstore"

pstore = PStore.new("x.store")

pstore.transaction do
  puts "What is the secret?"
  pstore['foo'] = gets.chomp
end


require 'pstore'

pstore = PStore.new("x.store")

loop do
  pstore.transaction do
    if pstore['foo'] == 'bar'
      puts "YAY!"
      exit
    end
  end
end

