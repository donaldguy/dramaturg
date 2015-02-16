require 'dramaturg'

$i = Dramaturg::Script.new()
at_exit { $i.run_all() }

$GREETING = $i.masked_value("hello")

$i["echo {$GREETING} {world}"]
