SMODS.Atlas {
	key = "clownfish",
	path = "clownfish.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	key = 'donttaptheglass',
	loc_txt = {
		name = "Don't Tap the Glass",
		text = {
			"Give {X:mult,C:white}X#1#{} Mult for",
			"every glass card in hand.",
            "And don't tap the glass!"
		}
	},
	config = { extra = { Xmult = 1.5, quip = "dont tap the glass"} },
	rarity = 2,
	atlas = 'clownfish',
	pos = { x = 0, y = 0 },
    enhancement_gate = 'm_glass',
	cost = 6,

	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.Xmult} }
	end,

	calculate = function(self, card, context)
		if context.joker_main then
            local glassCount = 0
            for i = 1, #context.scoring_hand do
                if SMODS.has_enhancement(context.scoring_hand[i], 'm_glass') then
                    return{
                        message = card.ability.extra.quip
                    }
                end
            end
            for i = 1, #G.hand.cards do
                if SMODS.has_enhancement(G.hand.cards[i], 'm_glass') then
                    glassCount = glassCount + 1,
                    card_eval_status_text(G.hand.cards[i],'extra',nil,nil,nil,{message = "X1.5 Mult"})
                    play_sound("gong")
                end
            end
            if glassCount > 0 then
                local multMult = card.ability.extra.Xmult^glassCount
                return {
                    Xmult_mod = multMult,
                    message =  "X" .. multMult,
                }
            end
		end
    end
}

SMODS.Joker {
	key = 'solopoly',
	loc_txt = {
		name = 'Solo Poly Hijabi Amputee',
		text = {
			"Upon entering a boss blind,",
			"applies random edition to a random card."
		}
	},
	rarity = 3,
	atlas = 'clownfish',
	pos = { x = 1, y = 0 },
    enhancement_gate = 'm_glass',
	cost = 7,

	calculate = function(self, card, context)
        if G.GAME.blind:get_type() == 'Boss' and context.setting_blind then
            local chosenOne = math.random(#G.deck.cards)
            local editionNumber = math.random(0,10)
            if editionNumber <=4 then
                G.deck.cards[chosenOne]:set_edition({foil = true}, true)
            elseif editionNumber <=6 then
                G.deck.cards[chosenOne]:set_edition({holo = true}, true)
            elseif editionNumber <=9 then
                G.deck.cards[chosenOne]:set_edition({polychrome = true}, true)
            else
                G.deck.cards[chosenOne]:set_edition({negative = true}, true)
            end
            return {
                message = "Woked!"
            }
        end
    end
}

-- TODO: fix
SMODS.Joker {
	key = 'eggsnbacey',
	loc_txt = {
		name = 'Eggs and Bacey',
		text = {
			"Sell value increases by 2 at the end of blind,",
			"and adds 8x it's sell value as chips.",
            "Currently {C:blue}+#1#{}"
		}
	},
	rarity = 1,
    config = {extra = {chips = 16}},
	atlas = 'clownfish',
	pos = { x = 2, y = 0 },
	cost = 4,

    loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips }  }
	end,

	calculate = function(self, card, context)
        local count = 0 
        local chipPlus = count * 8 
        if context.setting_blind then
            card.base_cost = card.base_cost + 4
        end
        if context.end_of_round then
            count = count + 2
            card.config.extra.chips = chipPlus
            return {message = "+$2!"}
        end
		if context.joker_main then
            return{
                chip_mod = chipPlus,
                message = "Wakey wakey! + "..chipPlus.."!"
            }
        end
    end
}

