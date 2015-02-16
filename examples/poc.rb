require 'dramaturg'

$i = Dramaturg::Script.new
def cmd(s,&b); $i.(s,&b) ; end
at_exit { $i.run_all() }

#ASGARD_URL = $i.hidden_val()

git = cmd("git checkout -b {branch:master}") {
    allow_suffix true
}

$i["git push -u origin {#{git[:branch]}}"]
