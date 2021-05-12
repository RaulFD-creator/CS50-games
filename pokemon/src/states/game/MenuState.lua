--[[
    GD50
    Pokemon

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

MenuState = Class{__includes = BaseState}

function MenuState:init()
    
    self.Menu = Menu {
        x = VIRTUAL_WIDTH - (VIRTUAL_WIDTH / 2 + 100),
        y = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT / 2 + 70),
        width = 400,
        height = 100,
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