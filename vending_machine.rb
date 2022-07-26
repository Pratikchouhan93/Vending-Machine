puts ""
puts "===================================================================".center(144)
puts "!! Welcome to our Vending Machine !!".center(144)
puts "===================================================================".center(144)

def menu
menu = {
  "101":'Coca Cola',
  "102":'Sprite',
  "103":'Pepsi',
  "104":'Fanta',
  "105":'Lays'
}
menu.each { |key, value| puts "\t#{key}: #{value}" }
puts "\tPress 0 = Quit."
end

menu


# puts menu.keys
# puts menu.values

