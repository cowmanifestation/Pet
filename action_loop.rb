
=begin

pet_type = %w[cat dog bird][rand(3)]
pet_genders = %w[his her]

puts "You have just brought your new #{pet_type} home from the shelter."
sleep 0.5
puts "Please enter #{pet_genders[rand(2)]} name: "
pet_name = gets.chomp
sleep 0.5
=end
require "pstore"

class Pet

  def initialize(name)
    @name    = name
    @counter = 1
    @time_since_fed = 0
    @age = 0
    @pstore = PStore.new("owner_actions.store")
    @weight = 40
    update_health(nil)
  end

  attr_reader :name, :counter, :time_since_fed, :age, :pstore, :weight

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

  def check_for_food
    pstore.transaction do
      if pstore['food'] == true
        if @time_since_fed < 54
          @weight += 5
          @time_since_fed = 0
          pstore['food'] = false
          puts "#{name} has eaten his food."
        else
          @time_since_fed = 0
          pstore['food'] = false
          puts "#{name} is very happy to be fed"
        end
      end
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

  def update_health(health_status)
    pstore.transaction do
      pstore['health'] = health_status
    end
  end

  def weigh
    at_interval(30) do
      puts "#{name}'s weight is #{weight}"
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
        @weight -= 1
        puts "#{name} is very hungry!"
      end
    end
  end

  def die_of_hunger
    if weight < 20 #time_since_fed > 160
      update_health('dead')
      puts "#{name} has died of hunger."
      exit
    end
  end

  def overweight
    if weight > 70
      puts "Your pet has died from being overweight."
      update_health("dead")
      exit
    elsif weight > 55
      puts "Your pet is overweight."
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
      update_health('dead')
      puts "#{name} has died of old age"
      exit
    end
  end

  def next_tick
    puts "."
    sleep 0.2
    @counter += 1
    @time_since_fed += 1
  end

  def come_to_life
    loop do
      @counter += 1
      @time_since_fed += 1

      weigh

      check_for_food

      overweight

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
