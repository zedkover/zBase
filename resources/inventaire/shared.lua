Shared = {}

Shared.prefix = "zedkover:"

Shared.Locale = "fr"
Shared.IncludeCash = true
Shared.IncludeAccounts = true
Shared.ExcludeAccountsList = {"bank", "money"}
Shared.OpenControl = 289

Shared.CloseUiItems = {
    "carteidentite",
    "permis",
    "carte",
}

Shared.Blacklistitem = {
    ["gps"] = true,
    ["phone"] = true,
    ["white_phone"] = true,
    ['hei_prop_yah_table_01'] = true,
    ['hei_prop_yah_table_03'] = true,
    ['prop_chateau_table_01'] = true,
    ['prop_patio_lounger1_table'] = true,
    ['prop_proxy_chateau_table'] = true,
    ['prop_rub_table_02'] = true,
    ['prop_rub_table_01'] = true,
    ['prop_table_01'] = true,
    ['prop_table_02'] = true,
    ['prop_table_03'] = true,
    ['prop_table_04'] = true,
    ['prop_table_05'] = true,
    ['prop_table_06'] = true,
    ['prop_table_07'] = true,
    ['prop_table_08'] = true,
    ['prop_ven_market_table1'] = true,
    ['prop_yacht_table_01'] = true,
    ['prop_yacht_table_02'] = true,
    ['v_ret_fh_dinetable'] = true,
    ['v_ret_fh_dinetble'] = true,
    ['v_res_mconsoletrad'] = true,
    ['prop_rub_table_02'] = true,
    ['ba_prop_int_trad_table'] = true,
    ['xm_prop_x17_desk_cover_01a'] = true,
    ['xm_prop_lab_desk_02'] = true,
    ['xm_prop_lab_desk_01'] = true,
    ['ex_mp_h_din_table_05'] = true,
    ['hei_prop_yah_table_02'] = true,
    ['prop_ld_farm_table02'] = true,
    ['prop_t_coffe_table'] = true,
    ['prop_t_coffe_table_02'] = true,
    ['prop_ld_greenscreen_01'] = true,
    ['prop_tv_cam_02'] = true,
    ['p_pharm_unit_02'] = true,
    ['p_pharm_unit_01'] = true,
    ['p_v_43_safe_s'] = true,
    ['prop_bin_03a'] = true,
    ['prop_bin_07c'] = true,
    ['prop_bin_08open'] = true,
    ['prop_bin_10a'] = true,
    ['prop_devin_box_01'] = true,
    ['prop_ld_int_safe_01'] = true,
    ['prop_dress_disp_01'] = true,
    ['prop_dress_disp_02'] = true,
    ['prop_dress_disp_03'] = true,
    ['prop_dress_disp_04'] = true,
    ['v_ret_fh_displayc'] = true,
    ['apa_mp_h_bed_double_08'] = true,
    ['apa_mp_h_bed_double_09'] = true,
    ['apa_mp_h_bed_wide_05'] = true,
    ['imp_prop_impexp_sofabed_01a'] = true,
    ['apa_mp_h_bed_with_table_02'] = true,
    ['bka_prop_biker_campbed_01'] = true,
    ['apa_mp_h_yacht_bed_01'] = true,
    ['apa_mp_h_yacht_bed_02'] = true,
    ['p_lestersbed_s'] = true,
    ['p_mbbed_s'] = true,
    ['v_res_d_bed'] = true,
    ['v_res_tre_bed2'] = true,
    ['v_res_tre_bed1'] = true,
    ['v_res_mdbed'] = true,
    ['v_res_msonbed'] = true,
    ['v_res_tt_bed'] = true,
    ['prop_barrier_work05'] = true,
    ['prop_boxpile_07d'] = true,
    ['p_ld_stinger_s'] = true,
    ['prop_roadcone02a'] = true,
    ['hei_prop_yah_lounger'] = true,
    ['hei_prop_yah_seat_01'] = true,
    ['hei_prop_yah_seat_02'] = true,
    ['hei_prop_yah_seat_03'] = true,
    ['miss_rub_couch_01'] = true,
    ['p_armchair_01_s'] = true,
    ['p_ilev_p_easychair_s'] = true,
    ['p_lev_sofa_s'] = true,
    ['p_patio_lounger1_s'] = true,
    ['p_res_sofa_l_s'] = true,
    ['p_v_med_p_sofa_s'] = true,
    ['prop_bench_01a'] = true,
    ['prop_bench_06'] = true,
    ['prop_ld_farm_chair01'] = true,
    ['prop_ld_farm_couch01'] = true,
    ['prop_ld_farm_couch02'] = true,
    ['prop_rub_couch04'] = true,
    ['prop_t_sofa'] = true,
    ['prop_t_sofa_02'] = true,
    ['v_ilev_m_sofa'] = true,
    ['v_res_tre_sofa_s'] = true,
    ['v_tre_sofa_mess_a_s'] = true,
    ['v_tre_sofa_mess_b_s'] = true,
    ['v_tre_sofa_mess_c_s'] = true,
    ['bkr_prop_duffel_bag_01a'] = true,
    ['v_med_emptybed'] = true,
    ['v_med_cor_emblmtable'] = true,
    ['v_ret_gc_bag01'] = true,
    ['xm_prop_body_bag'] = true,
    ['prop_chair_01a'] = true,
    ['prop_chair_01b'] = true,
    ['prop_chair_02'] = true,
    ['prop_chair_03'] = true,
    ['prop_chair_04'] = true,
    ['prop_chair_05'] = true,
    ['prop_chair_06'] = true,
    ['prop_chair_07'] = true,
    ['prop_chair_08'] = true,
    ['prop_chair_09'] = true,
    ['prop_chair_10'] = true,
    ['apa_mp_h_din_chair_04'] = true,
    ['apa_mp_h_din_chair_08'] = true,
    ['apa_mp_h_din_chair_09'] = true,
    ['apa_mp_h_din_chair_12'] = true,
    ['apa_mp_h_stn_chairarm_01'] = true,
    ['apa_mp_h_stn_chairarm_02'] = true,
    ['apa_mp_h_stn_chairarm_09'] = true,
    ['apa_mp_h_stn_chairarm_11'] = true,
    ['apa_mp_h_stn_chairarm_12'] = true,
    ['apa_mp_h_stn_chairarm_13'] = true,
    ['apa_mp_h_stn_chairarm_23'] = true,
    ['apa_mp_h_stn_chairarm_24'] = true,
    ['apa_mp_h_stn_chairarm_25'] = true,
    ['apa_mp_h_stn_chairarm_26'] = true,
    ['apa_mp_h_stn_chairstrip_08'] = true,
    ['apa_mp_h_stn_chairstrip_04'] = true,
    ['apa_mp_h_stn_chairstrip_05'] = true,
    ['apa_mp_h_stn_chairstrip_06'] = true,
    ['apa_mp_h_yacht_armchair_03'] = true,
    ['apa_mp_h_yacht_armchair_04'] = true,
    ['ba_prop_battle_club_chair_02'] = true,
    ['apa_mp_h_yacht_strip_chair_01'] = true,
    ['ba_prop_battle_club_chair_01'] = true,
    ['ba_prop_battle_club_chair_03'] = true,
    ['bka_prop_biker_boardchair01'] = true,
    ['bka_prop_biker_chairstrip_01'] = true,
    ['bka_prop_biker_chairstrip_02'] = true
}

