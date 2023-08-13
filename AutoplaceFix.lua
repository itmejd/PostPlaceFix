local recivedPacket = false
local recivedPacket2 = false

module_manager.register("AutoplaceFix", {
    on_receive_packet = function(e)
        if e.packet_id == 0x02 then
            message = string.gsub(e.message, '(\194\167%w)', '')
            if string.find(message, "Derek Chauvin on top") then
                recivedPacket = true
            elseif string.find(message, "last game i got kneeled on by derek chauvin how to fix?") then
                recivedPacket2 = true
            end
        end
    end,

    on_send_packet = function(t)
        if recivedPacket2 then
            player.send_packet(0x09, 5)
            recivedPacket2 = false
        end
        if recivedPacket then
    		if t.packet_id == 0x02 then
                if t.action == 2 then
    			    t.cancel = true
                end
    	    end
        end
        return t
    end,

    on_player_join = function()
        recivedPacket = false
    end
})

module_manager.register_boolean("AutoplaceFix", "LEAVE ON ALWAYS", false)