import os
import time


class Script(object):

    def __init__(self):
        self.__welcome()
        time.sleep(2)
        if not (os.path.isdir('/root/.ownfirewall')):
            os.mkdir('/root/.ownfirewall')
        os.system('cp Save.sh /root/.ownfirewall')
        os.system('cp Restore.sh /root/.ownfirewall')
        with open('/root/.ownfirewall/.config', 'w') as fl:
            fl.write('1')
            fl.close()

    def make_service(self):
        os.system(f'bash MakeStartupFiles.sh')

    def config_srv(self):
        os.system(f'bash ConfigSRV.sh')

    def config_clt(self):
        os.system(f'bash ConfigClient.sh')

    def install_def_ps(self):
        os.system(f'bash PortScanner.sh')

    def install_fail2ban(self):
        pass

    def __welcome(self):
        print("...........................................\n\
    ...........................................\n\
    ...........................................\n\
    ...............Config Linux................\n\
    .................4 Srv/Clt.................\n\
    ...........................................\n\
    ...........................................\n\
    ................By dot1mav.................\n\
    ...........................................\n\
    ...........................................\n\
    ...........................................")
