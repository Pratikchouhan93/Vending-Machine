require 'colorize'
module MenuWork
  def menus                                  #Show all menus to the user
    puts "\t-----Menu-----\n".light_blue.bold
    menu = {
      "1":'Coca Cola',
      "2":'Sprite',
      "3":'Pepsi',
      "4":'Fanta',
      "5":'Lays'
    }
    menu.each { |key, value| puts "\t#{key}: #{value}".green }

    puts "\tPress 0 to quit.\n\n".red

    puts "Please enter your selection: "
    selection = gets.chomp.to_i
    if selection >= 0 && selection <= 5
      return selection  #Module Method
    else
      VendingMachine.clear
      puts "Please Enter Valid Number....\n\n"
      menus
    end
  end

  def menu_choosen(selection)                  #After selection show output:
    price = VendingMachine.price_by_selection(selection)
    case selection
      when 1
        puts "You have selected Coca Cola of #{price} rupees.\n\n"
      when 2
        puts "You have selected Sprite of #{price} rupees.\n\n"
      when 3
        puts "You have selected Pepsi of #{price} rupees.\n\n"
      when 4
        puts "You have selected Fanta of #{price} rupees.\n\n"
      when 5
        puts "You have selected Lays of #{price} rupees.\n\n"
      when 0
        puts "========= Thank You! =========".center(144)
        exit!
      # else
      #   puts "Please Enter Valid Number...."
      end 
  end
end