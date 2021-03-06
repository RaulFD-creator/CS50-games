--[[
    GD50
    Super Mario Bros. Remake

    -- LevelMaker Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

LevelMaker = Class{}

function LevelMaker.generate(width, height)
    local tiles = {}
    local entities = {}
    local objects = {}

    local tileID = TILE_ID_GROUND
    
    -- whether we should draw our tiles with toppers
    local topper = true
    local tileset = math.random(20)
    local topperset = math.random(20)
    local keyset = math.random(4)
    local blockset = 4 + keyset
    local flag_block = true
    local flag_key = true
    block_lock = math.random(5)
    key = math.random(5)
    while key == block_lock do
        key = math.random(5)
    end
    count = 0
    count2 = 0

    -- insert blank tables into tiles for later access
    for x = 1, height do
        table.insert(tiles, {})
    end

    -- column by column generation instead of row; sometimes better for platformers
    for x = 1, width do
        local tileID = TILE_ID_EMPTY
        
        -- lay out the empty space
        for y = 1, 6 do
            table.insert(tiles[y],
                Tile(x, y, tileID, nil, tileset, topperset))
        end

        -- chance to just be emptiness
        if math.random(7) == 1 then
            if x == 1 or x == width - 5 then 
                for y = 7, height do
                    table.insert(tiles[y],
                            Tile(x, y, TILE_ID_GROUND, y==7 and topper or nil, tileset, topperset))
                end
            else
                for y = 7, height do
                    if y == 3 then 
                        table.insert(tiles[y],
                            Tile(x, y, tileID, topper, tileset, topperset))
                    else
                        table.insert(tiles[y],
                            Tile(x, y, tileID, nil, tileset, topperset))    
                    end
                end
            end
        else
            tileID = TILE_ID_GROUND

            -- height at which we would spawn a potential jump block
            local blockHeight = 4

            for y = 7, height do
                table.insert(tiles[y],
                    Tile(x, y, tileID, y == 7 and topper or nil, tileset, topperset))
            end

            -- chance to generate a pillar
            if math.random(8) == 1 and x < width - 5 then
                blockHeight = 2
                
                -- chance to generate bush on pillar
                if math.random(8) == 1 and x < width - 5 then
                    table.insert(objects,
                        GameObject {
                            texture = 'bushes',
                            x = (x - 1) * TILE_SIZE,
                            y = (4 - 1) * TILE_SIZE,
                            width = 16,
                            height = 16,
                            
                            -- select random frame from bush_ids whitelist, then random row for variance
                            frame = BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7,
                            collidable = false
                        }
                    )
                end
                
                -- pillar tiles
                tiles[5][x] = Tile(x, 5, tileID, topper, tileset, topperset)
                tiles[6][x] = Tile(x, 6, tileID, nil, tileset, topperset)
                tiles[7][x].topper = nil
            
            -- chance to generate bushes
            elseif math.random(8) == 1 and x < width - 5 then
                table.insert(objects,
                    GameObject {
                        texture = 'bushes',
                        x = (x - 1) * TILE_SIZE,
                        y = (6 - 1) * TILE_SIZE,
                        width = 16,
                        height = 16,
                        frame = BUSH_IDS[math.random(#BUSH_IDS)] + (math.random(4) - 1) * 7,
                        collidable = false
                    }
                )
            end

            -- chance to spawn a block
            if math.random(10) == 1 and x < width - 5 then
                if flag_block and count == block_lock then
                    count2 = count2 + 1
                    -- jump block
                    block = GameObject {
                        texture = 'locks_and_keys',
                        x = (x - 1) * TILE_SIZE,
                        y = (blockHeight - 1) * TILE_SIZE,
                        width = 16,
                        height = 16,

                        -- make it a random variant
                        frame = blockset,
                        collidable = true,
                        consumable = false,
                        hit = false,
                        solid = true,
                        onCollide = function(block)
                            gSounds['empty-block']:play()
                        end,

                        onConsume = function(block)
                            table.insert(objects,
                            GameObject {
                                texture = 'flag_poles',
                                x = (width - 5) * TILE_SIZE,
                                y = 3 * TILE_SIZE,
                                width = 16, 
                                height = 64,
                                frame = 2,
                                collidable = true,
                                consumable = true,
                                solid = false,
                                onConsume = function(player,object)
                                    gSounds['pickup']:play()
                                    gStateMachine:change('play', {
                                    width = width + 5 * TILE_SIZE,
                                    score = player.score
                                    })
                                end
                            })

                            table.insert(objects,
                            GameObject{
                                texture = 'flags',
                                x = ((width - 5) * TILE_SIZE) + 9,
                                y = 3 * TILE_SIZE,
                                width = 16,
                                height = 16,
                                frame = 7,                                
                                collidable = true,
                                consumable = true,
                                solid = false,
                                onConsume = function(player,object)
                                    gSounds['pickup']:play()
                                    gStateMachine:change('play', {
                                    width = width + 5 * TILE_SIZE,
                                    score = player.score
                                    })
                                end
                            })

                            gSounds['pickup']:play()
                        end}
                    table.insert(objects, block)
                    flag_block = false

                elseif flag_key and count2 == key then
                    table.insert(objects,

                    --  key
                    GameObject {
                        texture = 'locks_and_keys',
                        x = (x - 1) * TILE_SIZE,
                        y = (blockHeight - 1) * TILE_SIZE,
                        width = 16,
                        height = 16,

                        -- make it a random variant
                        frame = keyset,
                        collidable = true,
                        hit = false,
                        solid = false, 
                        consumable = true,
                        collidable = true,
                        
                        onConsume = function(player, object)
                            gSounds['pickup']:play()
                            block.consumable = true
                            block.solid = false
                        end
                    })
                    flag_key = false
                    count = count + 1

                else
                    count = count + 1
                    count2 = count2 + 1
                    table.insert(objects,

                        -- jump block
                        GameObject {
                            texture = 'jump-blocks',
                            x = (x - 1) * TILE_SIZE,
                            y = (blockHeight - 1) * TILE_SIZE,
                            width = 16,
                            height = 16,

                            -- make it a random variant
                            frame = math.random(#JUMP_BLOCKS),
                            collidable = true,
                            hit = false,
                            solid = true,

                            -- collision function takes itself
                            onCollide = function(obj)

                                -- spawn a gem if we haven't already hit the block
                                if not obj.hit then

                                    -- chance to spawn gem, not guaranteed
                                    if math.random(5) == 1 then

                                        -- maintain reference so we can set it to nil
                                        local gem = GameObject {
                                            texture = 'gems',
                                            x = (x - 1) * TILE_SIZE,
                                            y = (blockHeight - 1) * TILE_SIZE - 4,
                                            width = 16,
                                            height = 16,
                                            frame = math.random(#GEMS),
                                            collidable = true,
                                            consumable = true,
                                            solid = false,

                                            -- gem has its own function to add to the player's score
                                            onConsume = function(player, object)
                                                gSounds['pickup']:play()
                                                player.score = player.score + 100
                                            end
                                        }
                                        
                                        -- make the gem move up from the block and play a sound
                                        Timer.tween(0.1, {
                                            [gem] = {y = (blockHeight - 2) * TILE_SIZE}
                                        })
                                        gSounds['powerup-reveal']:play()

                                        table.insert(objects, gem)
                                    end

                                    obj.hit = true
                                end

                                gSounds['empty-block']:play()
                            end
                        }
                    )
                end
            end
        end
    end

    local map = TileMap(width, height)
    map.tiles = tiles
    for i = 1,10 do
        if flag_block or flag_key then
            flag_block = true 
            flag_key = true
            LevelMaker.generate(width, height)
        else
            goto continue
        end
    end
    ::continue::
    return GameLevel(entities, objects, map)
end