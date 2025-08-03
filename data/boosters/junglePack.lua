SMODS.Atlas {
    key = "LeagueOfBalatro_Consumables",
    path = "LeagueOfBalatro_Consumables.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "LeagueOfBalatro_Booster",
    path = "LeagueOfBalatro_Booster.png",
    px = 71,
    py = 95
}

--Objective Pack
SMODS.ConsumableType {
    key = 'JungleCard',                                    -- consumable type key

    collection_rows = { 4, 5 },                            -- amount of cards in one page
    primary_colour = G.C.PURPLE,                           -- first color
    secondary_colour = HEX('2E6F40'),                      -- second color
    loc_txt = {
        collection = 'Jungle Cards',                       -- name displayed in collection
        name = 'Jungle Card',                              -- name displayed in badge
        undiscovered = {
            name = 'Hidden Card',                          -- undiscovered name
            text = { 'Find this card in an unseeded run' } -- undiscovered text
        }
    },
    shop_rate = 1, -- rate in shop out of 100
}

--Booster 1
SMODS.Booster {
    key = 'JungleBooster1',
    loc_txt = {
        name = "Jungle Pack",
        text = {
            'Choose {C:attention}#1#{} of up to',
            '{C:attention}#2#{} {C:2E6F40}Jungle{} cards to',
            'be used immediately',
        },
        group_name = "Jungle Pack",
    },
    atlas = 'LeagueOfBalatro_Booster',
    pos = { x = 0, y = 0 },

    draw_hand = true,
    config = {
        extra = 3,
        choose = 1,
    },

    cost = 4,
    weight = 5,

    create_card = function(self, card, i)
        return SMODS.create_card({
            skip_materialize = true,
            set = "JungleCard",
            area = G.pack_cards,
        })
    end,
}

--Booster 2
SMODS.Booster {
    key = 'JungleBooster2',
    loc_txt = {
        name = "Jungle Pack",
        text = {
            'Choose {C:attention}#1#{} of up to',
            '{C:attention}#2#{} {C:2E6F40}Jungle{} cards to',
            'be used immediately',
        },
        group_name = "Jungle Pack",
    },
    atlas = 'LeagueOfBalatro_Booster',
    pos = { x = 1, y = 0 },

    draw_hand = true,
    config = {
        extra = 3,
        choose = 1,
    },

    cost = 4,
    weight = 5,

    create_card = function(self, card, i)
        return SMODS.create_card({
            skip_materialize = true,
            set = "JungleCard",
            area = G.pack_cards,
        })
    end,
}

--Jumbo Booster
SMODS.Booster {
    key = 'JumboJungleBooster',
    loc_txt = {
        name = "Jumbo Jungle Pack",
        text = {
            'Choose {C:attention}#1#{} of up to',
            '{C:attention}#2#{} {C:2E6F40}Jungle{} cards to',
            'be used immediately',
        },
        group_name = "Jungle Pack",
    },
    atlas = 'LeagueOfBalatro_Booster',
    pos = { x = 2, y = 0 },

    draw_hand = true,
    config = {
        extra = 5,
        choose = 1,
    },

    cost = 6,
    weight = 3,

    create_card = function(self, card, i)
        return SMODS.create_card({
            skip_materialize = true,
            set = "JungleCard",
            area = G.pack_cards,
        })
    end,
}

--Mega Booster
SMODS.Booster {
    key = 'MegaJungleBooster',
    loc_txt = {
        name = "Mega Jungle Pack",
        text = {
            'Choose {C:attention}#1#{} of up to',
            '{C:attention}#2#{} {C:2E6F40}Jungle{} cards to',
            'be used immediately',
        },
        group_name = "Jungle Pack",
    },
    atlas = 'LeagueOfBalatro_Booster',
    pos = { x = 3, y = 0 },

    draw_hand = true,
    config = {
        extra = 5,
        choose = 2,
    },

    cost = 8,
    weight = 2,

    create_card = function(self, card, i)
        return SMODS.create_card({
            skip_materialize = true,
            set = "JungleCard",
            area = G.pack_cards,
        })
    end,
}