Shared.header = { -- banniere pare shop
    ["Lunettes"] = "Magasin de lunettes",
    ["Masque"] = "Magasin de masque",
    ["Chapeau"] = "Magasin de Chapeau",
    ["Sac"] = "Magasin de sac",
    ["Oreille"] = "Magasin de Accessoires d'oreille",
    ["T-shirt"] = "Magasin de T-shirt",
    ["Pantalon"] = "Magasin de Pantalon",
    ["Chaussures"] = "Magasin de Chaussures",
    ["Torse"] = "Magasin de Torse",
    ["Gants"] = "Magasin de Gants",
    ["Calques"] = "Magasin de Calques",
    ["Chaines"] = "Magasin de Chaines",
    ["Main"] = "Magasin principale"
}

Shared.price = { -- le prix pare shop
    ["Lunettes"] = 15, --[$]
    ["Masque"] = 45, --[$]
    ["Chapeau"] = 25, --[$]
    ["Sac"] = 25,  --[$]
    ["Oreille"] = 10, --[$]
    ["T-shirt"] = 15, --[$]
    ["Pantalon"] = 20, --[$]
    ["Chaussures"] = 25, --[$]
    ["Torse"] = 45, --[$]
    ["Gants"] = 5, --[$]
    ["Calques"] = 2, --[$]
    ["Chaines"] = 10, --[$]
}
 
