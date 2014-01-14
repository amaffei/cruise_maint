# make_archive_configs.awk
# This awk script composes elogd.cfg configs for archived eventlogs
# arguments used in execution of elogd for one years worth of logbooks:
# /usr/local/sbin/elogd -x -p 8010 -s /shipdata/archive/2010/elog -d /shipdata/archive/2010/elog/logbooks -c /shipdata/archive/2010/elog/elogd.cfg
# -s /shipdata/archive/YYYY/elog (elogd subdir)
# -d /shipdata/archive/YYYY/elog/logbooks (logbook subdir)
# -c /shipdata/archive/YYYY/elog/elogd.cfg (config file)
# -p 80YY (port_)
#
# Reading CSV file with all logbooks for cruises in it
