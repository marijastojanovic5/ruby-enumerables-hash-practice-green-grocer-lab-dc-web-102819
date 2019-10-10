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
coupons.each do |coupon|
  item=coupon[:item]
  if cart[item]
    if cart[item][:count]>=coupon[:num] && !cart.has_key("#{item} W/COUPON")
       cart["#{item} W/COUPON"]={ price: coupon[:cost] /coupon[:num],clearance: cart[item][:clearance]
    ,count: coupon[:num]}
    cart[item][:count] -=coupon[:num]
    elsif  cart[item][:count]>=coupon[:num] && cart.has_key("#{item} W/COUPON")
       cart["#{item} W/COUPON"][:count]+=coupon[:num]
    cart[item][:count] -=coupon[:num]
  end

end
cart
end
 
   

end
def apply_clearance(cart)
  new_cart = cart
  cart.each do |name, hash|
      if hash[:clearance] #if clearance is true, take 20% off
        new_cart[name][:price] = (cart[name][:price] * 0.8).round(2)
      end
  end
  new_cart 
end




def checkout(cart, coupons)
  #call the consolidate to get the count item first
  new_cart = consolidate_cart(cart)
  #apply coupon to the new cart
  apply_coupons(new_cart, coupons)
  #apply clearance after discount from coupon
  apply_clearance(new_cart)

total = 0
  new_cart.each do |name, hash|
    total += (hash[:price] * hash[:count])
  end

if total >= 100
    total *= 0.9
  end

  total
end
