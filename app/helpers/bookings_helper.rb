module BookingsHelper

def paid_link_text(payable)  
  payable.paid? ? 'Paid' : 'Pay'  
end 

def paid_link_class(payable)  
  payable.paid? ? 'has_paid' : 'to_pay'  
end

end
