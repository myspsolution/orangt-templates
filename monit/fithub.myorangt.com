# /etc/monit/conf.d/fithub.myorangt.com

check process fithub.myorangt.com matching "start -p 3001"
    start program = "/usr/bin/su - orangt -c '/usr/bin/systemctl --user start fithub.myorangt.com.service'"
    stop  program = "/usr/bin/sudo /usr/bin/systemctl stop fithub.myorangt.com.service"

    # Resource guards
    if cpu > 70% for 3 cycles then restart
    if totalmem > 2048 MB for 3 cycles then restart

    group nodejs-apps
