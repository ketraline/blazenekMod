SMODS.Atlas {
	key = "clownfish",
	path = "clownfish.png",
	px = 71,
	py = 95
}

SMODS.Joker {
	key = 'tronek',
	loc_txt = {
		name = 'EPIC TRONEK JOKER',
		text = {
			"Earn {C:money}$#1#{} (eighty) at",
			"end of round"
		}
	},
	config = { extra = { money = 80 } },
	rarity = 3,
	atlas = 'clownfish',
	pos = { x = 0, y = 0 },
	cost = 6,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money } }
	end,
	calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.money
		if bonus > 0 then return bonus end
	end
}