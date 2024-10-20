--## ===============================================================================================
--## ALL REQUIRED IMPORTS
--## ===============================================================================================
-- Libs / Packages
local dialog = LibStub("AceConfigDialog-3.0");
local CombatInterfaceManager = LibStub('AceAddon-3.0'):GetAddon('CombatInterfaceManager');

--## ===============================================================================================
--## INTERNAL VARS & SET UP
--## ===============================================================================================
local Utils = CombatInterfaceManager:NewModule('Utils');

--## ===============================================================================================
--## DEFINING ALL CUSTOM UTILS TO BE USED THROUGHOUT THE ADDON
--## ===============================================================================================
function Utils:Init(cim)
   self.cim = cim;
end

function Utils:HandleConfigOptionsDisplay()
   if (dialog.OpenFrames['CombatInterfaceManager']) then
      self.cim.logger:Print('Hiding the config options window.');
      dialog:Close('CombatInterfaceManager');
   else
      self.cim.logger:Print('Showing the config options window.');
      dialog:Open('CombatInterfaceManager');
   end
end

--## --------------------------------------------------------------------------
--## DATABASE OPERATION FUNCTIONS
--## --------------------------------------------------------------------------
function Utils:GetDbValue(key)
   local value;
   -- the line below does a RegExp `match` for strings that look like 'someTable.someKey'
   local isMultiKey = key:match('%.');

   if (isMultiKey) then
      local key1, key2 = string.match(key, '(.*)%.(.*)');
      value = self.cim.db.profile[key1][key2];
   else
      value = self.cim.db.profile[key];
   end

   self.cim.logger:Debug('GetDbValue: Returning "' .. tostring(value) .. '" for "' .. tostring(key) .. '".');
   return value;
end

function Utils:SetDbTableItem(table, key, value)
   self.cim.logger:Debug(
      'SetDbTableItem: Setting "' ..
         tostring(key) .. '" to "' .. tostring(value) ..
         '" in table "' .. tostring(table) .. '".'
   );

   self.cim.db.profile[table][key] = value;
end

function Utils:SetDbValue(key, value)
   self.cim.logger:Debug(
      'SetDbValue: Setting "' ..
         tostring(key) .. '" to "' .. tostring(value) .. '".'
   );

   self.cim.db.profile[key] = value;
end
