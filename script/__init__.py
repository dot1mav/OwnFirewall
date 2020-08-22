import os, time


class Script(object):
    __os: str = None

    def __init__(self):
        self.__welcome()
        time.sleep(2)
        print('1.config Srv\n'
              '2.config Client')
        check: int = int(input('#'))
        if check == 1:
            os.system(f'clear')
            os.system(f'bash ConfigSRV.sh')
        elif check == 2:
            os.system(f'clear')
            os.system(f'bash ConfigClient.sh')
        else:
            print(f'wrong number')
            exit(0)

    def __call__(self, *args, **kwargs):
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

    def make_service(self):
        os.system(f'bash MakeStartupFiles.sh')
