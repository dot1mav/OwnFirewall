from script import Script
import os

def clear_firewall() -> None:
    print("Do You Want Clear Your Rules(y/d=n)")
    temp: str = input('> ')
    if temp == 'y':
        print('Are You Sure(Delete filter&nat&mangle(y/d=n)')
        temp: str = input('> ')
        if temp == 'y':
            os.system('iptables -t filter -F')
            os.system('iptables -t nat -F')
            os.system('iptables -t mangle -F')

if __name__ == '__main__':
    st = Script()
    clear_firewall()
    while True:
        print('1.Config Server\n2.Config Client')
        choose: int = int(input('> '))
        if choose == 1:
            st.config_srv()
            break
        elif choose == 2:
            #st.config_clt()
            print('Not Ready Yet/Under Write')
            break
        else:
            print('choose wrong number\n')

    print('make startup this feature')
    st.make_service()
    print('install port scanner blocker(y/n)(default=y)')
    temp: str = input('> ')
    if temp == 'y' or temp is None:
        st.install_def_ps()
    print('install fail2ban(y/n)(default=y)')
    temp: str = input('> ')
    if temp == 'y' or temp is None:
        st.install_fail2ban()
