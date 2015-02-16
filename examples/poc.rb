require 'dramaturg'

$i = Dramaturg::Script.new
def cmd(s,&b); $i.(s,&b) ; end
at_exit { $i.run_all() }

git = cmd("git checkout -b {branch:master}")
  .name('new branch')
  .fail_ok(true)

$i["git push -u origin {#{git[:branch]}}"]
