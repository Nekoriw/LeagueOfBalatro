SMODS.Joker({
    key = "testJoker",
    loc_txt = {
        name = "Test Joker",
        text = {
            "This Test Joker gains {C:chips}+#2#{} Chips",
            "when scoring a {C:attention}High Card{}",
            "{C:inactive}(Currently {C:chips}+#0#{C:inactive} Chips)"
        },
    },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 1,
    config = {
        extra = {
            chips = 0,
            chips_gain = 10
        }
    },

    calculate = function(self, card, context)
        if context.before and next(context.poker_hands['High Card']) then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
        end

        if context.joker_main then
            if card.ability.extra.chips > 0 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
})
