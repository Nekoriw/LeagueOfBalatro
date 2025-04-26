SMODS.Atlas {
    key = 'LeagueOfBalatro_Card',
    path = "LeagueOfBalatro_Card.png",
    px = 71,
    py = 95
}
SMODS.Enhancement({
    key = "void",
    name = "Void Card",
    atlas = "LeagueOfBalatro_Card",
    pos = { x = 0, y = 0 },
    discovered = true,
    config = {
        void_count = 0,
        extra = {
            mult = 0,
            mult_gain = 0.5
        }
    },
    loc_txt = {
        name = "Void Card",
        text = {
            "Gain {C:mult}+#2#{} Mult",
            "per {C:attention}Void Card{} in full deck",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        },
    },
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        return {
            vars = { card_ability.extra.mult, card_ability.extra.mult_gain }
        }
    end,
    calculate = function(self, card, context)
        card.ability.void_count = 0
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_LeagueOfBalatro_void') then
                card.ability.void_count = card.ability.void_count + card.ability.extra.mult_gain
            end
            card.ability.extra.mult = card.ability.void_count
        end
        if context.cardarea == G.play and context.main_scoring then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
})
