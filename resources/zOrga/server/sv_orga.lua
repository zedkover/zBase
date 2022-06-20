ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("zOrga:saveCrew")
AddEventHandler("zOrga:saveCrew", function(name, devise, tblGrades)
    local xPlayer = ESX.GetPlayerFromId(source)

    -- On vérifie si il n'y a pas une organisation qui existe déjà avec le name
    MySQL.Async.fetchAll("SELECT name FROM orga_liste WHERE name = @name", {
        ["@name"] = name
    }, function(result)
        -- On stoppe la fonction si il y a déjà une orga
        if result[1] then return TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Une organisation avec ce nom existe déjà.") end
        
        -- On envoie les données de l'orga dans la liste
        MySQL.Async.execute("INSERT INTO orga_liste(name, devise) VALUES(@name, @devise)", {
            ["@name"] = name,
            ["@devise"] = devise
        })

        -- Un wait pour être sûr que les données s'insert bien
        TriggerClientEvent("esx:showNotification", xPlayer.source, "~b~Création de l'organisation en cours...")
        Wait(500)

        -- On récupère l'ID de l'organisation qui viens d'être créée
        MySQL.Async.fetchAll("SELECT * FROM orga_liste WHERE name = @name", {
            ["@name"] = name
        }, function(result)
            -- Au cas où il y a une erreur
            if not result[1].id_orga then 
                return TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Il y a eu une erreur, veuillez réessayer.")
            end 

            -- On récupère l'ID pour insérer les grades
            local id_orga = result[1].id_orga
            -- Pour chaque grade, on insert
            for k, v in pairs(tblGrades) do
                MySQL.Async.execute("INSERT INTO orga_grades(name, rang, id_orga) VALUES(@name, @rang, @id_orga)", {
                    ["@name"] = v.name,
                    ["@rang"] = tonumber(v.ask),
                    ["id_orga"] = tonumber(id_orga)
                })
            end

            -- Un Wait pour être sûr que c'est bien inséré
            Wait(500)
            -- On récupère l'ID
            MySQL.Async.fetchAll("SELECT * FROM orga_grades WHERE id_orga = @id_orga", {
                ["@id_orga"] = tonumber(id_orga),
            }, function(result)
                for k, v in pairs(result) do
                    if v.rang == 1 then
                        -- Avec l'ID du grade "Chef", on l'attribue à celui qui a créé l'orga
                        local id_chef = v.id_grade 

                        -- On insert les perms
                        MySQL.Async.execute("INSERT INTO orga_grade_perm(recruit, fire, attribute_property, give_access_property, access_property, see_chest, deposit, remove, access_garage, take_car, park_car, id_grade) VALUES(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, @id_grade)", {
                            ["@id_grade"] = v.id_grade
                        })

                        -- On récupère le nom prénom du joueur pour le label
                        MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
                            ["@identifier"] = xPlayer.identifier
                        }, function(result)
                            local Player = {}
                            Player.FirstName = result[1].firstname 
                            Player.LastName  = result[1].lastname
                            Player.Name = Player.FirstName .. " " .. Player.LastName

                            -- On insert les données dans orga_membres 
                            MySQL.Async.execute("INSERT INTO orga_membres(identifier, label, id_grade) VALUES(@identifier, @label, @id_grade)", {
                                ["@identifier"] = xPlayer.identifier,
                                ["@label"] = Player.Name,
                                ["@id_grade"] = id_chef
                            })

                            -- Un Wait pour être sûr que c'est bien inséré
                            Wait(500)
                        end)
                    else
                        MySQL.Async.execute("INSERT INTO orga_grade_perm(recruit, fire, attribute_property, give_access_property, access_property, see_chest, deposit, remove, access_garage, take_car, park_car, id_grade) VALUES(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, @id_grade)", {
                            ["@id_grade"] = v.id_grade
                        })
                    end

                    TriggerClientEvent("esx:showNotification", xPlayer.source, "~b~Votre organisation '" .. name .. "' a bien été créée.")
                end
            end)
        end)
    end)
end)

RegisterServerEvent("zOrga:updateOrgaName")
AddEventHandler("zOrga:updateOrgaName", function(oldName, newName)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute("UPDATE orga_liste SET name = @name WHERE name = @oldName", {
        ["@name"] = newName,
        ["@oldName"] = oldName
    })

    TriggerClientEvent("esx:showNotification", xPlayer.source, "L'organistion '~b~" .. oldName .. "~s~' a été renommée en '~b~" .. newName .. "~s~'.")
end)

