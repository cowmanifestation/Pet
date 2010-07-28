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

  def explore_house
    if counter == 10
      puts "#{name} explores the house."
    end
  end

  def yawn
    if counter % 24 == 0
      puts "#{name} yawns"
    end
  end

  def stretch
    if counter % 26 == 0
      puts "#{name} stretches"
    end
  end

  def pee
    if counter % 40 == 0
      unless time_since_fed > 80
        puts "#{name} pees"
      end
    end
  end

  def poop
    if counter % 50 == 0
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
    if time_since_fed > 90 && counter % 8 == 0
      puts "#{name} is very hungry!"
    end
  end

  def die_of_hunger
    if time_since_fed > 160
      puts "#{name} has died of hunger."
      break
    end
  end

  def birthday
    if counter % 600 == 0
      pet_age += 1
      puts "#{pet_name} is now #{age} years old"
    end
  end

  def die_of_old_age
    if counter == 6000
      puts "#{name} has died of old age"
      break
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