-- voidgrubs
SMODS.Consumable {
    key = 'voidgrubs',  -- key
    set = 'JungleCard', -- the set of the card: corresponds to a consumable type
    atlas = 'LeagueOfBalatro_Consumables',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Voidgrubs', -- name of card
        text = {            -- text of card
            "Enhances {C:attention}#1#{} random cards",
            "to {C:attention}Void Card{}"
        }
    },
    config = {
        extra = {
            cards = 3, -- configurable value
        }
    },

    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return { vars = { center.ability.extra.cards } }
        end
        return { vars = {} }
    end,
    can_use = function(self, card)
        if G and G.hand and card.ability and card.ability.extra and card.ability.extra.cards then
            return true
        end
        return false
    end,
    use = function(self)
        local cards = {}
        for k, v in ipairs(G.hand.cards) do
            cards[#cards + 1] = v
        end

        -- Shuffle the cards in cards
        pseudoshuffle(cards, pseudoseed('voidgrubs'))

        -- turn 3 cards into void cards
        local choosen_cards = {}
        for i = 1, 3 do
            local choosen = cards[i]
            choosen_cards[#choosen_cards + 1] = choosen
        end

        -- Convert 3 cards into the void cards
        for i = 1, #choosen_cards do
            local target_card = choosen_cards[i]
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                target_card:flip(),
                delay = 0.2,
                func = function()
                    play_sound('tarot1', 1.1, 0.6)
                    target_card:flip()
                    target_card:set_ability('m_LeagueOfBalatro_void', true)
                    return true
                end
            }))
        end
        return true
    end,
}

-- Shelly
SMODS.Consumable {
    key = 'shelly',     -- key
    set = 'JungleCard', -- the set of the card: corresponds to a consumable type
    atlas = 'LeagueOfBalatro_Consumables',
    pos = { x = 4, y = 0 },
    loc_txt = {
        name = 'Shelly', -- name of card
        text = {         -- text of card
            "Enhances {C:attention}#1#{} card",
            "to {C:attention}Void Card{}"
        }
    },
    config = {
        extra = {
            cards = 1, -- configurable value
        }
    },

    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return { vars = { center.ability.extra.cards } }
        end
        return { vars = {} }
    end,
    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,
    use = function(self)
        -- Check if highlighted cards exist
        if not G.hand.highlighted or #G.hand.highlighted == 0 then
            return false
        end

        -- Convert selected card into void card
        for i = 1, #G.hand.highlighted do
            local target_card = G.hand.highlighted[i]
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                target_card:flip(),
                delay = 0.2,
                func = function()
                    play_sound('tarot1', 1.1, 0.6)
                    target_card:flip()
                    target_card:set_ability('m_LeagueOfBalatro_void', true)
                    return true
                end
            }))
        end
        return true
    end,
}

-- Baron Nashor
SMODS.Consumable {
    key = 'nashor',     -- key
    set = 'JungleCard', -- the set of the card: corresponds to a consumable type
    atlas = 'LeagueOfBalatro_Consumables',
    pos = { x = 1, y = 0 },
    loc_txt = {
        name = 'Baron Nashor', -- name of card
        text = {               -- text of card
            'Give {C:attention}#1#${} for each',
            '{C:attention}Void Card{} in full deck',
        }
    },
    config = {
        extra = {
            money = 2,
            total = 0,
        }
    },
    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return { vars = { center.ability.extra.money } }
        end
        return { vars = {} }
    end,
    can_use = function(self, card)
        if G and G.hand and card.ability and card.ability.extra then
            return true
        end
        return false
    end,
    use = function(self, card)
        -- calculate number of void cards in full deck
        local void_count = 0
        for k, v in pairs(G.playing_cards) do
            if SMODS.has_enhancement(v, 'm_LeagueOfBalatro_void') then
                void_count = void_count + 1
            end
        end
        ease_dollars(2 * void_count)
    end,
}

