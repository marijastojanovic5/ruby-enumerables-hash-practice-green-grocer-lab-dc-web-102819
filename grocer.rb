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
  #doesn't break if there is no coupon
  return cart if coupons == []

  #set new_cart = cart so we don't have to push all the values, just change them
  new_cart = cart

  coupons.each do |coupon|
    name = coupon[:item] #avocado, cheese,...
    num_of_c = coupon[:num]
    #if the cart has the same item in coupon and has larger amount than in coupon
    if cart.include?(name) && cart[name][:count] >= num_of_c
       #remove number of the new_cart's count
       new_cart[name][:count] -= num_of_c
       #increase the count when there is more items than the coupon allows
       if new_cart["#{name} W/COUPON"]
         new_cart["#{name} W/COUPON"][:count] += 1
       #set the name with coupon with new value
       else
         new_cart["#{name} W/COUPON"] = {
           :price => coupon[:cost],
           :clearance => new_cart[name][:clearance],
           :count => 1
         }
       end
     end
   end
   new_cart
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

