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
   self.db = LibStub('AceDB-3.0'):New('CombatInterfaceManagerDB', { profile = {} }, true);

   -- calling all modules! all modules to the front! (keep in this order)
   self.chalk = self:GetModule('Chalk');
   -- self.dump = self:GetModule('Dump');
   -- self.inspecty = self:GetModule('Inspecty');
   self.utils = self:GetModule('Utils');
   self.config = self:GetModule('Config');
   self.logger = self:GetModule('Logger');

   -- do you init or not bro?!
   self.config:Init(self);
   self.logger:Init(self);
   self.utils:Init(self);

   -- we're slashing prices so much it's like we're crazy!
   self:RegisterChatCommand('cim', 'SlashCommandInfoConfig');
end
