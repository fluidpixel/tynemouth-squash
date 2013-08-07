module BookingsHelper

def paid_link_text(payable)  
  payable.paid? ? 'Payed' : 'Pay'  
end 

end
