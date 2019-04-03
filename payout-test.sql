-- ===================================================================
-- Raccoon Rhapsody Database - EECS 3421N - Project 4
-- Update Script for Testing Payout Trigger
-- April 2019
-- Author: Name - Joseph Emanuele
--         Email - joeycs@my.yorku.ca
--         Student ID - 067599720
-- ===================================================================

-- querying quests that succeeded at '23:59:59'; returns no records
  select L.loot#, L.treasure, L.login
    from Loot L, Quest Q
   where L.theme = Q.theme and
         L.realm = Q.realm and
         L.day = Q.day and
         Q.succeeded = '23:59:59'
order by L.loot#, L.treasure, L.login;

-- setting all unsuccessful quests to be successful at '23:59:59'
update Quest Q
   set succeeded = '23:59:59'  
 where Q.succeeded is null;
-- update to Quest table triggers PayOut to distribute loot 
-- of these quests to random Actors

-- now returns loot that was randomly distributed
  select L.loot#, L.treasure, L.login
    from Loot L, Quest Q
   where L.theme = Q.theme and
         L.realm = Q.realm and
         L.day = Q.day and
         Q.succeeded = '23:59:59'
order by L.loot#, L.treasure, L.login;