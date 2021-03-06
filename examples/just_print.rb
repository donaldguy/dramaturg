require 'dramaturg'

$i = Dramaturg::Script.new({
  prompter: {
    class: Dramaturg::Prompter::UseDefaults
  },
  runner: {
    class: Dramaturg::Runner::Print
  },
})

git = $i.cmd("git checkout -b {branch:master}")
  .name('new branch')
  .fail_ok(true)

$i["git push -u origin {#{git[:branch]}}"]

$i["echo 'all up to date'"]

$i.run_all
