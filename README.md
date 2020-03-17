# bash-auto-update

**Synopsis** -- This script executes dnf check-update, capture exit code, based upon exit code, journal success, journal failure, journal success & update.  
**Usage**    -- Place this script within /etc/cron.daily, /etc/cron.hourly, /etc/cron.monthly, etc. Whichever location you place this script into, make sure that you update the logging output when dnf package updates are not available. Alternatively, a cronjob can be manually created with this bash script.
