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
            "if played hand is a {C:attention}Three of a kind{}",
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
            "level up the played hand",
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
            local eval = function()
                return card.ability.extra.hands == 1
            end

            juice_card_until(card, eval, true)

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
            "{C:mult}+#2#{} Mult per hand played",
            "Resets and gains {C:mult}+1{} Mult per hand when {C:attention}Boss Blind{} is defeated",
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
            chips = 1
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
            "Gains {C:chips}+#2#{} Chips",
            "when a {C:attention}Stone card{} is played",
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
    rarity = 2,
    cost = 6,

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
            "{C:green}Jungle{} card used",
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
    rarity = 1,
    cost = 4,

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
            "When a {C:planet}Planet{} card is",
            "used, level up a random hand"
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
            "Every {C:attention}#1#{} hands containing a {C:attention}Frozen{} card",
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
            local eval = function()
                return card.ability.extra.hand_count == 1
            end

            juice_card_until(card, eval, true)

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
            "When {C:attention}Blind{} is selected,",
            "Create a random {C:attention}consumable{}",
            "{C:inactive}(Must have room){}"
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
            if G.consumeables.config.card_limit > #G.consumeables.cards then
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
            "This Joker gains {X:mult,C:white}X#1#{} Mult per scoring",
            "{C:attention}Void{} Card, removes Void Enhancement",
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
            "When a {C:diamonds}Diamond{} card is scored,",
            "Gain 1 stack. At 75 stacks, create a {C:Spectral   }Black Hole{}",
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
            if context.other_card:is_suit('Diamonds') then
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
            "If {C:attention}first discard{} of the round has only {C:attention}1{} card",
            "turn it into a {C:hearts}Heart{}",
            "If it's already a {C:hearts}Heart{}, destroy it"
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
            "If {C:attention}first hand{} of round has only {C:attention}1{} card",
            "Decreases its rank by {C:attention}1{}"
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

                return {
                    message = 'Decreased !',
                    message_card = card,
                    colour = G.C.RED
                }
            end
        end
    end,
})

-- Seraphine
SMODS.Joker({
    key = "seraphine",
    loc_txt = {
        name = "Seraphine",
        text = {
            "If {C:attention}first hand{} of round has only {C:attention}1{} card",
            "Increases its rank by {C:attention}1{}"
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
    pos = { x = 4, y = 3 },

    calculate = function(self, card, context)
        if context.before and not context.hook then
            if G.GAME.current_round.hands_played <= 0 and #context.full_hand == 1 then --if first discard has 1 card
                local target_card = context.full_hand[1]

                SMODS.modify_rank(target_card, 1)

                return {
                    message = 'Increased !',
                    message_card = card,
                    colour = G.C.RED
                }
            end
        end
    end,
})

-- Taliyah
SMODS.Joker({
    key = "taliyah",
    loc_txt = {
        name = "Taliyah",
        text = {
            "Every #2# hands containing a {C:attention}stone card{},",
            "add 2 {C:attention}stone cards{} to deck",
            "{C:inactive}(Currently #1# stacks){}"
        },
    },

    config = {
        extra = {
            stacks = 0,
            stacks_need = 5,
            stone = false
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.stacks, card.ability.extra.stacks_need, card.ability.extra.stone },
        }
    end,

    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    cost = 4,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 3, y = 3 },

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local eval = function()
                return card.ability.extra.stacks == card.ability.extra.stacks_need - 1
            end

            juice_card_until(card, eval, true)

            card.ability.extra.decrease = false
            for k, v in pairs(context.scoring_hand) do
                for i = 1, #context.scoring_hand do
                    local target_card = context.scoring_hand[i]
                    if SMODS.has_enhancement(target_card, 'm_stone') then
                        card.ability.extra.stone = true
                        return {
                            message = 'Stacking !',
                            message_card = card,
                            colour = G.C.BLUE
                        }
                    end
                end
            end
        end

        --reset the joker, and increase the stacks needed
        if context.after and not context.blueprint then
            if card.ability.extra.stone then
                card.ability.extra.stacks = card.ability.extra.stacks + 1
                card.ability.extra.stone = false
            end
            if card.ability.extra.stacks_need == card.ability.extra.stacks then
                card.ability.extra.stacks = 0

                SMODS.add_card { set = "Base", enhancement = "m_stone", area = G.deck }
                SMODS.add_card { set = "Base", enhancement = "m_stone", area = G.deck }

                return {
                    message = 'Rocks !',
                    message_card = card,
                    colour = G.C.RED
                }
            end
        end
    end
})

-- Trundle
SMODS.Joker({
    key = "trundle",
    loc_txt = {
        name = "Trundle",
        text = {
            "All played {C:attention}face{} cards",
            "become {C:attention}Frozen{} cards",
            "when scored"
        },
    },
    config = {
        extra = {

        }
    },
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 6,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 8, y = 1 },

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            for k, v in ipairs(context.scoring_hand) do
                if v:is_face() then
                    v:set_ability("m_LeagueOfBalatro_frozen", true)
                end
            end
        end
    end,
})

