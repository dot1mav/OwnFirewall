from script import Script

if __name__ == '__main__':
    st = Script()
    while True:
        print('1.Config Server\n2.Config Client')
        choose: int = int(input('> '))
        if choose == 1:
            st.config_srv()
            break
        elif choose == 2:
            st.config_clt()
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
