SMODS.Atlas {
    key = "LeagueOfBalatro",
    path = "LeagueOfBalatro_Jokers.png",
    px = 71,
    py = 95
}

SMODS.Joker({
    key = "khazix",
    loc_txt = {
        name = "Kha'zix",
        text = {
            "Kha'zix gains {C:chips}+#1#{} Chips",
            "if played hand contains only {C:attention}1{} card",
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
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    pos = { x = 0, y = 0 },
    cost = 3,


    calculate = function(self, card, context)
        if context.before and #context.full_hand == 1 and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            return {
                message = 'Upgraded',
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
    atlas = "LeagueOfBalatro"
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
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    pos = { x = 1, y = 0 },
    cost = 3,


    calculate = function(self, card, context)
        if context.before and context.scoring_name == 'Three of a Kind' and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            return {
                message = 'Upgraded',
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
    atlas = "LeagueOfBalatro"
})
SMODS.Joker({
    key = "zilean",
    loc_txt = {
        name = "Zilean",
        text = {
            "Every {C:attention}3 hands{},",
            "Zilean level up the played hand",
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
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    pos = { x = 2, y = 0 },
    cost = 4,

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
    end,
    atlas = "LeagueOfBalatro"
})
SMODS.Joker({
    key = "naafiri",
    loc_txt = {
        name = "Naafiri",
        text = {
            "Each hand played, gain {C:mult}+#2#{} Mult.",
            "When {C:attention}Boss Blind{} is defeated",
            "reset and gain {C:mult}+1{} Mult per hand",
            "{C:inactive}(Currently {}{C:mult}+#1#{} {C:inactive}Mult){}"
        },
    },
    config = {
        extra = {
            mult = 0,
            gain_mult = 1
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.mult, card.ability.extra.gain_mult },
        }
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    pos = { x = 3, y = 0 },
    cost = 6,

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain_mult
            return {
                message = '+' .. card.ability.extra.gain_mult .. ' Mult',
                colour = G.C.RED
            }
        end

        if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual and not context.blueprint then
            card.ability.extra.mult = 0
            card.ability.extra.gain_mult = card.ability.extra.gain_mult + 1
            return {
                message = 'Reset',
                colour = G.C.RED
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    atlas = "LeagueOfBalatro"
})
