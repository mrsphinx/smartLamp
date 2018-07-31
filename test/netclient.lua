local module={}
local client = nil
local function ping_pong()
    if client then
        client:send("PING:PING")
    end
end
local function net_start()
    client = websocket.createClient()
    client:on("connection", function(ws)
        tmr.unregister(0)
        print('got ws connection')
        client:send("REGISTER:"..config.ID)
        tmr.alarm(1,1000,1,ping_pong)
    end)
    client:on("receive", function(_, msg, opcode)
        print('got message:', msg, opcode) -- opcode is 1 for text message, 2 for binary
    end)
    client:on("close", function(_, status)
        print('connection closed', status)
        client = nil -- required to Lua gc the websocket client
        tmr.alarm(0,10000,1,net_start)
        tmr.unregister(1)
    end)
      
      client:connect("ws://"..config.HOST..":"..config.PORT)
      
end

function module.start()
    net_start()
end

return module