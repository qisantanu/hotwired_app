# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def developer_pagination_link(page_number:, last_page:)
    params = request.params.to_hash.with_indifferent_access
    params[:page] = page_number
    url = lists_developers_path(params)

    if last_page > params[:page].to_i
      link_to 'Next', url,
              data: { turbo_stream: true }
    end
  end

  def developer_pagination_prev_link(page_number:)
    params = request.params.to_hash.with_indifferent_access
    params[:page] = page_number
    url = lists_developers_path(params)

    if params[:page].to_i.positive?
      link_to 'Prev', url,
              data: { turbo_stream: true }, class: 'text-grey-500'
    end
  end
end
