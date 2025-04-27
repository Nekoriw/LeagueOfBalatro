-- voidgrubs
SMODS.Consumable {
    key = 'voidgrubs',      -- key
    set = 'tarot',          -- the set of the card: corresponds to a consumable type
    loc_txt = {
        name = 'Voidgrubs', -- name of card
        text = {            -- text of card
            'Turns {C:interest}#1#{} randoms cards',
            'into {C:interest}Void Card{}',
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
    use = function(self, card, area, copier)

    end,
}
