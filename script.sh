#!/bin/bash

#if [ -n "$2" ]
#then
#var_first_name=($2)
#else
#var_first_name=(John)
#fi

#if [ -n "$3" ]
#then
#var_last_name=($3)
#else
#var_last_name=(Doe)
#fi


cp -f $1 output.yml
var_first_name='John'
var_last_name='Doe'
while [ -n "$2" ]
do
   case "$2" in
	-F)
		
		  if [ -n "$3" ] && [ "$3" != '-L' ]
		  then
		     var_first_name="$3"
	   	     shift 2
		  else
		     var_first_name=(John)
		     shift
		  fi		
		echo "F" $var_first_name
		;;	
   	-L) 
		var_last_name="$3"
		echo "L" $var_last_name
        	shift
		break;;
		
   	esac		
done	

sed -ri 's/^(\s*)(hostname\s*:\s*\{*hostname\}*\s*$)/\1hostname: '"$HOSTNAME"'/' output.yml
sed -ri 's/^(\s*)(ip\s*:\s*\{*ip\}*\s*$)/\1ip: '"$(hostname -I)"'/' output.yml
sed -ri 's/^(\s*)(date\s*:\s*\{*current_date\}*\s*$)/\1date: '"$(date '+%F %T')"'/' output.yml
sed -ri 's|^(\s*)(home_folder\s*:\s*\{*home_folder\}*\s*$)|\1home_folder: '"$HOME"'|' output.yml
sed -ri 's|^(\s*)(username\s*:\s*\{*username\}*\s*$)|\1username: '"$USER"'|' output.yml
sed -ri 's/^(\s*)(first_name\s*:\s*\{*first_name\}*\s*$)/\1first_name: '"$var_first_name"'/' output.yml
sed -ri 's/^(\s*)(last_name\s*:\s*\{*last_name\}*\s*$)/\1last_name: '"$var_last_name"'/' output.yml