-- Mountain Drake
SMODS.Consumable {
    key = 'mountainDrake', -- key
    set = 'JungleCard',    -- the set of the card: corresponds to a consumable type
    atlas = 'LeagueOfBalatro_Consumables',
    pos = { x = 2, y = 0 },
    loc_txt = {
        name = 'Mountain Drake', -- name of card
        text = {                 -- text of card
            "Enhances {C:attention}#1#{} cards",
            "to {C:attention}Stone Card{}"
        }
    },
    config = {
        extra = {
            cards = 2, -- configurable value
        }
    },

    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return { vars = { center.ability.extra.cards } }
        end
        return { vars = {} }
    end,

    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,

    use = function(self)
        -- Check if highlighted cards exist
        if not G.hand.highlighted or #G.hand.highlighted == 0 then
            return false
        end

        -- Convert selected card into stone card
        for i = 1, #G.hand.highlighted do
            local target_card = G.hand.highlighted[i]
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                target_card:flip(),
                delay = 0.2,
                func = function()
                    play_sound('tarot1', 1.1, 0.6)
                    target_card:flip()
                    target_card:set_ability("m_stone", true)
                    return true
                end
            }))
        end
        return true
    end,
}

-- Ocean Drake
SMODS.Consumable {
    key = 'oceanDrake', -- key
    set = 'JungleCard', -- the set of the card: corresponds to a consumable type
    atlas = 'LeagueOfBalatro_Consumables',
    pos = { x = 3, y = 0 },
    loc_txt = {
        name = 'Ocean Drake', -- name of card
        text = {              -- text of card
            "Enhances {C:attention}#1#{} cards",
            "to {C:attention}Frozen Card{}"
        }
    },
    config = {
        extra = {
            cards = 2, -- configurable value
        }
    },

    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return { vars = { center.ability.extra.cards } }
        end
        return { vars = {} }
    end,

    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,

    use = function(self)
        -- Check if highlighted cards exist
        if not G.hand.highlighted or #G.hand.highlighted == 0 then
            return false
        end

        -- Convert selected card into stone card
        for i = 1, #G.hand.highlighted do
            local target_card = G.hand.highlighted[i]
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                target_card:flip(),
                delay = 0.2,
                func = function()
                    play_sound('tarot1', 1.1, 0.6)
                    target_card:flip()
                    target_card:set_ability("m_LeagueOfBalatro_frozen", true)
                    return true
                end
            }))
        end
        return true
    end,
}

-- Gromp
SMODS.Consumable {
    key = 'gromp',      -- key
    set = 'JungleCard', -- the set of the card: corresponds to a consumable type
    atlas = 'LeagueOfBalatro_Consumables',
    pos = { x = 5, y = 0 },
    loc_txt = {
        name = 'Gromp', -- name of card
        text = {        -- text of card
            'Remove {C:attention}enhancement{} and {C:attention}seal{}',
            'to {C:attention}#1#{} card',
        }
    },
    config = {
        extra = {
            cards = 1, -- configurable value
        }
    },

    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return { vars = { center.ability.extra.cards } }
        end
        return { vars = {} }
    end,

    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,

    use = function(self)
        -- Check if highlighted cards exist
        if not G.hand.highlighted or #G.hand.highlighted == 0 then
            return false
        end

        -- Convert selected card into stone card
        for i = 1, #G.hand.highlighted do
            local target_card = G.hand.highlighted[i]
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                target_card:flip(),
                delay = 0.2,
                func = function()
                    play_sound('tarot1', 1.1, 0.6)
                    target_card:flip()
                    target_card:set_ability(G.P_CENTERS.c_base)
                    target_card:set_seal(nil)
                    return true
                end
            }))
        end
        return true
    end,
}

-- Scuttle
SMODS.Consumable {
    key = 'scuttle',
    set = 'JungleCard',
    atlas = 'LeagueOfBalatro_Consumables',
    pos = { x = 6, y = 0 },
    loc_txt = {
        name = 'Scuttle Crab', -- name of card
        text = {               -- text of card
            'Create {C:attention}#1#{} random',
            'Jungle Cards',
        }
    },

    config = {
        extra = {
            cards = 2, -- configurable value
        }
    },

    loc_vars = function(self, info_queue, center)
        return { vars = { center.ability.extra.cards } }
    end,

    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            return true
        end
        return false
    end,

    use = function(self, card)
        for i = 1, 2 do
            SMODS.add_card({
                skip_materialize = true,
                set = "JungleCard",
                no_edition = true,
                area = G.consumeables,
            })
        end
    end
}
