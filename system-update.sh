#Specify path
PATH=/usr/sbin:/usr/bin:/sbin:/bin
#Synopsis: Execute dnf check-update, capture exit code, based upon exit code, journal success, journal failure, journal success & update.
#TODO log dnf upgrade as one single journalctl entry, currently every dnf STDOUT line is a single journalctl entry.

auto-update() {
	  #EXITCODE = 0 --> Successful execution, no updates available
	  #EXITCODE = 1 --> Unsuccessful execution
	  #EXITCODE = 100 --> Successful execution, updates available
    #See https://dnf.readthedocs.io/en/latest/command_ref.html for additional dnf exit codes
    #Valid log levels -- info, warning, emerg

    #dnf checks for updates
	  dnf check-update
    #exit code is captured
	  local EXITCODE=$?

    #If no packages are available for update, log "...no updates available." to journalctl as 'dnf-cron-update' level info.
	  if [[ $EXITCODE = 0 ]]
    then echo "Daily package update status: success, no updates available." | systemd-cat -t dnf-cron-update -p info
    #If dnf update check fails, log failure to journalctl as 'dnf-cron-update' level warning
	  elif [[ $EXITCODE = 1 ]]
    then echo "Daily package update status: unknown failure, exit code 1." | systemd-cat -t dnf-cron-update -p warning
    #If package updates are available, log actions to journalctl as 'dnf-cron-update' level info
	  elif [[ $EXITCODE = 100 ]]
    then dnf update -y | systemd-cat -t dnf-cron-update -p info
    fi
}

#Call function
auto-update
