type CardHolder = String
data Billing = CreditCard CardHolder
             | CashOnDelivery
             deriving (Show)
