function Shapeshift(keys)
    local caster = keys.caster
    local form = keys.Form

    local formSkills = {
        {"Normal",nil,{}},
        {"Bear","modifier_bearform",{"ability_beastmaster_bash","ability_beastmaster_slam"}},
        {"Wolf","modifier_wolfform",{"ability_beastmaster_howl","ability_beastmaster_criticalstrike"}},
        {"Elk","modifier_elkform",{"ability_beastmaster_magicimmunity","ability_beastmaster_ram"}}
    }

    -- modify skill visibilities, remove modifiers from other forms
    for _,skillList in pairs(formSkills) do
        local isVisible = (form == skillList[1])
        local modifier = skillList[2]
        if form ~= skillList[1] and modifier ~= nil then
            caster:RemoveModifierByName(modifier)
        end
        for _,skill in pairs(skillList[3]) do
            SetAbilityVisibility(caster, skill, isVisible)
        end
    end
end


function WolfForm(event)
    local hero = event.caster
    local ability = event.ability

    ToggleOffSet(hero, ability)
end

function BearForm(event)
    local hero = event.caster
    local ability = event.ability

    ToggleOffSet(hero, ability)
end

function ElkForm(event)
    local hero = event.caster
    local ability = event.ability

    ToggleOffSet(hero, ability)
end

function NormalForm(event)
    local hero = event.caster
    local ability = event.ability

    ToggleOffSet(hero, ability)
end


-- Toggle the other abilities
function ToggleOffSet(hero, ability)
    local wolf = hero:FindAbilityByName("ability_beastmaster_wolfform")
    local elk = hero:FindAbilityByName("ability_beastmaster_elkform")
    local bear = hero:FindAbilityByName("ability_beastmaster_bearform")
    local normal = hero:FindAbilityByName("ability_beastmaster_normalform")

    if bear and ability ~= bear then
        ToggleOff(bear)
    end

    if wolf and ability ~= wolf then
        ToggleOff(wolf)
    end

    if elk and ability ~= elk then
        ToggleOff(elk)
    end
    
    if normal and ability ~= normal then
        ToggleOff(normal)
    end

    removeModifiers(hero)    
end

--clear any modifiers left over by passives
function removeModifiers(hero)
    local modifierTable = {"modifier_wolf_crit", "modifier_bear_bash_passive"}

    for _,modifierName in pairs(modifierTable) do
        if hero:HasModifier(modifierName) then
            hero:RemoveModifierByName(modifierName)
        end
    end
end
