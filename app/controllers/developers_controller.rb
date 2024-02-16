# frozen_string_literal: true

#
# Handle the developers related request over here
# The index action will be used as the root page for this
#
class DevelopersController < ApplicationController
  before_action :authorize
  before_action :set_developer, only: %i[show edit update destroy]

  # GET /developers or /developers.json
  def index
    @notifications = Notification.order('id desc')
    page = params[:page].to_i
    @notifications = @notifications.offset(page * Notification::PAGINATION)
                                   .limit(Notification::PAGINATION)
  end

  # GET /developers/lists
  def lists
    page = params[:page].to_i
    @count = Developer.count
    @first_page = 0

    @last_page = (@count / Developer::PAGINATION).ceil
    @next_page = page + 1
    @prev_page = (page - 1) <= 0 ? 0 : page - 1
    @developers = Developer.offset(page * Developer::PAGINATION)
                           .limit(Developer::PAGINATION).order('id desc')
  end

  # GET /developers/1 or /developers/1.json
  def show; end

  # GET /developers/new
  def new
    @developer = Developer.new
  end

  # GET /developers/1/edit
  def edit; end

  # POST /developers or /developers.json
  def create
    @developer = Developer.new(developer_params)

    respond_to do |format|
      if @developer.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend('developer_tbody', partial: 'developers/developer',
                                                    locals: { developer: @developer })
          ]
        end

        format.html { redirect_to developer_url(@developer), notice: 'Developer was successfully created.' }
        format.json { render :show, status: :created, location: @developer }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('modal', partial: 'developers/new',
                                         locals: { developer: @developer })
          ]
        end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /developers/1 or /developers/1.json
  def update
    respond_to do |format|
      if @developer.update(developer_params)
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_developer', partial: 'developers/form',
                                                 locals: { developer: Developer.new }),
            turbo_stream.replace("developer_#{@developer.id}", partial: 'developers/developer',
                                                               locals: { developer: @developer })
          ]
        end

        format.html { redirect_to developer_url(@developer), notice: 'Developer was successfully updated.' }
        format.json { render :show, status: :ok, location: @developer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @developer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /developers/1 or /developers/1.json
  def destroy
    @developer.destroy

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.remove("developer_#{@developer.id}")
        ]
      end
      format.html { redirect_to developers_url, notice: 'Developer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_developer
    @developer = Developer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def developer_params
    params.require(:developer).permit(:first_name, :last_name, :email, :company_name, :address, :dob)
  end
end
