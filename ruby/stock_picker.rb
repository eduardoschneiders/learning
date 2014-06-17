#stock_picker([17,3,6,9,15,8,6,1,10])
    #=> [1,4]  # for a profit of $15 - $3 == $12


def stock_picker(prices)
  current_price_day = 0
  best_profit = 0
  best_days = []

  prices.each do |price|
    current_buy_price = price

    prices_to_sell = prices[current_price_day + 1..prices.length]
    best_price_to_sell = prices_to_sell.max
    best_day_to_sell = prices.index(best_price_to_sell)

    if best_price_to_sell && current_buy_price
      profit = best_price_to_sell - current_buy_price

      if profit > best_profit
        best_profit = profit
        best_days = [current_price_day, best_day_to_sell]
      end
    end
    current_price_day += 1
  end

  best_days
end
