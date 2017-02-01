require "roda"
require_relative "lib/helpers"

# HTTPS requests for ethereum balance
require "net/https"
require "uri"

require "json"
require "sequel"


class Server < Roda
  # our sqlite db file
  DB_FILE = "db/sqlite3.db"
  WEIS_TO_ETH = 1000000000000000000
  @@DB = Sequel.sqlite(DB_FILE)
  # initialize roda server to keep our instance variable
  # def initialize(input)
  #   super(input)
  #
  # end

  route do |r|

    # hello world in / endpoint
    r.root do
      "Hello AB eth app!"
    end

    # GET /balance
    r.get "balance" do
      result = []
      @@DB[:accounts].each {|row|
         row[:ether_balance] = (row[:balance].to_f/WEIS_TO_ETH)
         result << row
      }
      "#{result}"
    end

    # POST /add_balance?address=ethereum_address
    r.post do
      eth_address = r['address']
      if(validate_address(eth_address)) then
        # This being Ruby it will cast FixNum into BigNum :)
        balance = get_ethereum_balance(eth_address)
        unless balance<0
          create_account(eth_address, balance)
        else
          "error balance can not be negative and it is #{balance}"
        end

      else
        "#{r['address']}"
      end

    end

  end

  private

  # get ethereum balance in Weis
  def get_ethereum_balance(eth_address)
    uri = URI.parse("https://etherchain.org/api/account/#{eth_address}")

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    #FIX: only for this sample case, in production we would need to use proper PEM certificates here
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    json_response = JSON.parse(response.body)
    if(json_response["status"] == 1) then
      return json_response["data"][0]["balance"]
    else
      raise("error in ethereum balance request")
    end


  end


  # create a new account in the DB with ethereum address and balance in Weis
  # since our eth_address is unique in our DB, trying to POST the same address will actually update the existing value
  def create_account(eth_address, balance)
    accounts = @@DB[:accounts]
    unique_account = accounts.where(:eth_address => eth_address)
    if(unique_account.count > 0) then
      unique_account.update(:balance => balance)
    else
      accounts.insert(:eth_address => eth_address, :balance => balance)
    end
  end

end
