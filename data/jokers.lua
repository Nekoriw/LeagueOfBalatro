SMODS.Atlas {
    key = "LeagueOfBalatro_Jokers",
    path = "LeagueOfBalatro_Jokers.png",
    px = 71,
    py = 95
}

-- Khazix
SMODS.Joker({
    key = "khazix",
    loc_txt = {
        name = "Kha'zix",
        text = {
            "{C:chips}+#1#{} Chips if played",
            "hand contains only {C:attention}1{} card",
        },
    },
    config = {
        extra = {
            chips = 50
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.chips },
        }
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    cost = 4,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 5, y = 0 },


    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if #context.full_hand == 1 then
                card.ability.extra.single = true
            else
                card.ability.extra.single = false
            end
        end

        if context.joker_main then
            if card.ability.extra.single then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end,
})

-- Diana
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
    cost = 4,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 4, y = 0 },

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
})

-- Zilean
SMODS.Joker({
    key = "zilean",
    loc_txt = {
        name = "Zilean",
        text = {
            "Every {C:attention}3 hands{},",
            "Zilean level up the played hand",
            "{C:inactive}(#1# remaining)"
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
    rarity = 2,
    cost = 6,
    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 1, y = 0 },

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers then
            card.ability.extra.hands = card.ability.extra.hands - 1
            if (card.ability.extra.hands == 0) then
                card.ability.extra.hands = 3
                return {
                    message = "Level up!",
                    level_up = true
                }
            end
        end
    end,
})

-- Naafiri
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
    rarity = 1,
    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 0, y = 0 },
    cost = 4,

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
})

-- Veigar
SMODS.Joker({
    key = "veigar",
    loc_txt = {
        name = "Veigar",
        text = {
            "{C:chips}+#1#{} Chips",
            "When {C:attention}Boss Blind{} is defeated",
            "Double his chips"
        },
    },
    config = {
        extra = {
            chips = 10
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.chips },
        }
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 6,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 2, y = 0 },

    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and not context.repetition and not context.individual and not context.blueprint then
            card.ability.extra.chips = card.ability.extra.chips * 2
            return {
                message = 'Upgraded',
                colour = G.C.BLUE
            }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
})

-- Malphite
SMODS.Joker({
    key = "malphite",
    loc_txt = {
        name = "Malphite",
        text = {
            "When {C:attention}Stone card{} is scored",
            "gain {C:chips}+#2#{} Chips",
            "{C:inactive}(Currently {}{C:chips}+#1#{}{C:inactive} Chips){}"
        },
    },
    config = {
        extra = {
            chips = 0,
            gain_chips = 10,
            stone_counter = 0
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.chips, card.ability.extra.gain_chips, card.ability.extra.stone_counter },
        }
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    cost = 4,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 3, y = 0 },

    calculate = function(self, card, context)
        if context.individual and not context.blueprint and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                card.ability.extra.stone_counter = card.ability.extra.stone_counter + 1
                return {
                    message = 'Upgraded',
                    message_card = card,
                    colour = G.C.BLUE
                }
            end
        end

        if context.joker_main then
            card.ability.extra.chips = card.ability.extra.chips +
                (card.ability.extra.gain_chips * card.ability.extra.stone_counter)
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.after then
            card.ability.extra.stone_counter = 0
        end
    end,
})

-- Ivern
SMODS.Joker({
    key = "ivern",
    loc_txt = {
        name = "Ivern",
        text = {
            "Gain {C:mult}+#2#{} Mult per",
            "{C:attention}jungle card{} used",
            "{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive} Mult){}"
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
    cost = 6,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 7, y = 0 },

    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint then
            if context.consumeable.config.center.set == 'JungleCard' then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain_mult

                return {
                    message = 'Upgrade !',
                    message_card = card,
                    colour = G.C.RED
                }
            end
        end

        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
})

-- Nilah
SMODS.Joker({
    key = "nilah",
    loc_txt = {
        name = "Nilah",
        text = {
            "When a {C:attention}planet card{}",
            "is used, level up",
            "a random hand"
        },
    },

    config = {
        extra = {

        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {},
        }
    end,

    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 6,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 6, y = 0 },

    calculate = function(self, card, context)
        if context.using_consumeable then
            if context.consumeable.config.center.set == 'Planet' then
                level_up_hand(card, pseudorandom_element(G.handlist, pseudoseed('seed')), nil, 1)

                return {
                    message = 'Level Up !',
                    message_card = card,
                    colour = G.C.BLUE
                }
            end
        end
    end,
})

-- Sejuani
SMODS.Joker({
    key = "sejuani",
    loc_txt = {
        name = "Sejuani",
        text = {
            "Every {C:attention}#1#{} hands containing a {C:attention}frozen card{}",
            "{C:attention}freeze{} all cards in {C:attention}played hand{}",
            "{C:inactive}(When this triggers, add #2# required hands){}",
            "{C:inactive}(#3# remaining){}"
        },
    },

    config = {
        extra = {
            hand_need = 4,
            hand_gain = 2,
            hand_count = 4,
            decrease = true
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.hand_need, card.ability.extra.hand_gain, card.ability.extra.hand_count },
        }
    end,

    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 3,
    cost = 8,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 8, y = 0 },

    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.decrease = false
            for k, v in pairs(context.scoring_hand) do
                for i = 1, #context.scoring_hand do
                    local target_card = context.scoring_hand[i]
                    if SMODS.has_enhancement(target_card, 'm_LeagueOfBalatro_frozen') then
                        card.ability.extra.decrease = true
                    end
                end
            end

            --decrease stacks
            if card.ability.extra.decrease == true then
                card.ability.extra.hand_count = card.ability.extra.hand_count - 1

                --freeze cards if needed
                if card.ability.extra.hand_count == 0 then
                    for k, v in pairs(context.scoring_hand) do
                        for i = 1, #context.scoring_hand do
                            local target_card = context.scoring_hand[i]
                            target_card:set_ability("m_LeagueOfBalatro_frozen", true)
                        end
                    end

                    return {
                        message = 'Freeze !',
                        message_card = card,
                        colour = G.C.BLUE
                    }
                end

                return {
                    message = 'Stacking !',
                    message_card = card,
                    colour = G.C.BLUE
                }
            end
        end

        --reset the joker, and increase the stacks needed
        if context.after then
            if card.ability.extra.hand_count == 0 then
                card.ability.extra.hand_need = card.ability.extra.hand_need + card.ability.extra.hand_gain
                card.ability.extra.hand_count = card.ability.extra.hand_need
            end
        end
    end,
})

-- Ornn
SMODS.Joker({
    key = "ornn",
    loc_txt = {
        name = "Ornn",
        text = {
            "When {C:attention}Blind{} is selected",
            "Create a random {C:attention}consumable{}"
        },
    },

    config = {
        extra = {

        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {},
        }
    end,

    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 6,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 4, y = 1 },

    calculate = function(self, card, context)
        if context.setting_blind then
            SMODS.add_card({
                skip_materialize = true,
                set = "Consumeables",
                soulable = false,
                no_edition = true,
                area = G.consumeables,
            })

            return {
                message = 'Crafted !',
                message_card = card,
                colour = G.C.BLUE
            }
        end
    end,
})