-- Syndra
SMODS.Joker({
    key = "syndra",
    loc_txt = {
        name = "Syndra",
        text = {
            "Gain {X:mult,C:white}X#1#{} Mult",
            "when a {C:clubs}Club{} is scored",
            "{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult)"
        },
    },

    config = {
        extra = {
            xmult_gain = 0.01,
            xmult = 1,
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult },
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
    pos = { x = 7, y = 1 },

    calculate = function(self, card, context)
        if context.individual and not context.blueprint and context.cardarea == G.play then
            if context.other_card:is_suit('Clubs') then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
            end
        end

        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
})

-- Braum
SMODS.Joker({
    key = "braum",
    loc_txt = {
        name = "Braum",
        text = {
            "{C:attention}Frozen{} cards give",
            "{C:mult}+#1#{} Mult when scored"
        },
    },

    config = {
        extra = {
            mult_gain = 5,
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.mult_gain },
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
    pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_LeagueOfBalatro_frozen') then
                return {
                    mult = card.ability.extra.mult_gain
                }
            end
        end
    end,
})

-- G.GAME.current_round.hands_played
-- G.GAME.current_round.hands

-- Lissandra
SMODS.Joker({
    key = "lissandra",
    loc_txt = {
        name = "Lissandra",
        text = {
            "In the {C:attention}final hand{} of",
            "the round, enhance all scored",
            "cards into {C:attention}Frozen{} cards"
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
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 6,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local eval = function()
                return G.GAME.current_round.hands_left == 1
            end

            juice_card_until(card, eval, true)

            if G.GAME.current_round.hands_left == 0 then
                for k, v in ipairs(context.scoring_hand) do
                    v:set_ability("m_LeagueOfBalatro_frozen", true)
                end
            end
        end
    end,
})

-- Anti-debuff Olaf
SMODS.current_mod.set_debuff = function(card)
    if card.config.center.key == 'j_LeagueOfBalatro_olaf' then
        return 'prevent_debuff'
    end
end

-- Olaf
SMODS.Joker({
    key = "olaf",
    loc_txt = {
        name = "Olaf",
        text = {
            "{C:chips}+#1#{} Chips",
            "{C:inactive}This joker can't be debuffed{}"
        },
    },

    config = {
        extra = {
            chips = 100,
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.chips },
        }
    end,

    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 1,
    cost = 4,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 8, y = 2 },

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
})

-- Hwei
SMODS.Joker({
    key = "hwei",
    loc_txt = {
        name = "Hwei",
        text = {
            "This Joker gains {X:mult,C:white}x1{} Mult",
            "per {C:attention}different{} suits in hand"
        },
    },
    config = {
        extra = {
            diamonds = false,
            hearts = false,
            spades = false,
            clubs = false,
            count = 0
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
    rarity = 3,
    cost = 8,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 0, y = 2 },

    calculate = function(self, card, context)
        if context.individual and not context.blueprint and context.cardarea == G.play then
            if context.other_card:is_suit('Clubs') then
                card.ability.extra.clubs = true
            end

            if context.other_card:is_suit('Hearts') then
                card.ability.extra.hearts = true
            end

            if context.other_card:is_suit('Diamonds') then
                card.ability.extra.diamonds = true
            end

            if context.other_card:is_suit('Spades') then
                card.ability.extra.spades = true
            end
        end

        if context.joker_main then
            if card.ability.extra.diamonds then
                card.ability.extra.count = card.ability.extra.count + 1
            end

            if card.ability.extra.hearts then
                card.ability.extra.count = card.ability.extra.count + 1
            end

            if card.ability.extra.spades then
                card.ability.extra.count = card.ability.extra.count + 1
            end

            if card.ability.extra.clubs then
                card.ability.extra.count = card.ability.extra.count + 1
            end

            if card.ability.extra.count == 0 then
                card.ability.extra.count = 1
            end

            return {
                xmult = card.ability.extra.count
            }
        end

        if context.after and not context.blueprint then
            card.ability.extra.diamonds = false
            card.ability.extra.hearts = false
            card.ability.extra.spades = false
            card.ability.extra.clubs = false
            card.ability.extra.count = 0
        end
    end,
})

-- Vex
SMODS.Joker({
    key = "vex",
    loc_txt = {
        name = "Vex",
        text = {
            "Retrigger {C:spades}Spade{} cards"
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
    rarity = 3,
    cost = 8,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 9, y = 0 },

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only then
            if context.other_card:is_suit('Spades') then
                return {
                    message = 'Again!',
                    repetitions = 1,
                    card = context.other_card
                }
            end
        end
    end,
})

-- Poppy
SMODS.Joker({
    key = "poppy",
    loc_txt = {
        name = "Poppy",
        text = {
            "{C:attention}Played{} and {C:attention}Discarded{} cards go back in deck",
            "{C:inactive}(After the next cards are drawn){}"
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
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 3,
    cost = 8,

    atlas = "LeagueOfBalatro_Jokers",
    pos = { x = 5, y = 3 },

    calculate = function(self, card, context)
        if context.drawing_cards and not context.blueprint then
            G.FUNCS.draw_from_discard_to_deck()
        end
    end
})
