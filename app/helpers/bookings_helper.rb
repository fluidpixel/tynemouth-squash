module BookingsHelper

def paid_link_text(payable)  
  payable.paid? ? 'Paid' : 'Pay'  
end 

end
