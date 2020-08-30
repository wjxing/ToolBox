#!/usr/bin/env python3

import os
import sys
import importlib
import threading
from Tools import Const
sys.dont_write_bytecode = True

class PluginManager(type):
    __PluginPath = 'Plugins'

    def __init__(cls, name, bases, d):
        if not hasattr(cls, 'AllPlugins'):
            cls.__AllPlugins = {}
        else:
            cls.RegisterAllPlugin(cls)

    @staticmethod
    def SetPluginPath(path):
        if os.path.isdir(path):
            PluginManager.__PluginPath = path
        else:
            print('%s is not a valid path' % path)

    @staticmethod
    def LoadAllPlugin():
        pluginPath = PluginManager.__PluginPath
        if not os.path.isdir(pluginPath):
            raise EnvironmentError('%s is not a directory' % pluginPath)

        items = os.listdir(pluginPath)
        for item in items:
            if os.path.isdir(os.path.join(pluginPath, item)):
                PluginManager.__PluginPath = os.path.join(pluginPath, item)
                PluginManager.LoadAllPlugin()
            else:
                if item.endswith('.py') and item != '__init__.py':
                    moduleName = item[:-3]
                    modulePath = pluginPath.replace("/", ".") + "." + moduleName
                    importlib.import_module(modulePath)

    @property
    def AllPlugins(self):
        return self.__AllPlugins

    def RegisterAllPlugin(self, aPlugin):
        #pluginName = '.'.join([aPlugin.__module__, aPlugin.__name__])
        pluginObj = aPlugin()
        pluginName = pluginObj.cmdName
        self.__AllPlugins[pluginName] = pluginObj

    def UnregisterPlugin(self, pluginName):
        if pluginName in self.__AllPlugins:
            pluginObj = self.__AllPlugins[pluginName]
            del pluginObj

    def GetPluginObject(self, pluginName = None):
        if pluginName is None:
            return self.__AllPlugins.values()
        else:
            return self.__AllPlugins[pluginName] if pluginName in self.__AllPlugins else None

    @staticmethod
    def GetPluginByName(pluginName):
        if pluginName is not None:
            for SingleModel in __ALLMODEL__:
                plugin = SingleModel.GetPluginObject(pluginName)
                if plugin is not None:
                    return plugin
        return None

class Model_ToolObj_Thread(threading.Thread):
    def __init__(self, plugin, force):
        threading.Thread.__init__(self)
        self._plugin = plugin
        self._force = force
        self._ret = True

    def run(self):
        if self._plugin._doBuild or self._force:
            self._ret = Const.TASK_RUN_PASS if self._plugin.Build() else Const.TASK_RUN_FAIL
            if self._ret == Const.TASK_RUN_FAIL:
                return
        if self._plugin._doInstall or self._force:
            self._ret = Const.TASK_RUN_PASS if self._plugin.Install() else Const.TASK_RUN_FAIL

class Model_ToolObj(metaclass=PluginManager):

    def __init__(self, cmdName, block=False):
        self._cmdName = cmdName
        self._block = block
        self._doBuild = False
        self._doInstall = False
        self._thread = None

    def Build(self):
        pass

    def Install(self):
        pass

    def ParseCmd(self, cmd):
        if cmd is None:
            self._doBuild = True
            self._doInstall = True
            return
        for c in cmd:
            if c == "b":
                self._doBuild = True
            elif c == "i":
                self._doInstall = True
            else:
                print("Not recognized cmd " + c + " in " + self._cmdName)

    def Run(self, force = False):
        # Fast return
        if not (self._doBuild or self._doInstall or force):
            return Const.TASK_NOT_RUN
        if self._block:
            if self._doBuild or force:
                ret = self.Build()
                if not ret:
                    return Const.TASK_RUN_FAIL
            if self._doInstall or force:
                ret = self.Install()
                if not ret:
                    return Const.TASK_RUN_FAIL
        else:
            self._thread = Model_ToolObj_Thread(self, force)
            self._thread.start()
        return Const.TASK_RUN_PASS

    def Wait(self):
        if not self._block:
            self._thread.join()
            return self._thread._ret
        return Const.TASK_NOT_RUN

    def Usage(self):
        usage = (self.cmdName, "b[build]", "i[install]")
        return usage

    @property
    def cmdName(self):
        return self._cmdName

    @property
    def block(self):
        return self._block

class Model_RepoObj_Thread(threading.Thread):
    def __init__(self, plugin, force):
        threading.Thread.__init__(self)
        self._plugin = plugin
        self._force = force
        self._ret = True

    def run(self):
        if self._plugin._doInit or self._force:
            self._ret = Const.TASK_RUN_PASS if self._plugin.Init() else Const.TASK_RUN_FAIL
            if self._ret == Const.TASK_RUN_FAIL:
                return
        if self._plugin._doDL or self._force:
            self._ret = Const.TASK_RUN_PASS if self._plugin.Download() else Const.TASK_RUN_FAIL

class Model_RepoObj(metaclass=PluginManager):

    def __init__(self, cmdName, block=True):
        self._cmdName = cmdName
        self._block = block
        self._doInit = False
        self._doDL = False
        self._thread = None

    def Init(self):
        pass

    def Download(self):
        pass

    def ParseCmd(self, cmd):
        if cmd is None:
            self._doInit = True
            self._doDL = True
            return
        for c in cmd:
            if c == "i":
                self._doInit = True
            elif c == "d":
                self._doDL = True
            else:
                print("Not recognized cmd " + c + " in " + self._cmdName)

    def Run(self, force = False):
        # Fast return
        if not (self._doInit or self._doDL or force):
            return Const.TASK_NOT_RUN
        if self._block:
            if self._doInit or force:
                ret = self.Init()
                if not ret:
                    return Const.TASK_RUN_FAIL
            if self._doDL or force:
                ret = self.Download()
                if not ret:
                    return Const.TASK_RUN_FAIL
        else:
            self._thread = Model_ToolObj_Thread(self, force)
            self._thread.start()
        return Const.TASK_RUN_PASS

    def Wait(self):
        if not self._block:
            self._thread.join()
            return self._thread._ret
        return Const.TASK_NOT_RUN

    @property
    def cmdName(self):
        return self._cmdName

    @property
    def block(self):
        return self._block

    def Usage(self):
        usage = (self.cmdName, "i[init]", "d[download]")
        return usage

def LoadAllPlugin():
    PluginManager.LoadAllPlugin()

def GetPluginByName(pluginName):
    return PluginManager.GetPluginByName(pluginName)

def Usage():
    usage = []
    for model in __ALLMODEL__:
        for item in model.GetPluginObject():
            usage.append(item.Usage())
    return usage

__ALLMODEL__ = (Model_ToolObj, Model_RepoObj)
