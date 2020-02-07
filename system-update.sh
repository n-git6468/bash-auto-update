#Specify path
PATH=/usr/sbin:/usr/bin:/sbin:/bin

#A simple function
#Synopsis: Execute dnf check-update, capture exit code, based upon exit code, journal success, journal failure, journal success & update.

auto-update() {
	#Check for updates, capture exit code.
	#EXITCODE = 0 --> Successful execution, no updates available
	#EXITCODE = 1 --> Unsuccessful execution
	#EXITCODE = 100 --> Successful execution, updates available
	dnf check-update
	local EXITCODE=$?

	#Used for testing
	echo $EXITCODE

	#TODO add basic journalctl interop success & unknown failure conditions
	#TODO add advanced journalctl interop for dnf update -y. Present actions taken on packages within log in a pleasing & digestible manner.
	if [[ $EXITCODE = 0 ]]
		then echo "Daily update status: success, no updates available." >> systemd-cat
	elif [[ $EXITCODE = 1 ]]
		then echo "Uknown failure, exit code 1."
	elif [[ $EXITCODE = 100 ]]
		#TODO add dnf update -y
		then echo "dnf update -y"
	fi
}

auto-update
