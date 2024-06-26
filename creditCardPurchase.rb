require 'active_merchant'

# Use the TrustCommerce test servers
ActiveMerchant::Billing::Base.mode = :test

gateway = ActiveMerchant::Billing::TrustCommerceGateway.new(
            :login => 'TestMerchant',
            :password => 'password')

# ActiveMerchant accpts all amounts a Integer values in cents
amount = 1000 #10.00

# The card verification value is also know as CVV2, CVC2, or CID
credit_card = ActiveMerchant::Billing::CreditCard.new(
                :first_name         => 'Maurice',
                :last_name          => 'Maurisen',
                :number             => '3535353535353535',
                :month              => '8',
                :year               => Time.now.year+1,
                :verification_value => '000')

# Validating the card automatically detects the card type

 if credit_card.validate.empty?

    # Capture $10 from the credit card

    response = gateway.purchase(amount, credit_card)


    if response.success?
        puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
    else
        raise StandardError, response.message
    end
end
