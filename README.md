===Migrations===
sequel -m db/migrations sqlite://db/sqlite3.db

===How to Run===
- rackup to bring up the server
- curl -X GET http://localhost:9292/balance to GET all balances in JSON format
- curl -X POST http://localhost:9292/add_balance?address={ethereum_address}



===TODO===
- port ethernet validations from EIP55 in js -> ruby or find a library that has already done it, such that we will be able to validate eth addresses before sending off request


