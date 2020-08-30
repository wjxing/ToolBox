from PluginManager import Model_ToolObj
import Tools
from Tools import Const

class Setup_bd(Model_ToolObj):
    def __init__(self):
        super().__init__("setup_vim")

    def Build(self):
        print("Build : " + self.cmdName)
        return Tools.CmderBlock("make -C " + Const.DEF_ROOT + " -f setup/Scripts/Mak/modules/" + self.cmdName + ".mk TOOLBOX_HOME=" + Const.DEF_ROOT + " build")

    def Install(self):
        print("Install : " + self.cmdName)
        return Tools.CmderBlock("make -C " + Const.DEF_ROOT + " -f setup/Scripts/Mak/modules/" + self.cmdName + ".mk TOOLBOX_HOME=" + Const.DEF_ROOT + " install")
