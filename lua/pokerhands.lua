SMODS.PokerHand{
    key = "Fluh",
    chips = 25,
    mult = 3,
    l_chips = 10,
    l_mult = 2,
    example = {
        { 'H_A',    true },
        { 'H_J',    true },
        { 'H_10',    true },
        { 'H_8',    true },
        { 'D_5',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Fluh',
            description = {
                '4 cards of the same suit',
                'and 1 card of the same color.'
            }
        }
    },
    -- TODO: fix
    evaluate = function(hand)
        local suits = {
          "Spades",
          "Hearts",
          "Clubs",
          "Diamonds"
        }
        if #hand > 5 or #hand < 5 then
            return {}
        else
          for j = 1, #suits do
            local t = {}
            local suit = suits[j]
            local flush_count = 0
            for i=1, #hand do
              if hand[i]:is_suit(suit, nil, true) then flush_count = flush_count + 1;  t[#t+1] = hand[i] end 
            end
            if flush_count == 4 then
              table.insert(ret, t)
              return ret
            end
          end
          return {}
        end
    end
}