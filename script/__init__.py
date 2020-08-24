import os
import time


class Script(object):

    def __init__(self):
        self.__welcome()
        time.sleep(2)

    def __call__(self, *args, **kwargs):
        pass

    def make_service(self):
        os.system(f'bash MakeStartupFiles.sh')

    def config_srv(self):
        os.system(f'bash ConfigSRV.sh')

    def config_clt(self):
        os.system(f'bash ConfigClient.sh')

    def install_def_ps(self):
        os.system(f'bash PortScanner.sh')

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



