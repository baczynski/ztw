class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
  end

  def players_tournaments
    @tournaments = Player.find(params[:id]).tournaments
  end

  def chart
    @player = Player.find(params[:id])
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.chart type: 'spline'
      f.xAxis type: :datetime
      f.plotOptions spline: {marker: {enabled: true}}
      f.legend enabled: false

      data = @player.matches.map do |m|
        if m.white_player_id == @player.id
          rating = m.white_rating_before + m.white_rating_change if m.white_rating_before.present?
        else
          rating = m.black_rating_before + m.black_rating_change if m.black_rating_before.present?
        end
        [m.updated_at.to_i * 1000, rating] unless rating.nil?
      end.compact.sort_by {|m| m[0]}

      f.series data: data, name: Player.human_attribute_name(:rating)
    end
  end
end