RegisterServerEvent("zOrga:updateOrgaDevise")
AddEventHandler("zOrga:updateOrgaDevise", function(oldName, devise)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute("UPDATE orga_liste SET devise = @devise WHERE name = @oldName", {
        ["@devise"] = devise,
        ["@oldName"] = oldName
    })

    TriggerClientEvent("esx:showNotification", xPlayer.source, "La devise de '~b~" .. oldName .. "~s~' est désormais :\n~b~" .. devise)
end)

RegisterServerEvent("zOrga:firePlyOrga")
AddEventHandler("zOrga:firePlyOrga", function(identifier)
    MySQL.Async.execute("DELETE FROM orga_membres WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })
end)

RegisterServerEvent("zOrga:attributePlyOrga")
AddEventHandler("zOrga:attributePlyOrga", function(target, data)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("DELETE FROM orga_membres WHERE identifier = @identifier", {
        ["@identifier"] = xPlayer.identifier
    })

    MySQL.Async.execute("UPDATE orga_membres SET id_grade = @id_grade WHERE identifier = @identifier", {
        ["@id_grade"] = data.id_grade,
        ["@identifier"] = target
    })

    local xTarget = ESX.GetPlayerFromIdentifier(target)

    if xTarget then
        TriggerClientEvent("esx:showNotification", xTarget.source, xPlayer.name .. " vous a passé ~b~" .. data.name .. "~s~ de votre organisation.")
    end
end)

RegisterServerEvent("zOrga:updatePerm")
AddEventHandler("zOrga:updatePerm", function(perm, id_grade, bool)
    MySQL.Async.execute("UPDATE orga_grade_perm SET " .. perm .. " = @bool WHERE id_grade = @id_grade", {
        ["@bool"] = bool,
        ["@id_grade"] = id_grade
    })
end)

RegisterServerEvent("zOrga:deleteOrga")
AddEventHandler("zOrga:deleteOrga", function(orga)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT id_orga FROM orga_liste WHERE name = @orga", {
        ["@orga"] = orga
    }, function(result)
        if result[1] then
            local id_orga = result[1].id_orga

            MySQL.Async.fetchAll("SELECT id_grade FROM orga_grades WHERE id_orga = @id_orga", {
                ["@id_orga"] = id_orga
            }, function(result)
                for k, v in pairs(result) do 
                    local id_grade = v.id_grade 
                    MySQL.Async.execute("DELETE FROM orga_grade_perm WHERE id_grade = @id_grade", {
                        ["@id_grade"] = id_grade
                    })

                    MySQL.Async.execute("DELETE FROM orga_membres WHERE id_grade = @id_grade", {
                        ["@id_grade"] = id_grade
                    })
                end
            end)

            Wait(250)

            MySQL.Async.execute("DELETE FROM orga_grades WHERE id_orga = @id_orga", {
                ["@id_orga"] = id_orga
            })

            Wait(250)

            MySQL.Async.execute("DELETE FROM orga_liste WHERE id_orga = @id_orga", {
                ["@id_orga"] = id_orga
            })
        end
    end)

    TriggerClientEvent("esx:showNotification", xPlayer.source, "Suppression de l'organisation '~b~" .. orga .. "~s~' effectuée.")
end)

RegisterServerEvent("zOrga:updateGrade")
AddEventHandler("zOrga:updateGrade", function(id_grade, newName)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("UPDATE orga_grades SET name = @newName WHERE id_grade = @id_grade", {
        ["@id_grade"] = id_grade,
        ["@newName"] = newName
    })

    TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez renommé le grade en ~b~" .. newName .. "~s~.")
end)

RegisterServerEvent("zOrga:updatePlayerGrade")
AddEventHandler("zOrga:updatePlayerGrade", function(id_grade, gradeName, identifier, plyName)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute("UPDATE orga_membres SET id_grade = @id_grade WHERE identifier = @identifier", {
        ["@id_grade"] = id_grade,
        ["@identifier"] = identifier
    })

    TriggerClientEvent("esx:showNotification", xPlayer.source, "~b~" .. plyName .. "~s~ est désormais '~b~" .. gradeName .. "~s~'.")
end)

