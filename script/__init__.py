import os


class Script(object):
    __os: str = None

    def __init__(self):
        os.system(f'bash ConfigSRV.sh')

    def __call__(self, *args, **kwargs):
        pass

    def make_service(self):
        os.system(f'bash MakeStartupFiles.sh')
