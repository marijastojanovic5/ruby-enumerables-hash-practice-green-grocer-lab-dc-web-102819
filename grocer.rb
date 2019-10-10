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

def apply_coupons(cart:[], coupons:[])
  	    new_hash = {}
    cart.each do |vegetable, properties|
      if !new_hash[vegetable]
        new_hash[vegetable] = properties
      end
      coupons.each do |hash|
        hash.each do |coupon_key, coupon_value|
          if coupon_value == vegetable
            if !new_hash["#{vegetable} W/COUPON"]
              new_hash["#{vegetable} W/COUPON"] = {:price => hash[:cost], :clearance => cart[vegetable][:clearance], :count => 0}
            end
            if !(new_hash[vegetable][:count] < hash[:num])
              new_hash[vegetable][:count] -= hash[:num]
              new_hash["#{vegetable} W/COUPON"][:count] += 1
            end
          end
        end
      end
    end
    new_hash

end

#result:
{
  "AVOCADO" => {:price => 3.0, :clearance => true, :count => 1},
  "KALE"    => {:price => 3.0, :clearance => false, :count => 1},
  "AVOCADO W/COUPON" => {:price => 5.0, :clearance => true, :count => 1},
}

# apply clearance:
# takes 20% off price if the item is on clearance
# does not discount the price for items not on clearance

def apply_clearance(cart)
  new_cart = cart
  cart.each do |name, hash|
      if hash[:clearance] #if clearance is true, take 20% off
        new_cart[name][:price] = (cart[name][:price] * 0.8).round(2)
      end
  end
  new_cart #if not, just return the same cart
end

# checkout:
# Apply coupon discounts if the proper number of items are present.# calls on #apply_clearance after calling on #apply_coupons when there is only one item in the cart and no coupon
# Apply 20% discount if items are on clearance.
# If, after applying the coupon discounts and the clearance discounts, the cart's total is over $100, then apply a 10% discount.


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
