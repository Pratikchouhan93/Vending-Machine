require_relative 'menu_work'
include MenuWork

#Welcome messages prints here
def welcome_screen
  puts ""
  puts "===================================================================".center(144)
  puts "!! Welcome to our Vending Machine !!".center(144)
  puts "===================================================================".center(144) 
end

public
def price_by_selection(selection)
  case selection
    when 1
      return 20
    when 2
      return 20
    when 3
      return 10
    when 4
      return 10
    when 5
      return 5
  end 
end

def get_quantity(selection)
  puts "How much?(maximum: 5)"
  quantity = gets.chomp.to_i

  if quantity <= 5
    price = price_by_selection(selection)
    max_amount = quantity * price
    puts "Total Rupees You Pay: #{max_amount}"
  else
    puts "Please enter valid quantity."
  end
end

def cancel_method
  puts "Enter 1 to continue or 2 to cancel."
  cancel = gets.chomp.to_i

  if cancel.eql? 1
    get_quantity(selection)
  elsif cancel.eql? 2
    puts "Your order cancelled"
    puts "========= Thank You! ========="
    exit!
  else
    puts "Please enter valid input..."
    cancel_method
  end
end

class VendingMachine                         #Main Class Vending Machine
  def self.clear
    print "\e[2J\e[f"
  end

  def start
    welcome_screen
    selection = menus        #Module Method
    VendingMachine.clear
    menu_choosen(selection)  #Module Method
    cancel_method
  end
end

start_vending_machine = VendingMachine.new   #VendingMachine class object
start_vending_machine.start                  ##All methods Call Here

