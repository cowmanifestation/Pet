require "pstore"

class Owner
  def initialize
    @pstore = PStore.new("owner_actions.store")
  end

  attr_reader :pstore

  def prompt_for_name
    print "What would you like to name your pet? "
    name = gets.chomp
    name_pet(name)
  end

  def name_pet(name)
    pstore.transaction do
      pstore['name'] = name
    end
  end

  def feed
    pstore.transaction do
      pstore['food'] = true
    end
  end

  def check_pet_health
    pstore.transaction do
      if pstore['health'] == "dead"
        puts "Your pet has died."
        exit
      end
    end
  end

  def reset_health
    pstore['health'] = nil
  end

  def prompt_for_action
    prompt_for_name
    loop do
      print "What would you like to do for your pet? "
      action = gets.chomp
      if action == "feed"
        feed
      end
    end
  end
end

mary = Owner.new
mary.prompt_for_action

Thread.new do
  loop do
    mary.check_pet_health
    sleep 1
  end
end


