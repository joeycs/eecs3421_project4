-- ===================================================================
-- Raccoon Rhapsody Database - EECS 3421N - Project 4
-- Payout Trigger Script
-- April 2019
-- Author: Name - Joseph Emanuele
--         Email - joeycs@my.yorku.ca
--         Student ID - 067599720
-- ===================================================================

--#SET TERMINATOR @

create or replace trigger PayOut
after update of succeeded on Quest
referencing
    old as A
    new as Z
for each row mode db2sql
when ( A.succeeded is null and
       Z.succeeded is not null )
begin atomic
    update (
                select T.loot#, T.realm, T.day, T.theme, T.login,
                (
                    select count(*)
                      from Actor A
                     where A.realm = T.realm and
                           A.day   = T.day and
                           A.theme = T.theme   
                ) as #players
                from Loot T
           ) as L
       set L.login = 
           (
                select login
                  from Actor A
                 where A.realm = L.realm and 
                       A.day   = L.day and
                       A.theme = L.theme
              order by rand() * L.#players
                 limit 1   
            )
     where L.login is null and
           L.#players > 0;
end@