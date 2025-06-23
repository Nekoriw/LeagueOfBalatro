SMODS.Atlas {
    key = 'LeagueOfBalatro_Card',
    path = "LeagueOfBalatro_Card.png",
    px = 71,
    py = 95
}
SMODS.Enhancement({
    key = "hextech",
    name = "Hextech Card",
    atlas = "LeagueOfBalatro_Card",
    pos = { x = 2, y = 0 },
    discovered = true,

    config = {

    },

    loc_txt = {
        name = "Hextech Card",
        text = {
            ""
        },
    },
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)

    end
})
