import os
import time


class Script(object):

    def __init__(self) -> None:
        self.__check_install()
        self.__welcome()
        time.sleep(2)
        if not (os.path.isdir('/root/.ownfirewall')):
            os.mkdir('/root/.ownfirewall')
        os.system('cp Save.sh /root/.ownfirewall')
        os.system('cp Restore.sh /root/.ownfirewall')
        with open('/root/.ownfirewall/.config', 'w') as fl:
            fl.write('1')
            fl.close()

    def __check_install(self) -> None:
        if os.path.isfile("/root/.ownfirewall/.config"):
            print('you installed the script')
            exit(0)

    def __unistall(self) -> None:
        answer: chr = input("Do you want unistall OwnFirewall (y=Yes/n=No/default=y): ")
        if answer.lower() == 'y' or answer is None:
            os.system(f'rm -rf /root/.ownfirewall')
            os.system(f'rm /etc/init.d/fw')
            os.system(f'rm /etc/.iptables.save')

    def make_service(self) -> None:
        print('..........................................................\n'
              + '.............Configuration System And Startup.............\n'
              + '.........................................................')
        os.system(f'bash MakeStartupFiles.sh')

    def config_srv(self) -> None:
        os.system(f'bash scripts/ConfigSRV.sh')

    def config_clt(self) -> None:
        os.system(f'bash scripts/ConfigClient.sh')

    def install_def_ps(self) -> None:
        os.system(f'bash scripts/PortScanner.sh')

    def install_fail2ban(self) -> None:
        os.system(f'bash scripts/f2b.sh')

    def __welcome(self) -> None:
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
