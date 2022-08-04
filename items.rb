class Items
  ALL_ITEMS = []
  attr_accessor :id, :name, :price, :quantity

  def initialize(name, price, quantity)
    @id = set_incremental_id
    @name = name
    @price = price
    @quantity = quantity
    ALL_ITEMS << self
  end

  def set_incremental_id
    (ALL_ITEMS.last&.id || 0) + 1
  end

  def destroy
    ALL_ITEMS.delete(self)
  end
  
  def update(name, price, quantity)
    @name = name
    @price = price
    @quantity = quantity
  end

  def decrement_quantity_by!(count)
    if @quantity >= count
      @quantity -= count
      destroy if @quantity == 0
      return @quantity
    else
      puts "Sorry only #{@quantity} #{name} left.".red
      return nil
    end
  end

  def display
    puts "#{id}-   #{name}   #{price}      #{quantity}"
  end

  class << self
    def create(name, price, quantity)
      new(name, price, quantity)
    end

    def find_by(name)
      all.select { |item| item.name == name }.first
    end

    def all
      ALL_ITEMS
    end

    def clear
      print "\e[2J\e[f"
    end

    def display_all
      if all.empty?
        puts "Vending Machine is empty!!".red      
      else
        puts "Id | Name | Price | Quantity"
        all.each { |item| item.display }
      end
    end
  end
end
