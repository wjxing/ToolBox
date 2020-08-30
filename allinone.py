#!/usr/bin/env python3

import argparse
import os
import sys
import PluginManager
from Tools import Const

sys.dont_write_bytecode = True

sub_tasks = []
Const.SPLIT_CHAR = ","
Const.TASK_NOT_RUN = 0
Const.TASK_RUN_PASS = 1
Const.TASK_RUN_FAIL = 2
Const.DEF_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

def CheckFail(func):
    def wrapper(*args, **kw):
        if not func(*args, **kw):
            print("Func : " + func.__name__ + " process fail")
            exit(1)
        return True
    return wrapper

@CheckFail
def CheckEnv():
    return True

@CheckFail
def CheckParm():

    def FormatUsage():
        usage = PluginManager.Usage()
        fmt = "available TASK is : "
        if usage is None:
            return fmt
        for u in usage:
            fmt += Const.SPLIT_CHAR.join(u) + " "
        return fmt.lstrip()
    parser = argparse.ArgumentParser(description="Setup ToolBox")
    parser.add_argument("-t", dest="task", nargs="*", help=FormatUsage())
    rst = parser.parse_args()
    if rst.task is not None and len(rst.task) >= 1:
        sub_tasks.extend(rst.task)

    return True

@CheckFail
def LoadAllPlugin():
    PluginManager.LoadAllPlugin()
    return True

@CheckFail
def SetupTask():
    for t in sub_tasks:
        actions = t.split(Const.SPLIT_CHAR)
        plugin = PluginManager.GetPluginByName(actions[0])
        if plugin is None:
            print("Not support task : " + actions[0])
            continue
        plugin.ParseCmd(actions[1:] if len(actions) > 1 else None)
    return True

@CheckFail
def RunTask():
    force_run = len(sub_tasks) == 0
    plugins = PluginManager.Model_RepoObj.GetPluginObject()
    waiters = []
    fails = []
    stop = False
    while True:
        for item in plugins:
            ret = item.Run(force_run)
            if ret == Const.TASK_RUN_FAIL:
                stop = True
                fails.append(item.cmdName)
                break
            if ret == Const.TASK_RUN_PASS and not item.block:
                waiters.append(item)
        if stop:
            break
        plugins = PluginManager.Model_ToolObj.GetPluginObject()
        for item in plugins:
            ret = item.Run(force_run)
            if ret == Const.TASK_RUN_FAIL:
                fails.append(item.cmdName)
                continue
            if ret == Const.TASK_RUN_PASS and not item.block:
                waiters.append(item)
        break

    for waiter in waiters:
        ret = waiter.Wait()
        if ret == Const.TASK_RUN_FAIL:
            fails.append(waiter.cmdName)
    for fail in fails:
        print("Task : " + fail + " fails")
    return True

if __name__ == '__main__':
    CheckEnv()
    LoadAllPlugin()
    CheckParm()
    SetupTask()
    RunTask()