Shared.shops = { -- pas oublier la , + il faut mettre le shop que tu veux utiliser
    {pos = vector3(-1192.98, -768.41, 16.40), shop = "Main", color = {r=200, g=118, b=51}},
    {pos = vector3(425.16, -806.21, 28.59), shop = "Main", color = {r=200, g=118, b=51}},
    {pos = vector3(-163.26, -303.28, 38.80), shop = "Main", color = {r=200, g=118, b=51}},
    {pos = vector3(125.81, -222.77, 53.70), shop = "Main", color = {r=200, g=118, b=51}},
    {pos = vector3(-822.15, -1073.76, 10.35), shop = "Main", color = {r=200, g=118, b=51}},
    {pos = vector3(75.75, -1392.93, 28.45), shop = "Main", color = {r=200, g=118, b=51}},
    {pos = vector3(1693.58, 4822.76, 41.20), shop = "Main", color = {r=200, g=118, b=51}},
    {pos = vector3(1196.58, 2709.97, 37.30), shop = "Main", color = {r=200, g=118, b=51}},
    {pos = vector3(4.67, 6512.49, 30.95), shop = "Main", color = {r=200, g=118, b=51}},
    {pos = vector3(-3170.47, 1044.53, 19.95), shop = "Main", color = {r=200, g=118, b=51}},
    {pos = vector3(-710.33, -152.75, 36.50), shop = "Main", color = {r=200, g=118, b=51}},


    {pos = vector3(-159.75, -299.09, 38.80), shop = "Gants"},
    {pos = vector3(-709.35, -158.24, 36.53), shop = "Gants"},
    {pos = vector3(-1187.81, -764.78, 16.31), shop = "Gants"},
    {pos = vector3(-824.55, -1077.37, 10.32), shop = "Gants"},
    {pos = vector3(-1446.09, -232.87, 48.81), shop = "Gants"},
    {pos = vector3(123.28, -228.67, 53.55), shop = "Gants"},
    {pos = vector3(427.40, -804.18, 28.49), shop = "Gants"},
    {pos = vector3(73.58, -1395.32, 28.42), shop = "Gants"},
    {pos = vector3(1194.15, 2712.15, 37.22), shop = "Gants"},
    {pos = vector3(614.64, 2768.11, 41.08), shop = "Gants"},
    {pos = vector3(-1104.34, 2710.28, 18.10), shop = "Gants"},
    {pos = vector3(1695.07, 4825.37, 41.06), shop = "Gants"},
    {pos = vector3(7.717, 6512.68, 30.87), shop = "Gants"},

    {pos = vector3(-1197.4964, -778.007, 16.3282), shop = "Calques"},
    {pos = vector3(-1456.68, -236.9451, 48.80068), shop = "Calques"},
    {pos = vector3(-712.4457, -158.87181, 36.41512), shop = "Calques"},
    {pos = vector3(6157.361129, -300.87817, 38.7332), shop = "Calques"},
    {pos = vector3(124.10999, -213.01936, 53.5578), shop = "Calques"},
    {pos = vector3(-1104.34, 2710.28, 18.10), shop = "Calques"},
    {pos = vector3(422.6043, -807.3051, 28.4911), shop = "Calques"},
    {pos = vector3(79.058, -1395.1157, 28.387), shop = "Calques"},
    {pos = vector3(-822.4327, -1077.7965, 11.33960), shop = "Calques"},
    
    {pos = vector3(123.28, -228.67, 52.55), shop = "Chaines"},
    {pos = vector3(-1452.24877, -235.02206, 48.8045), shop = "Chaines"},
    {pos = vector3(-712.7622, -153.96272, 36.4151), shop = "Chaines"},
    {pos = vector3(-160.8069, -304.444061, 38.73327), shop = "Chaines"},
    {pos = vector3(128.2233, -214.917, 53.5578), shop = "Chaines"},
    {pos = vector3(422.03079, -804.03271, 29.5026), shop = "Chaines"},
    {pos = vector3(78.3427, -1391.8995, 28.3761), shop = "Chaines"},
    {pos = vector3(-820.0460, -1075.60778, 10.32), shop = "Chaines"},
    {pos = vector3(-1200.08227, -774.09850, 16.319), shop = "Chaines"},

    {pos = vector3(-1337.69, -1277.76, 3.90), shop = "Masque"}, 

    {pos = vector3(-717.22, -152.55, 36.41), shop = "Lunettes"},
    {pos = vector3(-158.98, -309.03, 38.73), shop = "Lunettes"},
    {pos = vector3(-719.57, -147.62, 36.41), shop = "Sac"},
    {pos = vector3(-161.03, -313.84, 38.73), shop = "Sac"},

    {pos = vector3(-167.93, -299.11, 38.73), shop = "Chapeau"},

    {pos = vector3(-1454.94, -241.48, 48.82), shop = "Lunettes"},
    {pos = vector3(-1455.33, -244.33, 48.82), shop = "Chapeau"},
    {pos = vector3(-1452.09, -229.97, 48.79), shop = "Sac"},
    {pos = vector3(-1450.68, -237.95, 48.81), shop = "Oreille"},
    {pos = vector3(-1447.40, -240.04, 48.81), shop = "T-shirt"},
    {pos = vector3(-1447.70, -242.94, 48.82), shop = "Pantalon"},
    {pos = vector3(-1446.04, -229.26, 48.80), shop = "Chaussures"},
    {pos = vector3(-1458.91, -240.66, 48.80), shop = "Torse"},


    {pos = vector3(-820.81, -1071.91, 10.40), shop = "Lunettes"},
    {pos = vector3(-829.60, -1075.42, 10.40), shop = "Chapeau"},
    {pos = vector3(-825.05, -1082.24, 10.40), shop = "Sac"},
    {pos = vector3(-817.35, -1076.09, 10.40), shop = "Oreille"},
    {pos = vector3(-827.86, -1070.65, 10.40), shop = "T-shirt"},
    {pos = vector3(-830.300, -1071.83, 10.40), shop = "Pantalon"},
    {pos = vector3(-822.57, -1080.423, 10.40), shop = "Chaussures"},
    {pos = vector3(-827.22, -1079.68, 10.40), shop = "Torse"},

    {pos = vector3(74.74, -1390.73, 28.40), shop = "Lunettes"},
    {pos = vector3(73.45, -1400.16, 28.40), shop = "Chapeau"},
    {pos = vector3(80.31, -1389.45, 28.40), shop = "Oreille"},
    {pos = vector3(70.17, -1396.11, 28.40), shop = "T-shirt"},
    {pos = vector3(70.23, -1399.03, 28.40), shop = "Pantalon"},
    {pos = vector3(81.337, -1396.505, 28.40), shop = "Chaussures"},
    {pos = vector3(78.24, -1400.08, 28.40), shop = "Torse"},

    {pos = vector3(1694.44, 4820.74, 41.10), shop = "Lunettes"},
    {pos = vector3(1694.93, 4830.28, 41.10), shop = "Chapeau"},
    {pos = vector3(1689.39, 4818.89, 41.10), shop = "Oreille"},
    {pos = vector3(1698.82, 4826.67, 41.10), shop = "T-shirt"},
    {pos = vector3(1698.21, 4829.52, 41.10), shop = "Pantalon"},
    {pos = vector3(1687.64, 4825.63, 41.10), shop = "Chaussures"},
    {pos = vector3(1690.08, 4829.49, 41.10), shop = "Torse"},
    
    {pos = vector3(426.17, -808.34, 28.55), shop = "Lunettes"},
    {pos = vector3(427.57, -798.96, 28.55), shop = "Chapeau"},
    {pos = vector3(420.97, -809.41, 28.55), shop = "Oreille"},
    {pos = vector3(430.839, -803.03, 28.55), shop = "T-shirt"},
    {pos = vector3(430.81, -800.12, 28.55), shop = "Pantalon"},
    {pos = vector3(419.53, -802.74, 28.55), shop = "Chaussures"},
    {pos = vector3(422.73, -798.94, 28.55), shop = "Torse"},

    {pos = vector3(1198.89, 2710.43, 37.30), shop = "Lunettes"},
    {pos = vector3(1189.62, 2704.07, 37.30), shop = "Chapeau"},
    {pos = vector3(1200.09, 2705.37, 37.30), shop = "Oreille"},
    {pos = vector3(1193.42, 2715.49, 37.30), shop = "T-shirt"},
    {pos = vector3(1190.71, 2715.38, 37.30), shop = "Pantalon"},
    {pos = vector3(1193.07, 2704.38, 37.30), shop = "Chaussures"},
    {pos = vector3(1189.49, 2707.51, 37.30), shop = "Torse"},

    {pos = vector3(3.25, 6510.72, 30.92), shop = "Lunettes"},
    {pos = vector3(11.50, 6515.90, 30.92), shop = "Chapeau"},
    {pos = vector3(-0.90, 6513.86, 30.92), shop = "Oreille"},
    {pos = vector3(10.65, 6510.85, 30.92), shop = "T-shirt"},
    {pos = vector3(1190.71, 2715.38, 30.92), shop = "Pantalon"},
    {pos = vector3(3.36, 6519.19, 30.92), shop = "Chaussures"},
    {pos = vector3(8.1, 6519.39, 30.92), shop = "Torse"},

    {pos = vector3(127.10, -220.85, 53.60), shop = "Lunettes"},
    {pos = vector3(124.36, -220.91, 53.60), shop = "Chapeau"},
    {pos = vector3(123.71, -207.39, 53.60), shop = "Oreille"},
    {pos = vector3(120.59, -216.14, 53.60), shop = "T-shirt"},
    {pos = vector3(129.78, -218.22, 53.60), shop = "Pantalon"},
    {pos = vector3(119.47, -222.34, 53.60), shop = "Chaussures"},
    {pos = vector3(130.92, -214.74, 53.60), shop = "Torse"},
    {pos = vector3(132.78, -210.53, 53.60), shop = "Sac"},

    {pos = vector3(-1195.63, -769.71, 16.4), shop = "Lunettes"},
    {pos = vector3(-1193.69, -771.31, 16.4), shop = "Chapeau"},
    {pos = vector3(-1200.40, -782.63, 16.4), shop = "Oreille"},
    {pos = vector3(-1192.93, -777.36, 16.4), shop = "T-shirt"},
    {pos = vector3(-1199.53, -770.68, 16.4), shop = "Pantalon"},
    {pos = vector3(-1188.49, -772.70, 16.4), shop = "Chaussures"},
    {pos = vector3(-1202.53, -772.79, 16.4), shop = "Torse"},
    {pos = vector3(-1206.25, -775.40, 16.4), shop = "Sac"},

    {pos = vector3(-3169.35, 1046.41, 19.92), shop = "Lunettes"},
    {pos = vector3(-3171.74, 1046.78, 19.92), shop = "Chapeau"},
    {pos = vector3(-3171.33, 1060.15, 19.92), shop = "Oreille"},
    {pos = vector3(-3175.22, 1051.68, 19.92), shop = "T-shirt"},
    {pos = vector3(-3166.23, 1049.16, 19.92), shop = "Pantalon"},
    {pos = vector3(-3176.88, 1045.65, 19.92), shop = "Chaussures"},
    {pos = vector3(-3164.95, 1052.47, 19.92), shop = "Torse"},
    {pos = vector3(-3163.15, 1056.55, 19.92), shop = "Sac"},

    {pos = vector3(-162.54, -309.68, 38.80), shop = "T-shirt"},
    {pos = vector3(-157.04, -296.62, 38.80), shop = "Pantalon"},
    {pos = vector3(-165.55, -311.24, 38.80), shop = "Chaussures"},
    {pos = vector3(-159.99, -295.67, 38.80), shop = "Torse"},

    {pos = vector3(-715.66, -149.57, 36.50), shop = "T-shirt"},
    {pos = vector3(-709.34, -161.82, 36.50), shop = "Pantalon"},
    {pos = vector3(-714.91, -145.93, 36.50), shop = "Chaussures"},
    {pos = vector3(-706.74, -160.47, 36.50), shop = "Torse"},
}

