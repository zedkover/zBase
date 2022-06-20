Locales['nl'] = {
    -- Inventory
    ['inventory'] = 'inventory %s / %s',
    ['use'] = 'gebruik',
    ['give'] = 'geef',
    ['remove'] = 'gooi',
    ['return'] = 'return',
    ['give_to'] = 'geef aan',
    ['amount'] = 'hoeveelheid',
    ['giveammo'] = 'geef ammo',
    ['amountammo'] = 'amount of ammo',
    ['noammo'] = 'je hebt niet genoeg ammo!',
    ['gave_item'] = 'je gaf ~y~%sx~s~ ~b~%s~s~ aan ~y~%s~s~',
    ['received_item'] = 'je ontving ~y~%sx~s~ ~b~%s~s~ van ~b~%s~s~',
    ['gave_weapon'] = 'je gaf ~b~%s~s~ aan ~y~%s~s~',
    ['gave_weapon_ammo'] = 'je gaf ~o~%sx %s~s~ voor ~b~%s~s~ aan ~y~%s~s~',
    ['gave_weapon_withammo'] = 'je gaf ~b~%s~s~ met ~o~%sx %s~s~ aan ~y~%s~s~',
    ['gave_weapon_hasalready'] = '~y~%s~s~ heeft reeds een ~y~%s~s~',
    ['gave_weapon_noweapon'] = '~y~%s~s~ heeft dat wapen nog niet',
    ['received_weapon'] = 'je ontving ~b~%s~s~ van ~b~%s~s~',
    ['received_weapon_ammo'] = 'je ontving ~o~%sx %s~s~ voor jouw ~b~%s~s~ van ~b~%s~s~',
    ['received_weapon_withammo'] = 'je ontving ~b~%s~s~ met ~o~%sx %s~s~ van ~b~%s~s~',
    ['received_weapon_hasalready'] = '~b~%s~s~ probeerde jou een ~y~%s~s~, maar je hebt er reeds een',
    ['received_weapon_noweapon'] = '~b~%s~s~ probeerde jou ammo te geven voor ~y~%s~s~, maar je hebt deze niet',
    ['gave_account_money'] = 'je gaf ~b~$%s~s~ (%s) aan ~y~%s~s~',
    ['received_account_money'] = 'je ontving ~b~$%s~s~ (%s) van ~b~%s~s~',
    ['amount_invalid'] = 'incorrecte hoeveelheid',
    ['players_nearby'] = 'geen spelers dichtbij',
    ['ex_inv_lim'] = 'actie niet mogelijk, inventory limiet te groot voor ~y~%s~s~',
    ['imp_invalid_quantity'] = 'actie niet mogelijk, foutieve hoeveelheid',
    ['imp_invalid_amount'] = 'actie niet mogelijk, incorrecte hoeveelheid',
    ['threw_standard'] = 'je gooide ~y~%sx~s~ ~b~%s~s~',
    ['threw_account'] = 'je gooide ~b~$%s~s~ ~b~%s~s~',
    ['threw_weapon'] = 'je gooide ~b~%s~s~',
    ['threw_weapon_ammo'] = 'je gooide ~b~%s~s~ met ~o~%sx %s~s~',
    ['threw_weapon_already'] = 'je draagt reeds dit wapen',
    ['threw_cannot_pickup'] = 'je kan dit niet oppakken omdat je inventory al volzit',
    ['threw_pickup_prompt'] = 'druk op ~y~E~s~ om op te pakken',
    ['standard_pickup_prompt'] = '~y~E:~s~ Oppakken',
  
    -- Key mapping
    ['keymap_showinventory'] = 'toon Inventory',
  
    -- Salary related
    ['received_salary'] = 'je ontving je salaris: ~b~$%s~s~',
    ['received_help'] = 'you ontving je WW: ~b~$%s~s~',
    ['company_nomoney'] = 'het bedrijf waar je werkt heeft geen geld om je uit te betalen',
    ['received_paycheck'] = 'ontving betaling',
    ['bank'] = 'maze Bank',
    ['account_bank'] = 'bank',
    ['account_black_money'] = 'zwart Geld',
    ['account_money'] = 'cash',
  
    ['act_imp'] = 'actie niet mogelijk',
    ['in_vehicle'] = 'je kan niks geven aan iemand in een voertuig',
  
    -- Commands
    ['command_car'] = 'spawn een voertuig',
    ['command_car_car'] = 'voertuig spawn naam of hash',
    ['command_cardel'] = 'verwijder voertuig dichtbij',
    ['command_cardel_radius'] = 'optioneel, verwijder alle voertuigen binnen een radius',
    ['command_clear'] = 'leeg chat',
    ['command_clearall'] = 'leeg chat voor alle spelers',
    ['command_clearinventory'] = 'verwijder speler inventory',
    ['command_clearloadout'] = 'verwijder speler loadout',
    ['command_giveaccountmoney'] = 'geef account geld',
    ['command_giveaccountmoney_account'] = 'valid account name',
    ['command_giveaccountmoney_amount'] = 'hoeveelheid toe te voegen',
    ['command_giveaccountmoney_invalid'] = 'foutieve account naam',
    ['command_giveitem'] = 'geef een item aan een speler',
    ['command_giveitem_item'] = 'item naam',
    ['command_giveitem_count'] = 'item hoeveelheid',
    ['command_giveweapon'] = 'geef een wapen aan een speler',
    ['command_giveweapon_weapon'] = 'wapen_naam',
    ['command_giveweapon_ammo'] = 'ammunitie_hoeveelheid',
    ['command_giveweapon_hasalready'] = 'speler heeft reeds dit wapen',
    ['command_giveweaponcomponent'] = 'geef wapen component',
    ['command_giveweaponcomponent_component'] = 'component naam',
    ['command_giveweaponcomponent_invalid'] = 'foutieve wapen component',
    ['command_giveweaponcomponent_hasalready'] = 'speler heeft reeds wapen component',
    ['command_giveweaponcomponent_missingweapon'] = 'speler heeft niet dit weapon',
    ['command_save'] = 'sla een speler op naar de database',
    ['command_saveall'] = 'sla alle speler op naar de database',
    ['command_setaccountmoney'] = 'zet account geld voor een speler',
    ['command_setaccountmoney_amount'] = 'hoeveel geld om te zetten',
    ['command_setcoords'] = 'teleport naar coordinaten',
    ['command_setcoords_x'] = 'x axis',
    ['command_setcoords_y'] = 'y axis',
    ['command_setcoords_z'] = 'z axis',
    ['command_setjob'] = 'zet job voor een speler',
    ['command_setjob_job'] = 'job naam',
    ['command_setjob_grade'] = 'job groep',
    ['command_setjob_invalid'] = 'de job, groep of beide zijn incorrect',
    ['command_setgroup'] = 'zet spelers groep',
    ['command_setgroup_group'] = 'group naam',
    ['commanderror_argumentmismatch'] = 'argument kloppen niet (meegegeven %s, verwacht %s)',
    ['commanderror_argumentmismatch_number'] = 'argument #%s type klopt niet (meegegeven string, verwacht number)',
    ['commanderror_invaliditem'] = 'ongeldige itemnaam',
    ['commanderror_invalidweapon'] = 'ongeldig wapen',
    ['commanderror_console'] = 'die opdracht kan niet worden uitgevoerd vanaf de console',
    ['commanderror_invalidcommand'] = '^3%s^0 is niet een correct commando!',
    ['commanderror_invalidplayerid'] = 'er is geen speler online die overeenkomt met die server id',
    ['commandgeneric_playerid'] = 'speler id',
  
    -- Locale settings
    ['locale_digit_grouping_symbol'] = ',',
    ['locale_currency'] = '$%s',
  
    -- Weapons
    ['weapon_knife'] = 'mes',
    ['weapon_nightstick'] = 'gummistok',
    ['weapon_hammer'] = 'hamer',
    ['weapon_bat'] = 'knuppel',
    ['weapon_golfclub'] = 'golf club',
    ['weapon_crowbar'] = 'koevoet',
    ['weapon_pistol'] = 'pistool',
    ['weapon_combatpistol'] = 'gevechts pistool',
    ['weapon_appistol'] = 'AP pistool',
    ['weapon_pistol50'] = 'pistool .50',
    ['weapon_microsmg'] = 'micro SMG',
    ['weapon_smg'] = 'SMG',
    ['weapon_assaultsmg'] = 'aanvals SMG',
    ['weapon_assaultrifle'] = 'aanvals geweer',
    ['weapon_carbinerifle'] = 'karabijn geweer',
    ['weapon_advancedrifle'] = 'geavanceerde geweer',
    ['weapon_mg'] = 'MG',
    ['weapon_combatmg'] = 'combat MG',
    ['weapon_pumpshotgun'] = 'pomp jachtgeweer',
    ['weapon_sawnoffshotgun'] = 'afgezaagd jachtgeweer',
    ['weapon_assaultshotgun'] = 'aanvals jachtgeweer',
    ['weapon_bullpupshotgun'] = 'bullpup shotgun',
    ['weapon_stungun'] = 'tazer',
    ['weapon_sniperrifle'] = 'sluipschutters geweer',
    ['weapon_heavysniper'] = 'zware sluipschutter',
    ['weapon_grenadelauncher'] = 'granaatwerper',
    ['weapon_rpg'] = 'raketwerper',
    ['weapon_minigun'] = 'minigun',
    ['weapon_grenade'] = 'granaat',
    ['weapon_stickybomb'] = 'kleverige bom',
    ['weapon_smokegrenade'] = 'rook granaat',
    ['weapon_bzgas'] = 'bz gas',
    ['weapon_molotov'] = 'molotov cocktail',
    ['weapon_fireextinguisher'] = 'brand blusser',
    ['weapon_petrolcan'] = 'jerrycan',
    ['weapon_ball'] = 'bal',
    ['weapon_snspistol'] = 'sns pistol',
    ['weapon_bottle'] = 'fles',
    ['weapon_gusenberg'] = 'gusenberg sweeper',
    ['weapon_specialcarbine'] = 'special carbine',
    ['weapon_heavypistol'] = 'heavy pistol',
    ['weapon_bullpuprifle'] = 'bullpup rifle',
    ['weapon_dagger'] = 'dagger',
    ['weapon_vintagepistol'] = 'vintage pistol',
    ['weapon_firework'] = 'vuurwerk',
    ['weapon_musket'] = 'musket',
    ['weapon_heavyshotgun'] = 'heavy shotgun',
    ['weapon_marksmanrifle'] = 'marksman rifle',
    ['weapon_hominglauncher'] = 'homing launcher',
    ['weapon_proxmine'] = 'proximity mine',
    ['weapon_snowball'] = 'sneeuw bal',
    ['weapon_flaregun'] = 'flarepistool',
    ['weapon_combatpdw'] = 'combat pdw',
    ['weapon_marksmanpistol'] = 'marksman pistol',
    ['weapon_knuckle'] = 'knuckledusters',
    ['weapon_hatchet'] = 'bijl',
    ['weapon_railgun'] = 'railgun',
    ['weapon_machete'] = 'machete',
    ['weapon_machinepistol'] = 'machine pistol',
    ['weapon_switchblade'] = 'switchblade',
    ['weapon_revolver'] = 'heavy revolver',
    ['weapon_dbshotgun'] = 'double barrel shotgun',
    ['weapon_compactrifle'] = 'compact rifle',
    ['weapon_autoshotgun'] = 'auto shotgun',
    ['weapon_battleaxe'] = 'battle axe',
    ['weapon_compactlauncher'] = 'compact launcher',
    ['weapon_minismg'] = 'mini smg',
    ['weapon_pipebomb'] = 'pipe bomb',
    ['weapon_poolcue'] = 'pool cue',
    ['weapon_wrench'] = 'pipe wrench',
    ['weapon_flashlight'] = 'flashlight',
    ['gadget_parachute'] = 'parachute',
    ['weapon_flare'] = 'flare gun',
    ['weapon_doubleaction'] = 'double-Action Revolver',
    ['weapon_pistol_mk2'] = 'pistol Mk2',
    ['weapon_smg_mk2'] = 'SMG Mk2',
    ['weapon_assaultrifle_mk2'] = "assault rifle Mk2",
    ['weapon_carbinerifle_mk2'] = 'carbine rifle Mk2',
    ['weapon_combatmg_mk2'] = 'combat MG Mk2',
    ['weapon_pumpshotgun_mk2'] = 'pump shotgun mk2',
    ['weapon_heavysniper_mk2'] = 'heavy sniper Mk2',
    ['weapon_snspistol_mk2'] = 'sns pistol Mk2',
    ['weapon_specialcarbine_mk2'] = 'special carbine Mk2',
    ['weapon_bullpuprifle_mk2'] = 'bullpup rifle Mk2',
    ['weapon_marksmanrifle_mk2'] = 'marksman rifle Mk2',
    ['weapon_revolver_mk2'] = 'heavy revolver Mk2',
  
    -- Weapon Components
    ['component_clip_default']      = 'default Clip',
    ['component_clip_extended']     = 'extended Clip',
    ['component_clip_drum']         = 'drum Magazine',
    ['component_clip_box']          = 'box Magazine',
  
    -- Flashlight
    ['component_flashlight']        = 'flashlight',
    
    -- Scopes
    ['component_scope']             = 'Scope',
    ['component_scope_small']       = 'Small Scope',
    ['component_scope_macro']       = 'Macro Scope',
    ['component_scope_medium']      = 'Medium Scope',
    ['component_scope_mounted']     = 'Mounted Scope',
    ['component_scope_advanced']    = 'Advanced Scope',
    ['component_scope_zoom']        = 'Extended Scope',
    ['component_scope_large']       = 'Large Scope',
    ['component_scope_nightvison']  = 'Nightvision Scope',
    ['component_scope_thermal']     = 'Thermal Scope',
  
    -- Barrels / Suppressors
    ['component_barrel']            = 'Barrel',
    ['component_barrel_heavy']      = 'Heavy Barrel',
    ['component_suppressor']        = 'Suppressor',
    ['component_compensator']       = 'Compensator',
    
    -- Grips
    ['component_grip']              = 'grip',
  
    -- Muzzles
    ['component_muzzle_flat']       = 'Flat Muzzle Brake',
    ['component_muzzle_tatical']    = 'Tactical Muzzle Brake',
    ['component_muzzle_fat']        = 'Fat-End Muzzle Brake',
    ['component_muzzle_precision']  = 'Precision Muzzle Brake',
    ['component_muzzle_heavy']      = 'Heavy Duty Muzzle Brake',
    ['component_muzzle_slanted']    = 'Slanted Muzzle Brake',
    ['component_muzzle_split']      = 'Split-End Muzzle Brake',
    ['component_muzzle_squared']    = 'Square Muzzle Brake',
    ['component_muzzle_bellend']    = 'Bell-End Muzzle Brake',
  
    -- Weapon Skins
    ['component_skin_camo']         = 'Digital Camo',
    ['component_skin_brushstroke']  = 'Brushstroke Camo',
    ['component_skin_woodland']     = 'Woodland Camo',
    ['component_skin_skull']        = 'Skull',
    ['component_skin_sessanta']     = 'Sessanta Nove',
    ['component_skin_perseus']      = 'Perseus',
    ['component_skin_leopard']      = 'Leopard',
    ['component_skin_zebra']        = 'Zebra',
    ['component_skin_geometric']    = 'Geometric',
    ['component_skin_boom']         = 'Boom!',
    ['component_skin_patriotic']    = 'Patriotic',
    ['component_luxary_finish']     = 'Luxary',
    
    -- Weapon Ammo
    ['ammo_rounds'] = 'round(s)',
    ['ammo_shells'] = 'shell(s)',
    ['ammo_charge'] = 'charge',
    ['ammo_petrol'] = 'gallons of fuel',
    ['ammo_firework'] = 'vuurwerk(s)',
    ['ammo_rockets'] = 'raket(ten)',
    ['ammo_grenadelauncher'] = 'granate(n)',
    ['ammo_grenade'] = 'granaten(s)',
    ['ammo_stickybomb'] = 'bom(men)',
    ['ammo_pipebomb'] = 'bom(men)',
    ['ammo_smokebomb'] = 'bom(men)',
    ['ammo_molotov'] = 'cocktail(s)',
    ['ammo_proxmine'] = 'mijn(en)',
    ['ammo_bzgas'] = 'can(s)',
    ['ammo_ball'] = 'bal(len)',
    ['ammo_snowball'] = 'sneeuwbal(len)',
    ['ammo_flare'] = 'flare(s)',
    ['ammo_flaregun'] = 'flare(s)',
  
    -- Weapon Tints
    ['tint_default'] = 'standaard skin',
    ['tint_green'] = 'groene skin',
    ['tint_gold'] = 'gouden skin',
    ['tint_pink'] = 'roze skin',
    ['tint_army'] = 'militair skin',
    ['tint_lspd'] = 'blauwe skin',
    ['tint_orange'] = 'oranje skin',
    ['tint_platinum'] = 'platinum skin',
  }