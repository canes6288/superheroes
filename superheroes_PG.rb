require 'pg'

# TODO: rename this file to superheroes.rb

# TODO: change the name of the class
class SuperheroesConnection

  def initialize
    # TODO: change the dbname to 'superheroes'
    @conn = PG.connect(:dbname =>'superheroes', :host => 'localhost')
    # TODO: change the insert to insert a superhero
    @conn.prepare("insert_user", "INSERT INTO superheroes (name, alter_ego, has_cape, power, arch_nemesis) VALUES ($1, $2, $3, $4, $5)")
  end

  def delete_all
    # TODO: fix this
    @conn.exec( "delete from superheroes" )
  end

  def insert_superheroes(name, alter_ego, has_cape, power, arch_nemesis)
    # TODO: fix this
    @conn.exec_prepared("insert_user", [name, alter_ego, has_cape, power, arch_nemesis])
  end

  # TODO: change method name
  def print_superheroes
    # TODO: fix this
    @conn.exec( "select * from superheroes order by name" ) do |result|
      result.each do |row|
        # TODO: fix this to pretty print the superheroes
        # puts row
        # dob = row['dob'] || 'null'
        puts "#{row['name']} has an arch-nemesis named #{row['arch_nemesis']}...haha...muahahahaha...HAHAHAHAHAH!!!"
      end
    end
  end

  def close
    @conn.close
  end
end

begin
  # TODO: fix this
  connection = SuperheroesConnection.new

  # connection.delete_all
  connection.delete_all
  # TODO: insert superheroes here.
  connection.insert_superheroes('Superman', 'Clark Kent', true, 'flies', 'Lex Luther')
  connection.insert_superheroes('Flash', 'Barry Allen', false, 'super speed', 'Professor Zoom')
  connection.insert_superheroes('Batman', 'Bruce Wayne', true, 'none', 'The Joker')
  connection.insert_superheroes('Mister Fantastic', 'Reed Richards', true, 'flies', 'Lex Luther')

  # TODO: fix this to use better method name
  connection.print_superheroes
rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
ensure
  connection.close
end
