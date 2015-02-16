require 'dramaturg'

$i = Dramaturg::Script.new()
at_exit { $i.run_all() }

puts "secretly saving to ls.out"
$i['ls -{l}']
  .save_to_file('ls.out')

$i["cat ls.out"]
$i["rm ls.out"]
