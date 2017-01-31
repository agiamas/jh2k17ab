require "roda"
require "lib/helpers"

class Server < Roda
  route do |r|

    r.root do
      "Hello Roda"
    end

    # GET /balance
    r.get "balance" do
      "balance"
    end

    # POST /add_balance?address=ethereum_address
    r.post do
      eth_address = r['address']
      validate_address(eth_address)
      "#{r['address']}"
    end

  end

end

Server.freeze.app
