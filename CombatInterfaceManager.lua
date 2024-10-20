--## ===============================================================================================
--## ALL REQUIRED IMPORTS
--## ===============================================================================================
-- Libs / Packages
local CombatInterfaceManager = LibStub('AceAddon-3.0'):NewAddon('CombatInterfaceManager', 'AceConsole-3.0', 'AceEvent-3.0');

--## ===============================================================================================
--## START UP & GREETING SCRIPTS
--## ===============================================================================================

function CombatInterfaceManager:OnInitialize()
   self.version = C_AddOns.GetAddOnMetadata('combat-interface-manager', 'Version'); -- this pulls the version number from the TOC file
   self.db = LibStub('AceDB-3.0'):New('CombatInterfaceManagerDB', { profile = CIM_Defaults }, true);

   -- calling all modules! all modules to the front! (keep in this order)
   self.chalk = self:GetModule('Chalk');
   -- self.dump = self:GetModule('Dump');
   -- self.inspecty = self:GetModule('Inspecty');
   self.utils = self:GetModule('Utils');
   self.config = self:GetModule('Config');
   self.logger = self:GetModule('Logger');

   -- do you init or not bro?! (keep in this order)
   self.config:Init(self);
   self.utils:Init(self);
   self.logger:Init(self);

   -- we're slashing prices so much it's like we're crazy!
   self:RegisterChatCommand('cim', 'SlashCommandInfoConfig');
end

function CombatInterfaceManager:OnEnable()
   self:RegisterChatFramesListener();
   self:RegisterMinimapListener();
   self:RegisterObjectiveTrackerListener();
end

function CombatInterfaceManager:RegisterChatFramesListener()
   -- TODO **[G]** :: Add some verbose debug logging here
   local numChatFrames = FCF_GetNumActiveChatFrames();

   -- not sure what this incoming `self` is, but keeping for ref
   local function ToggleChatFrames(_self, event)
      if (self.db.profile.isHidingChatFrame) then
         for i = 1, numChatFrames, 1 do
            -- TODO **[G]** :: do something extra about the "voice" tab/chat frame that exists
            local chatFrame = _G['ChatFrame' .. i];

            if (event == 'PLAYER_REGEN_DISABLED') then
               -- TODO **[G]** :: wrap this under debug and/or verbose logging
               -- self.logger:Print(self.chalk:warn("YOU'RE IN COMBAT!!! Hiding chat frame..."));
               chatFrame:Hide();  -- Hide on entering combat
            elseif (event == 'PLAYER_REGEN_ENABLED') then
               -- TODO **[G]** :: wrap this under debug and/or verbose logging
               -- self.logger:Print(self.chalk:info("You're out of combat. Showing chat frame..."));
               chatFrame:Show();  -- Show on exiting combat
            end
         end
      end
   end

   local f = CreateFrame("Frame");
   f:RegisterEvent('PLAYER_REGEN_DISABLED');  -- Event for entering combat
   f:RegisterEvent('PLAYER_REGEN_ENABLED');   -- Event for leaving combat
   f:SetScript("OnEvent", ToggleChatFrames);
end

function CombatInterfaceManager:RegisterMinimapListener()
   -- TODO **[G]** :: Add some verbose debug logging here
   local mapFrame = Minimap;

   -- not sure what this incoming `self` is, but keeping for ref
   local function ToggleMinimap(_self, event)
      if (self.db.profile.isHidingMinimap) then
         if (event == 'PLAYER_REGEN_DISABLED') then
            -- TODO **[G]** :: wrap this under debug and/or verbose logging
            -- self.logger:Print(self.chalk:warn("YOU'RE IN COMBAT!!! Hiding objective tracker..."));
            mapFrame:Hide();  -- Hide on entering combat
         elseif (event == 'PLAYER_REGEN_ENABLED') then
            -- TODO **[G]** :: wrap this under debug and/or verbose logging
            -- self.logger:Print(self.chalk:info("You're out of combat. Showing objective tracker..."));
            mapFrame:Show();  -- Show on exiting combat
         end
      end
   end

   local f = CreateFrame("Frame");
   f:RegisterEvent('PLAYER_REGEN_DISABLED');  -- Event for entering combat
   f:RegisterEvent('PLAYER_REGEN_ENABLED');   -- Event for leaving combat
   f:SetScript("OnEvent", ToggleMinimap);
end

function CombatInterfaceManager:RegisterObjectiveTrackerListener()
   -- TODO **[G]** :: Add some verbose debug logging here
   local questFrame = ObjectiveTrackerFrame;

   -- not sure what this incoming `self` is, but keeping for ref
   local function ToggleObjectiveTracker(_self, event)
      if (self.db.profile.isHidingObjectiveTracker) then
         if (event == 'PLAYER_REGEN_DISABLED') then
            -- TODO **[G]** :: wrap this under debug and/or verbose logging
            -- self.logger:Print(self.chalk:warn("YOU'RE IN COMBAT!!! Hiding objective tracker..."));
            questFrame:Hide();  -- Hide on entering combat
         elseif (event == 'PLAYER_REGEN_ENABLED') then
            -- TODO **[G]** :: wrap this under debug and/or verbose logging
            -- self.logger:Print(self.chalk:info("You're out of combat. Showing objective tracker..."));
            questFrame:Show();  -- Show on exiting combat
         end
      end
   end

   local f = CreateFrame("Frame");
   f:RegisterEvent('PLAYER_REGEN_DISABLED');  -- Event for entering combat
   f:RegisterEvent('PLAYER_REGEN_ENABLED');   -- Event for leaving combat
   f:SetScript("OnEvent", ToggleObjectiveTracker);
end
