from PluginManager import Model_RepoObj
import Tools
from Tools import Const

class Update_vim(Model_RepoObj):
    def __init__(self):
        super().__init__("update_vim")

    def Init(self):
        print("Init : " + self.cmdName)
        return Tools.CmderBlock("make -C " + Const.DEF_ROOT + " -f setup/Scripts/Mak/modules/" + self.cmdName + ".mk TOOLBOX_HOME=" + Const.DEF_ROOT + " init")

    def Download(self):
        print("Download : " + self.cmdName)
        return Tools.CmderBlock("make -C " + Const.DEF_ROOT + " -f setup/Scripts/Mak/modules/" + self.cmdName + ".mk TOOLBOX_HOME=" + Const.DEF_ROOT + " download")