require 'dramaturg'

$i = Dramaturg::Script.new({
    #we want to run in order - without this 'new branch' will run first
    #cause of its output is used in next command; I might make ~promises later
    run_previous_on_declare: true
})
def cmd(s,&b); $i.(s,&b) ; end

#there are several supported syntaxes; this varies between them for
#demonstration purposes

$i.("git status ")

$i["git commit {-v}"]
  .name("commit")

git = cmd("git checkout -b {branch:master}") do
  name 'new branch'
  fail_ok true
end

$i.cmd("git push -u origin {#{git[:branch]}}")
  .run #unfortunately we still need to run the last manually with :run_previous_on_declare
