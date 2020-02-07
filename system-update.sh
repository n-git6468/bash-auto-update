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

	  #TODO add advanced journalctl interop for dnf update -y. Present actions taken on packages within log in a pleasing & digestible manner.
    #TODO add service ID to logging
	  if [[ $EXITCODE = 0 ]]
    then echo "Daily package update status: success, no updates available." | systemd-cat
	  elif [[ $EXITCODE = 1 ]]
    then echo "Daily package update status: unknown failure, exit code 1." | systemd-cat
	  elif [[ $EXITCODE = 100 ]]
    then dnf update -y
    fi
}

#Call function
auto-update
