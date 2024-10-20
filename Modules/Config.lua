--## ==========================================================================
--## ALL REQUIRED IMPORTS
--## ==========================================================================
-- Libs / Packages
local CombatInterfaceManager = LibStub('AceAddon-3.0'):GetAddon('CombatInterfaceManager');

--## ===============================================================================================
--## INTERNAL VARS & SET UP
--## ===============================================================================================
local Config = CombatInterfaceManager:NewModule('Config');

--## ==========================================================================
--## DEFINING THE MAIN OPTIONS FRAME
--## ==========================================================================
-- `cim` is a passed in reference of CombatInterfaceManager's `self`
function Config:Init(cim)
   LibStub('AceConfig-3.0'):RegisterOptionsTable('CombatInterfaceManager', self:GetBlizzOptionsFrame(cim));
   self.optionsFrame = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('CombatInterfaceManager', 'Mark Item As');
end

-- `cim` that's passed in is a reference to CombatInterfaceManager's `self`
function Config:GetBlizzOptionsFrame(cim)
   local db = cim.db.profile;

   return {
      desc = '',
   }
end
