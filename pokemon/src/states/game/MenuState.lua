--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MenuState = Class{__includes = BaseState}

function MenuState:init(def)
    self.HPIncrease = def.HPIncrease
    self.HPbefore = def.HPbefore
    self.attackIncrease = def.attackIncrease
    self.attackbefore = def.attackbefore
    self.defenseIncrease = def.defenseIncrease
    self.defensebefore = def.defensebefore
    self.speedIncrease = def.speedIncrease
    self.speedbefore = def.speedbefore

    self.Menu = Menu {
        x = VIRTUAL_WIDTH - (VIRTUAL_WIDTH / 2 + 100),
        y = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT / 2 + 85),
        width = 250,
        height = 100,
        flag = false,
        items = {
            {
            text = 'HP Increase: ' .. tostring(self.HPbefore) .. ' + ' .. tostring(self.HPIncrease) .. 
            ' = ' .. tostring(self.HPbefore + self.HPIncrease)
            },
        {
            text = 'Attack: ' .. tostring(self.attackIncrease) .. ' + ' .. tostring(self.attackbefore) .. 
            ' = ' .. tostring(self.attackbefore + self.attackIncrease)
        }, 
        {
            text = 'Defense: ' .. tostring(self.defenseIncrease) .. ' + ' .. tostring(self.defensebefore) .. 
            ' = ' .. tostring(self.defensebefore + self.defenseIncrease)
        }, 
        {
            text = 'Speed: ' .. tostring(self.speedIncrease) .. ' + ' .. tostring(self.speedbefore) .. 
            ' = ' .. tostring(self.speedbefore + self.speedIncrease)
        }
    }}

           
end

function MenuState:update(dt)
    self.Menu:update(dt)
end

function MenuState:render()
    self.Menu:render()
end