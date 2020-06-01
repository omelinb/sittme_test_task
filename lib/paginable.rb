require 'active_support/concern'

module Paginable
  module Model
    extend ActiveSupport::Concern

    included do
      scope :range, lambda { |before, after|
        where(['id > ? AND id < ?', after, before]).order(:created_at)
      }
      scope :prev_page, lambda { |cursor, size| 
        where('id < ?', cursor).last(size).sort { |a, b| a.created_at <=> b.created_at }
      }
      scope :next_page, lambda { |cursor, size|
        where('id > ?', cursor).first(size).sort { |a, b| a.created_at <=> b.created_at }
      }
    end

    class_methods do
      def get_page(before, after, size)
        if before and after
          range(before, after)
        elsif before
          prev_page(before, size)
        elsif after
          next_page(after, size)
        else
          []
        end
      end
    end
  end

  module Controller 
    DEFAULT_PAGE_SIZE = 10

    private

    def pagination_links(links_paths, collection)
      links = { links: {} }

      if collection.present?
        prev_page_path = send(
          links_paths,
          "page[size]" => page_size,
          "page[before]" => collection.first.id
        )
        next_page_path = send(
          links_paths,
          "page[size]" => page_size,
          "page[after]" => collection.last.id
        )
        links[:links][:prev_page] = prev_page_path
        links[:links][:next_page] = next_page_path
      end

      links
    end

    def page_size
      (params[:page] && params[:page][:size] || DEFAULT_PAGE_SIZE).to_i
    end

    def page_before
      params[:page] && params[:page][:before]
    end

    def page_after
      params[:page] && params[:page][:after]
    end
  end
end
