# To enable the Tab Auto-Complete in bash
* vi ~/.bashrc
``` bash
function get_todo_commands(){
  if [ -z $2 ] ; then
		COMPREPLY=(`todo2 help -c`)
	else
		COMPREPLY=(`todo2 help -c $2`)
	fi
}
complete -F get_todo_commands todo2
```
		
* PATH=./bin:$PATH

* source ~/.bash

* todo2 &lt;TAB&gt; 
```
  done  help  list  new 
```