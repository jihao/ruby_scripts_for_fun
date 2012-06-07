# To enable the Tab Auto-Complete in bash
* vi ~/.bashrc
``` bash
function get_todo_commands(){
  if [ -z $2 ] ; then
		COMPREPLY=(`todo help -c`)
	else
		COMPREPLY=(`todo help -c $2`)
	fi
}
complete -F get_todo_commands todo
```
		
* PATH=./bin:$PATH

* source ~/.bash

* todo &lt;TAB&gt; 
```
  done  help  list  new 
```

# Man page for ruby powered tools (be helpful)
* gem install gem-man ronn
  * [gem-man](http:/defunkt.io/gem-man/) is a plug-in to RubyGems created by GitHub’s Chris Wanstrath, allows users to access man pages bundled inside a gem via the gem man command.
  * [ronn](http:/rtomayko.github.com/ronn/) is a Ruby app that allows us to create man pages in plain text, without having to learn nroff.

* mkdir man 
* touch man/db_backup.1.ronn
* ronn man/db_backup.1.ronn
* man man/db_backup.1

  **!!! not successful, output format not OK**
  