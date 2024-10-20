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
   self.optionsFrame = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('CombatInterfaceManager', 'Combat Interface Manager');
end

-- `cim` that's passed in is a reference to CombatInterfaceManager's `self`
function Config:GetBlizzOptionsFrame(cim)
   local db = cim.db.profile;

   return {
      desc = "Select the UI elements you want to hide when you\'re in combat.",
      name = 'Combat Interface Manager (' .. tostring(cim.version) .. ')',
      type = 'group',
      args = {
         uiElements = {
            desc = '',
            name = 'Hide in Combat',
            order = 100,
            type = 'group',
            args = {
               hideChat = {
                  desc = '',
                  get = function()
                     return cim.utils:GetDbValue('isHidingChatFrame');
                  end,
                  name = 'Chat',
                  order = 101,
                  set = function(info, value)
                     cim.utils:SetDbValue('isHidingChatFrame', value);
                  end,
                  type = 'toggle',
               },
               hideMinimap = {
                  desc = '',
                  get = function()
                     return cim.utils:GetDbValue('isHidingMinimap');
                  end,
                  name = 'Minimap',
                  order = 102,
                  set = function(info, value)
                     cim.utils:SetDbValue('isHidingMinimap', value);
                  end,
                  type = 'toggle',
               },
               hideObjectives = {
                  desc = '',
                  get = function()
                     return cim.utils:GetDbValue('isHidingObjectiveTracker');
                  end,
                  name = 'Quest Log',
                  order = 103,
                  set = function(info, value)
                     cim.utils:SetDbValue('isHidingObjectiveTracker', value);
                  end,
                  type = 'toggle',
               },
            }
         }
      },
   }
end
