module MiniboardHelper

  # user-created positions on positions page
  def linked_position_miniboard(position)
    options = {
      fen: position.fen,
      flip: position.fen.include?(" b "),
      path: "/positions/#{position.id}",
      title: position.name_or_id,
    }
    render partial: "snippets/miniboard_link", locals: options
  end

  # positions and endgames pages
  def linked_miniboard(title, fen, goal = "win", depth = nil)
    link = "/position?goal=#{goal}&fen=#{fen}"
    link = "#{link}&depth=#{depth}" if depth.present?
    options = {
      fen: fen,
      flip: fen.include?(" b "),
      path: link,
      title: title
    }
    render partial: "snippets/miniboard_link", locals: options
  end

  # homepage miniboards
  def linked_miniboard_path(fen, path)
    options = {
      fen: fen,
      flip: fen.include?(" b "),
      path: path,
    }
    render partial: "snippets/miniboard_link", locals: options
  end

  # for static routes defined in position_routes.txt
  def linked_miniboard_route(path)
    route = StaticRoutes.new.route_map[path]
    return unless route.present?
    fen = route[:options]["fen"]
    options = {
      fen: fen,
      flip: fen.include?(" b "),
      path: path,
      title: sanitize(route[:title]).split("|")[0].strip
    }
    render partial: "snippets/miniboard_link", locals: options
  end
end
