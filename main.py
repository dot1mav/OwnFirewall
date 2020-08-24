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
