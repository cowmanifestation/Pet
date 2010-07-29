=begin

pet_type = %w[cat dog bird][rand(3)]
pet_genders = %w[his her]

puts "You have just brought your new #{pet_type} home from the shelter."
sleep 0.5
puts "Please enter #{pet_genders[rand(2)]} name: "
pet_name = gets.chomp
sleep 0.5
=end

class Pet
  def initialize(name)
    @name    = name
    @counter = 1
    @time_since_fed = 0
    @age = 0
  end

  attr_reader :name, :counter, :time_since_fed, :age

  def at_count(num)
    yield if counter == num
  end

  def at_interval(int)
    yield if counter % int == 0
  end

  def explore_house
    at_count(10) do
      puts "#{name} explores the house."
    end
  end

  def feed
    if File.exist?("FOOD")
      @time_since_fed = 0
      File.unlink("FOOD")
      puts "#{name} is very happy to be fed"
    end
  end

  def yawn
    at_interval(24) do
      puts "#{name} yawns"
    end
  end

  def stretch
    at_interval(26) do
      puts "#{name} stretches"
    end
  end

  def pee
    at_interval(40) do
      unless time_since_fed > 80
        puts "#{name} pees"
      end
    end
  end

  def poop
    at_interval(50) do
      unless time_since_fed > 100
        puts "#{name} poops"
      end
    end
  end

  def express_hunger
    if time_since_fed == 56 || time_since_fed == 76
      puts "#{name} is hungry."
    end
  end

  def express_extreme_hunger
    at_interval(8) do
      if time_since_fed > 90
        puts "#{name} is very hungry!"
      end
    end
  end

  def die_of_hunger
    if time_since_fed > 160
      puts "#{name} has died of hunger."
      exit
    end
  end

  def birthday
    at_interval(600) do
      @age += 1
      puts "#{name} is now #{age} years old"
    end
  end

  def die_of_old_age
    at_count(3000) do
      puts "#{name} has died of old age"
      exit
    end
  end

  def next_tick
    puts "."
    sleep 0.1
    @counter += 1
    @time_since_fed += 1
  end

  def come_to_life
    loop do
      @counter += 1
      @time_since_fed += 1
      feed

      explore_house

      yawn

      stretch

      pee

      poop

      express_hunger

      express_extreme_hunger
      
      die_of_hunger

      birthday

      die_of_old_age

      next_tick
    end
  end
end

pet = Pet.new("Jesus")
pet.come_to_life
