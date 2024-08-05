Realistic Deduction of Heist Loot from Player Bank Accounts 
-

My Discord - https://discord.gg/Q6efb2Pt4W
My Store - https://osmfx.tebex.io

So, I have been working on a more powerful Economy for FiveM RP Servers, and thus I decided to make this very simple script. Realistic Heists is a small plugin (script) that allows you to charge actual players for money made during heists, because ideally people should face consequences for a heist and keeping their money in their banks. 

Features
- 
- Targets both offline and online players
- You can configure - `ratio of amount, people affected, randomization, emails, accounts affected, online vs offline ratio`.
- Has setup to send emails to people to inform about deductions. 
- Deduction amount can be randomized (Ratio based)
- Open Source


[details="Config File"]
```
-- This file is for global settings and configurations

RealisticHeistsConfig = {
    enableDebug = true, -- Enable or disable debug mode
    
    totalAmountRatio = 0.5, -- The ratio of the total amount of money that will be taken from the people

    randomizedDeductionAmount = true, -- Randomize the amount of money that will be taken from the people
    randomizeAmountRatioRange = { -- The range of the random amount of money that will be taken from the people
        min = 0.3,
        max = 0.7,
    },

    enableEmails = true, -- Enable or disable emails
    enableNotifications = true, -- Enable or disable notifications

    moneyAccountsAffected = {
        'bank',
    },

    totalAffectedPeople = {
        max = 20, -- The maximum number of people who will be affected by the heist
        min = 1, -- The minimum number of people who will be affected by the heist
    
        onlinePlayerRatio = 0.5, -- The ratio of online players who will be affected by the heist
        OfflinePlayerRatio = 0.5, -- The ratio of offline players who will be affected by the heist
    
        maxAmountPerPerson = 10000, -- The maximum amount of money that can be taken from a person
    },
}
```
[/details]

> [**DOWNLOAD THE SCRIPT HERE | ITS FREE**](https://osmfx.tebex.io/package/6397544)

It would require you to add a call to the export of my script to integrate your heists and robberies. 
You can read more about that on the download page.

---

If you are looking to make your economy even more realistic and stronger, with people thinking about their financials in the server, you can check my latest release here - 
https://forum.cfx.re/t/qb-loan-management-system-for-streamlined-server-economy-using-organized-debts/5256194

--- 

My Tebex Store for more interesting scripts 
> https://osmfx.tebex.io

**My Most Popular Releases (Based on Sales)**
* AI Police Toggle System to guard your server when no police is active
(https://osmfx.tebex.io/package/5466469)

* NPC Hostages for easy hostages in servers with low player count
(https://osmfx.tebex.io/package/4686650)

**Other Releases**
* Flaregun Airdrops - an exciting feature inspired from EFT and PUBG
(https://osmfx.tebex.io/package/5841576)

* CCTV Cameras - to allow players to watch activity over specific areas
(https://osmfx.tebex.io/package/4901325)

* Garage Valet System - to easily get your cars anywhere on the map with just a click
(https://osmfx.tebex.io/package/4716801)

* Referral Systems for Streamers - rewards for referring and promoting the server
(https://osmfx.tebex.io/package/5097179)
