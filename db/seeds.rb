# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.transaction do
  Tournament.delete_all

  Player.where.not(admin: true).delete_all
  abc = Player.create(
    email: 'a@b.c', password: 'asdasdasd', password_confirmation: 'asdasdasd',
    first_name: 'A', surname: 'B_c',
    address: Address.create(zip_code: '123-45', city: 'Boston', street_address: '4278 Long avenue')
  )
  players = 10.times.map do |i|
    { email: "player.stub#{i}@test.com", password: 'asdasdasd', password_confirmation: 'asdasdasd' }
  end
  Player.create players

  r = Random.new

  dates = (-5..30).map {|i| DateTime.now + i}
  dates.shuffle!

  tournaments = dates.map.with_index do |date, i|
    Tournament.new(
      name: "Turniej #{i + 1}",
      description: "Zapraszamy na #{i + 1}. turniej!",
      start_date: date,
      tournament_type: r.rand(2) % 2 == 0 ? 'ONSITE' : 'ONLINE',
      rounds: r.rand(4) + 1
    )
  end

  soon = Tournament.new(
    name: "Tournament that is about to start!",
    description: "The tournament will start in two minutes after you do 'rake db:seed'",
    start_date: DateTime.now + 2.minutes,
    tournament_type: 'ONLINE',
    rounds: 2
  )
  soon.players << Player.last(9)
  tournaments << soon

  tournaments << Tournament.new(
    name: "Tournament with activity rule",
    description: "a@b.c definitely can't take part in this.",
    start_date: DateTime.now + 1.hour,
    tournament_type: 'ONLINE',
    rounds: 2,
    rule: ActivityRule.new(games_limit: 3)
  )

  tournaments << Tournament.new(
    name: "Tournament with rating rule",
    description: "a@b.c definitely can't take part in this.",
    start_date: DateTime.now + 40.minutes,
    tournament_type: 'ONLINE',
    rounds: 2,
    rule: RatingRule.new(min_rating: 1725)
  )

  tournaments.each do |t|
    t.save(validate: false)
  end
end
