# /etc/monit/conf.d/viral.lautan-luas.com

check process nexjtjs-viral.lautan-luas.com matching "start -p 3001"
    start program = "/usr/bin/systemctl start viral.lautan-luas.com.service"
    stop  program = "/usr/bin/systemctl stop viral.lautan-luas.com.service"

    # Resource guards
    if cpu > 70% for 3 cycles then restart
    if totalmem > 2048 MB for 3 cycles then restart

    group nodejs-apps
