module ToolsHelper
  RADIUS = 160

  def needle_path(percentage)
    centre_x = 160;
    centre_y = 160;

    degree_angle = ((100 - percentage).to_f / 100.0 * 180.0).to_i
    rad_angle = degree_angle * Math::PI / 180.0
    x = Math.cos(rad_angle) * RADIUS + centre_x
    y = Math.sin(rad_angle) * RADIUS + centre_y

    if percentage == 50
      '160 320, 165 160, 155 160'
    elsif percentage == 100
      '320 160, 160 165, 160, 155'
    elsif percentage == 0
      '0 160, 160 165, 160 155'
    elsif percentage < 25 || percentage > 75
      "#{x} #{y}, 160 165, 160, 155"
    elsif percentage >= 25 && percentage <= 75
      "#{x} #{y}, 165 160, 155 160"
    else
      '25 25, 100 100, 300 300'
    end
  end
end
