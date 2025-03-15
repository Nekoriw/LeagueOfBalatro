SMODS.Joker({
    key = "khazix",
    loc_txt = {
        name = "Kha'zix",
        text = {
            "Kha'zix gains {C:chips}+#1#{} Chips",
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
    cost = 3,


    calculate = function(self, card, context)
        if context.before and context.scoring_name == 'High Card' and not context.blueprint then
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
    end,
})
SMODS.Joker({
    key = "diana",
    loc_txt = {
        name = "Diana",
        text = {
            "Diana gains {C:chips}+#1#{} Chips",
            "if Poker Hand is a {C:attention}Three of a kind{}",
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
    cost = 3,


    calculate = function(self, card, context)
        if context.before and context.scoring_name == 'Three of a Kind' and not context.blueprint then
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
    end,
})
SMODS.Joker({
    key = "zilean",
    loc_txt = {
        name = "Zilean",
        text = {
            "Every 3 hands, Zilean level up the played hand",
            "{C:inactive}(In #1# hands)"
        },
    },
    config = {
        extra = {
            hands = 3
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.hands },
        }
    end,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 3,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            card.ability.extra.hands = card.ability.extra.hands - 1
            if (card.ability.extra.hands == 0) then
                card.ability.extra.hands = 3
                return {
                    level_up = true
                }
            end
        end
    end
})
