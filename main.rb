# main.rb
require 'socket'
require 'sqlite3'

# Create a TCP server socket bound to port 3000
server = TCPServer.new(3000)
puts "Basic count server running on http://localhost:3000"

# Create simple SQLite DB, along with simple table
db = SQLite3::Database.new('db/count.db')
db.execute('CREATE TABLE IF NOT EXISTS count_server (id INTEGER PRIMARY KEY, visitor int);')

loop do
  # Accept incoming connections
  client = server.accept

  # Read the request
  request = client.gets
  puts "Request: #{request}"
  
  # Create new row for every request that the server receives (Every page load is two requests because the page icon file) 
  db.execute('INSERT INTO count_server(visitor) VALUES(1);')

  # Call upon the server's functions to update the page with the current amount of requests received
  current_count = db.execute('SELECT COUNT(*) FROM count_server;')
  
  # Respond with a simple HTTP response that includes the value of current requests
  response = "HTTP/1.1 200 OK\r\n\r\nHello, UNIR!\nCurrent count of requests is :#{current_count}"
  client.puts response

  # Close the connection
  client.close
end