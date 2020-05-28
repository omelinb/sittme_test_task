module Paginable
  DEFAULT_PER_PAGE = 10

  private

  def pagination_links(links_paths, model)
    links = {
      links: {
        first_page: send(links_paths, page: 0, per_page: per_page )
      }
    }

    if page > 0
      prev_page_path = send(links_paths, page: page - 1, per_page: per_page)
      links[:links][:prev_page] = prev_page_path
    end

    if (page + 1) * per_page < model.count
      next_page_path = send(links_paths, page: page + 1, per_page: per_page)
      links[:links][:next_page] = next_page_path
    end

    links
  end

  def per_page
    (params[:per_page] || DEFAULT_PER_PAGE).to_i
  end

  def page
    (params[:page] || 0).to_i
  end
end