Shared.info = {
    ["Sac"] = {nom1 = "bags_1", nom2 = "bags_2", nom3 = "zedkoversac", var = 5, slidemax = "Texture"},
    ["Masque"] = {nom1 = "mask_1", nom2 = "mask_2", nom3 = "zedkovermasque", var = 1, slidemax = "Texture"},
    ["Torse"] = {nom1 = "torso_1", nom2 = "torso_2", nom3 = "zedkovertorse", var = 11, slidemax = "Texture"}, 
    ["T-shirt"] = {nom1 = "tshirt_1", nom2 = "tshirt_2", nom3 = "zedkovertshirt", var = 8, slidemax = "Texture"},
    ["Pantalon"] = {nom1 = "pants_1", nom2 = "pants_2", nom3 = "zedkoverpantalon", var = 4, slidemax = "Texture"},
    ["Chaussures"] = {nom1 = "shoes_1", nom2 = "shoes_2", nom3 = "zedkoverchaussures", var = 6, slidemax = "Texture"}, 
    ["Calques"] = {nom1 = "decals_1", nom2 = "decals_2", nom3 = "zedkoverCalques", var = 1, slidemax = "Prop"},
    ["Gants"] = {nom1 = "arms", nom2 = "arms_2", nom3 = "zedkovergant", var = 1, slidemax = 10},
    ["Chaines"] = {nom1 = "chain_1", nom2 = "chain_2", nom3 = "zedkoverchaine", var = 1, slidemax = "Prop"},
    ["Oreille"] = {nom1 = "ears_1", nom2 = "ears_2", nom3 = "zedkoveroreille", var = 1, slidemax = "Prop"},
    ["Chapeau"] = {nom1 = "helmet_1", nom2 = "helmet_2", nom3 = "zedkoverchapeau", var = 0, slidemax = "Prop"},
    ["Lunettes"] = {nom1 = "glasses_1", nom2 = "glasses_2", nom3 = "zedkoverlunettes", var = 1, slidemax = "Prop"},
}