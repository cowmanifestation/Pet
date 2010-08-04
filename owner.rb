require "pstore"

class Owner
  def initialize
    @pstore = PStore.new("owner_actions.store")
  end

  attr_reader :pstore

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
Thread.new do
  loop do
    mary.check_pet_health
    sleep 1
  end
end

mary.prompt_for_action

