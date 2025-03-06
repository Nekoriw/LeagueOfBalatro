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
        -- checks if scoring card is stone card
        if context.individual and next(context.poker_hands['High Card']) then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
            return {
                extra = {
                    message = 'Plop !',
                    colour = G.C.RED,
                    focus = card,
                },
                card = card,
            }
        end

        --adds mult after hand is played
        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chips_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.chips } },
                card = card
            }
        end
    end
})
