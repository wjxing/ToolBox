import subprocess

def CmderBlock(cmder):
    ret = subprocess.run(cmder, shell=True)
    return ret.returncode == 0

def CmderNonBlock(cmder):
    return subprocess.Popen(cmder, shell=True)