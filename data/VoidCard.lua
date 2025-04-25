SMODS.Enhancement({
    key = "void",
    pos = { x = 0, y = 0 },
    discovered = false,
    config = {
        extra = {
            mult = 0,
            mult_gain = 5
        }
    },
    loc_vars = function(self, info_queue, card)
        local card_ability = card and card.ability or self.config
        return {
            vars = { card_ability.extra.mult, card_ability.extra.mult_gain }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                mult = card.ability.extra.mult_gain
            }
        end
    end
})
