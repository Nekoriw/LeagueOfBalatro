SMODS.Atlas {
    key = 'LeagueOfBalatro_Card',
    path = "LeagueOfBalatro_Card.png",
    px = 71,
    py = 95
}
SMODS.Enhancement({
    key = "frozen",
    name = "Frozen Card",
    atlas = "LeagueOfBalatro_Card",
    pos = { x = 1, y = 0 },
    discovered = true,
    config = {
        frozen_count = 0,
        extra = {
            chips = 0,
            chips_gain = 10
        }
    },
    loc_txt = {
        name = "Frozen Card",
        text = {
            "Gain {C:chips}+#2#{} Chips",
            "per {C:attention}Frozen Card{} in played hand"
        },
    },
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        return {
            vars = { card_ability.extra.chips, card_ability.extra.chips_gain }
        }
    end,
    calculate = function(self, card, context)
        card.ability.frozen_count = 0
        if context.before then
            for k, v in pairs(context.scoring_hand) do
                if SMODS.has_enhancement(v, 'm_LeagueOfBalatro_frozen') then
                    card.ability.frozen_count = card.ability.frozen_count + 1
                end
                card.ability.extra.chips = card.ability.frozen_count * card.ability.extra.chips_gain
            end
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
})
