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
            "Gain {C:attention}money{} equal to the number",
            "of {C:attention}hands remaining{} in the round"
        },
    },
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        return {
            vars = {}
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            ease_dollars(G.GAME.current_round.hands_left)
            return {
                card_eval_status_text(card, 'extra', nil, nil, nil, { message = "Money !", colour = G.C.GOLD }),
            }
        end
    end
})
