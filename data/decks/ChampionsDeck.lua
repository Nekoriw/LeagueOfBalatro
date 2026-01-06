SMODS.Atlas {
    key = 'LeagueOfBalatro_Card',
    path = "LeagueOfBalatro_Card.png",
    px = 71,
    py = 95
}
SMODS.Back {
    atlas = "LeagueOfBalatro_Card",
    name = "Champions Deck",
    key = "champions",
    pos = { x = 4, y = 1 },
    loc_txt = {
        name = "Champions Deck",
        text = {
            "Only {C:attention}League Of Balatro{} jokers",
            "can spawn in this deck."
        },
    },

    apply = function()
        G.E_MANAGER:add_event(Event({
            func = function()
                for k, v in pairs(G.P_CENTERS) do
                    if v.set == 'Joker' then
                        if (not v.mod) then
                            G.GAME.banned_keys[k] = true
                        end
                    end
                end

                return true
            end
        }))
    end
}