RegisterServerEvent("zOrga:recruitPlayer")
AddEventHandler("zOrga:recruitPlayer", function(player, id_orga)
    local xTarget = ESX.GetPlayerFromId(player)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll("SELECT * FROM orga_membres WHERE identifier = @identifier", {
        ["@identifier"] = xTarget.identifier
    }, function(result)
        if result[1] then 
            return TriggerClientEvent("esx:showNotification", xPlayer.source, "~r~Ce joueur est déjà dans un groupe.")
        end

        MySQL.Async.fetchAll("SELECT * FROM orga_grades WHERE id_orga = @id_orga ORDER BY rang DESC", {
            ["@id_orga"] = id_orga
        }, function(result)
            if result[1] then
                local lastID = result[1].id_grade
    
                MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
                    ["@identifier"] = xTarget.identifier
                }, function(result)
                    local Player = {}
                    Player.FirstName = result[1].firstname 
                    Player.LastName  = result[1].lastname
                    Player.Name = Player.FirstName .. " " .. Player.LastName
    
                    -- On insert les données dans orga_membres 
                    MySQL.Async.execute("INSERT INTO orga_membres(identifier, label, id_grade) VALUES(@identifier, @label, @id_grade)", {
                        ["@identifier"] = xTarget.identifier,
                        ["@label"] = Player.Name,
                        ["@id_grade"] = lastID
                    })
    
                    -- Un Wait pour être sûr que c'est bien inséré
                    Wait(500)
                    TriggerClientEvent("esx:showNotification", xPlayer.source, "Vous avez recruté ~b~" .. Player.Name .. "~s~.")
                    TriggerClientEvent("esx:showNotification", xTarget.source, "Vous avez été recruté dans une ~b~organisation~s~.")
                end)
            end
        end)    
    end)
end)

ESX.RegisterServerCallback("zOrga:getPlyOrga", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT orga_liste.id_orga, orga_liste.name FROM orga_liste INNER JOIN orga_grades ON orga_grades.id_orga = orga_liste.id_orga  INNER JOIN orga_membres ON orga_membres.id_grade = orga_grades.id_grade WHERE orga_membres.identifier = @identifier", {
        ["@identifier"] = xPlayer.identifier
    }, function(result)
        if result[1] then
            cb({name = result[1].name, id = result[1].id_orga})
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback("zOrga:getPlyOrgaData", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll("SELECT * FROM orga_liste INNER JOIN orga_grades ON orga_grades.id_orga = orga_liste.id_orga INNER JOIN orga_membres ON orga_membres.id_grade = orga_grades.id_grade WHERE orga_membres.identifier = @identifier ", {
        ["@identifier"] = xPlayer.identifier
    }, function(result)
        cb(result[1])
    end)
end)

ESX.RegisterServerCallback("zOrga:getOrgaPlyList", function(source, cb, name)
    MySQL.Async.fetchAll("SELECT * FROM orga_liste INNER JOIN orga_grades ON orga_grades.id_orga = orga_liste.id_orga  INNER JOIN orga_membres ON orga_membres.id_grade = orga_grades.id_grade WHERE orga_liste.name = @name ", {
        ["@name"] = name
    }, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback("zOrga:getOrgaData", function(source, cb, name)
    MySQL.Async.fetchAll("SELECT * FROM orga_liste INNER JOIN orga_grades ON orga_grades.id_orga = orga_liste.id_orga WHERE orga_liste.name = @name ", {
        ["@name"] = name
    }, function(result)
        cb(result)
    end)
end)

ESX.RegisterServerCallback("zOrga:getOrgaRanks", function(source, cb, id_grade)
    MySQL.Async.fetchAll("SELECT * FROM orga_grade_perm WHERE id_grade = @id_grade", {
        ["@id_grade"] = tonumber(id_grade)
    }, function(result)
        if result[1] then
            cb(result[1])
        else
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback("zOrga:getOrgaPlyListFromId", function(source, cb, id_orga)
    MySQL.Async.fetchAll("SELECT * FROM orga_liste INNER JOIN orga_grades ON orga_grades.id_orga = orga_liste.id_orga  INNER JOIN orga_membres ON orga_membres.id_grade = orga_grades.id_grade WHERE orga_liste.id_orga = @id_orga ", {
        ["@id_orga"] = id_orga
    }, function(result)
        cb(result)
    end)
end)