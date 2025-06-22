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
        if context.before and context.cardarea == G.jokers and not context.blueprint then
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

        if context.after and not context.blueprint then
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
        if context.before and not context.blueprint then
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
        if context.after and not context.blueprint then
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

-- Alistar
SMODS.Joker({
    key = "alistar",
    loc_txt = {
        name = "Alistar",
        text = {
            "Gain {X:chips,C:white}X0.1{} chips",
            "per {C:attention}10${} you have",
            "{C:inactive}(Currently {X:chips,C:white}X#1#{}{C:inactive} Chips)"
        },
    },

    config = {
        extra = {

        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = { 1 + math.floor(G.GAME.dollars / 10) * 0.1 },
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
    pos = { x = 2, y = 1 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xchips = 1 + math.floor(G.GAME.dollars / 10) * 0.1
            }
        end
    end,
})

-- Kai'sa
SMODS.Joker({
    key = "kaisa",
    loc_txt = {
        name = "Kai'Sa",
        text = {
            "Gain {X:mult,C:white}X#1#{} Mult and remove enhancement",
            "When a {C:attention}Void Card{} is scored",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{} Mult)"
        },
    },

    config = {
        extra = {
            gain_mult = 0.25,
            xmult = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.gain_mult, card.ability.extra.xmult },
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
    pos = { x = 3, y = 1 },

    calculate = function(self, card, context)
        if context.before and not context.blueprint and context.cardarea == G.jokers then
            local removed = false
            for k, v in pairs(context.scoring_hand) do
                for i = 1, #context.scoring_hand do
                    local target_card = context.scoring_hand[i]
                    if SMODS.has_enhancement(target_card, 'm_LeagueOfBalatro_void') then
                        card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.gain_mult
                        target_card:set_ability(G.P_CENTERS.c_base)
                        removed = true
                    end
                end
            end
            if removed then
                return {
                    message = 'Upgraded',
                    message_card = card,
                    colour = G.C.RED
                }
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
})

-- Asol
SMODS.Joker({
    key = "aurelion",
    loc_txt = {
        name = "Aurelion Sol",
        text = {
            "When a {C:attention}diamond{} card is scored,",
            "Gain 1 stack. At 75 stacks, create a {C:attention}Black Hole{}",
            "{C:inactive}(Currently {C:chips}#1#{C:inactive} stacks)"
        },
    },

    config = {
        extra = {
            stacks = 0
        },
        loc_def = 'on_individual'
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.stacks },
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
    pos = { x = 5, y = 1 },

    calculate = function(self, card, context)
        if context.individual and not context.blueprint and context.cardarea == G.play then
            if context.other_card.base.suit == 'Diamonds' then
                card.ability.extra.stacks = card.ability.extra.stacks + 1
                if card.ability.extra.stacks >= 75 then
                    card.ability.extra.stacks = 0
                    SMODS.add_card({ key = "c_black_hole" })
                    return {
                        message = 'Crafted !',
                        message_card = card,
                        colour = G.C.RED
                    }
                else
                    return {
                        message = 'Upgraded !',
                        message_card = card,
                        colour = G.C.BLUE
                    }
                end
            end
        end
    end,
})

-- Evelynn
SMODS.Joker({
    key = "evelynn",
    loc_txt = {
        name = "Evelynn",
        text = {
            "If {C:attention}first discard{} of the round has only {C:attention}1{} card :",
            "Transform a {C:attention}Non-Heart{} card into an Heart",
            "{C:inactive}(If it's already an Heart, destroy it){}"
        },
    },

    config = {
        extra = {

        },
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {},
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
    pos = { x = 2, y = 2 },

    calculate = function(self, card, context)
        if context.discard and not context.hook and not context.blueprint then
            if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then --if first discard has 1 card
                local target_card = context.full_hand[1]

                -- Heart
                if target_card.base.suit == 'Hearts' then
                    SMODS.destroy_cards({ target_card })
                    return {
                        message = 'Destroyed!',
                        message_card = card,
                        colour = G.C.RED
                    }
                end

                -- Non-heart
                if target_card.base.suit ~= 'Hearts' then
                    SMODS.change_base(target_card, 'Hearts')
                    return {
                        message = 'Charmed!',
                        message_card = card,
                        colour = G.C.RED
                    }
                end
            end
        end
    end,
})

-- Ahri
SMODS.Joker({
    key = "ahri",
    loc_txt = {
        name = "Ahri",
        text = {
            "If {C:attention}first hand{} of the round has only",
            "{C:attention}1{} card {C:attention}Decreases{}",
            "rank of the card by {C:attention}1{}"
        },
    },

    config = {
        extra = {
        },
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
    rarity = 3,
    cost = 8,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 1, y = 2 },

    calculate = function(self, card, context)
        if context.before and not context.hook then
            if G.GAME.current_round.hands_played <= 0 and #context.full_hand == 1 then --if first discard has 1 card
                local target_card = context.full_hand[1]

                SMODS.modify_rank(target_card, -1)
            end
        end
    end,
})

-- G.GAME.current_round.hands_played
