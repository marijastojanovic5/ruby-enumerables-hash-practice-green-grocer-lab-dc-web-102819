def consolidate_cart(cart)
  updated_cart = {}
  cart.each do |item|
    item.each do |k, v|
      if !updated_cart[k]
        updated_cart[k] = v
        updated_cart[k][:count] = 1
      else
        updated_cart[k][:count] += 1
      end
    end
  end
  updated_cart
end

def apply_coupons(cart, coupons)
  # code here
  new_cart = {}
  cart.each do |grocery, info|
    coupons.each do |coupon|
      if grocery == coupon[:item] && info[:count] >= coupon[:num]
        cart[grocery][:count] = cart[grocery][:count] - coupon[:num]
        if new_cart[grocery + " W/COUPON"]
          new_cart[grocery + " W/COUPON"][:count] += 1
        else
          new_cart[grocery + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[grocery][:clearance], :count => 1}
        end
      end
    end
    new_cart[grocery] = info

  end
  new_cart
end

def apply_clearance(cart)
  # code here
  clearance_cart = {}
  cart.each do |item, info|
    clearance_cart[item] = {}
    info.each do |datum|
      if cart[item][:clearance]
        clearance_cart[item][:price] = (cart[item][:price] * 0.80).round(2)
      else
        clearance_cart[item][:price] = cart[item][:price]
      end
      clearance_cart[item][:clearance] = cart[item][:clearance]
      clearance_cart[item][:count] = cart[item][:count]

    end
  end
  clearance_cart
end

