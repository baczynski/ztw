# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless Tournament.count > 0

  Tournament.create name: "Turniej im. Bobby Fischera",
    description: "Ten turniej jest pierwszym turniejem z serii...",
    start_date: DateTime.new(2016, 4, 13, 12)

  Tournament.create name: "Turniej rozrywkowy #42",
    description: 'Zapraszamy na 42. turniej z edycji "Turnieje rozrywkowe"',
    start_date: DateTime.new(2016, 4, 14, 12),
    tournament_type: 'ONSITE',
    rounds: 3

  r = Random.new

  dates = (1..50).map {|i| DateTime.now + (r.rand(2) % 2 == 0 ? i : -i)}
  dates.shuffle!

  tournaments = (1..50).map do |i|
    { name: "Turniej #{i}",
      description: "Zapraszamy na #{i}. turniej!",
      start_date: dates[i - 1],
      tournament_type: r.rand(2) % 2 == 0 ? 'ONSITE' : 'ONLINE',
      rounds: r.rand(5) + 1,
      round: 0
    }
  end

  Tournament.create tournaments

end