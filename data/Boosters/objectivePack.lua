SMODS.Atlas {
    key = "LeagueOfBalatro_Consumables",
    path = "LeagueOfBalatro_Consumables.png",
    px = 71,
    py = 95
}

-- voidgrubs
SMODS.Consumable {
    key = 'voidgrubs', -- key
    set = 'Tarot',     -- the set of the card: corresponds to a consumable type
    atlas = 'LeagueOfBalatro_Consumables',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'Voidgrubs', -- name of card
        text = {            -- text of card
            'Turns {C:attention}#1#{} randoms cards',
            'into {C:attention}Void Card{}',
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

        -- Convert 3 cards into the void cards
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

-- Shelly
SMODS.Consumable {
    key = 'shelly', -- key
    set = 'Tarot',  -- the set of the card: corresponds to a consumable type
    atlas = 'LeagueOfBalatro_Consumables',
    pos = { x = 1, y = 0 },
    loc_txt = {
        name = 'Shelly', -- name of card
        text = {         -- text of card
            'Turns {C:attention}#1#{} card',
            'into {C:attention}Void Card{}',
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
