***Setup/Migrations***
sequel -m db/migrations sqlite://db/sqlite3.db
 

***How to Run***
- rackup to bring up the server
- curl -X GET http://localhost:9292/balance to GET all balances in JSON format
- curl -X POST http://localhost:9292/add_balance?address={ethereum_address}

***Sample Flow***

- Delete db/sqlite3.db file
- rackup to bring up roda server
- curl -X POST http://localhost:9292/add_balance?address=0x2b9c4e2ad6f1e7bd43365abb99faa1867706ea9c
- curl -X POST http://localhost:9292/add_balance?address=0xe0498570303d14456c71eb7f6f057ea149a425c6
- curl -X POST http://localhost:9292/add_balance?address=0x8eeec35015baba2890e714e052dfbe73f4b752f9
- curl -X POST http://localhost:9292/add_balance?address=0xfb663039763f61506f66158720f72794eddb1cc0
- curl -X GET http://localhost:9292/balance
/balance should have the content of these 4 addresses, ___including the Wei to Eth balance___, being performed at time of fetching data from DB, not stored in DB.
If balance in one of these addresses changes and we re-POST then it will update in place the same eth_address entry


***TODO***
- port ethernet validations from EIP55 in js -> ruby or find a library that has already done it, such that we will be able to validate eth addresses before sending off request
- tests. rack::test or capybara
- scripts/bootstrap_sequel.rb is deprecated, just left in there for completeness.
