SMODS.Voucher {
    key = 'inhibitor',
    loc_txt = {
        name = 'Inhibitor',
        text = {
            '{C:green}Jungle{} cards appear',
            '{C:attention}2x{} more frequently',
            'in the shop',
        }
    },
    --atlas = '',
    --pos = { x = 0, y = 0 },
    config = {
        extra = {
        }
    },
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.junglecard_rate = (G.GAME.junglecard_rate or 2) * 2
                return true
            end
        }))
    end
}

SMODS.Voucher {
    key = 'nexus',
    loc_txt = {
        name = 'Nexus',
        text = {
            '{C:green}Jungle{} cards appear',
            '{C:attention}4x{} more frequently',
            'in the shop',
        }
    },
    --atlas = '',
    --pos = { x = 0, y = 0 },
    config = {
        extra = {
        }
    },
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.junglecard_rate = (G.GAME.junglecard_rate or 4) * 2
                return true
            end
        }))
    end,
    requires = { "v_LeagueOfBalatro_inhibitor" },
}
