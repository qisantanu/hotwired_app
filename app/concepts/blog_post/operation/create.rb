module BlogPost::Operation
  class Create < Trailblazer::Operation
    step :extract_params
    step :validate_for_create?
    fail :add_errors
    step :create_models
    step :notify

    def extract_params(ctx, **)
      blog_post_params = params[:blog_post]
      ctx[:my_params] = blog_post_params
    end

    def validate_for_create?(ctx, my_params:, **)
      params[:title].present? && params[:body].present?
    end

    def add_errors(ctx, errorrs: , **)
      errorrs[:title] = 'invalid title'
    end

    def create_models(ctx, my_params:, **)
      ctx[:blog_post] = BlogPost.new(**my_params)
      ctx[:blog_post].save
    end

    def notify(ctx, blog_post:, **)
      # send the mail
      puts "sending mail"
      Rails.logger.info "sending mail"
    end
  end
end