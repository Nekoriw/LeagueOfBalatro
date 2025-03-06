SMODS.Joker({
    key = "testJoker",
    loc_txt = {
        name = "Test Joker",
        text = {
            "This Test Joker gains {C:chips}+#1#{} Chips",
            "if Poker Hand is a {C:attention}High Card{}",
            "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
        },
    },
    config = {
        extra = {
            chips = 0,
            chips_gain = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.chips_gain, card.ability.extra.chips },
        }
    end,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 1,


    calculate = function(self, card, context)
        if context.before and context.scoring_name == 'High Card' then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            return {
                message = 'Upgraded!',
                colour = G.C.BLUE
            }
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
