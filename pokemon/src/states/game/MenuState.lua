--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MenuState = Class{__includes = BaseState}

function MenuState:init()
    
    self.Menu = Menu {
        x = VIRTUAL_WIDTH - 356,
        y = VIRTUAL_HEIGHT - 356,
        width = 128,
        height = 128,
        flag = false,
        items = {
            {
                text = 'Fight'},
            }
        }

           
end

function MenuState:update(dt)
    self.Menu:update(dt)
end

function MenuState:render()
    self.Menu:render()
end