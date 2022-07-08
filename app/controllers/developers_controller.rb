class DevelopersController < ApplicationController
  before_action :set_developer, only: %i[ show edit update destroy ]

  # GET /developers or /developers.json
  def index
    @developers = Developer.order('id desc')
  end

  # GET /developers/1 or /developers/1.json
  def show
  end

  # GET /developers/new
  def new
    @developer = Developer.new
  end

  # GET /developers/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('new_developer', partial: 'developers/form',
                                               locals: { developer: @developer })
        ]
      end
    end
  end

  # POST /developers or /developers.json
  def create
    @developer = Developer.new(developer_params)

    respond_to do |format|
      if @developer.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_developer', partial: 'developers/form', 
                                                 locals: { developer: Developer.new }),
            turbo_stream.prepend('developers', partial: 'developers/developer',
                                               locals: { developer: @developer })
          ]
        end

        format.html { redirect_to developer_url(@developer), notice: "Developer was successfully created." }
        format.json { render :show, status: :created, location: @developer }
      else
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_developer', partial: 'developers/form',
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
            turbo_stream.update("developer_#{@developer.id}", partial: 'developers/developer',
                                                              locals: { developer: @developer })
          ]
        end

        format.html { redirect_to developer_url(@developer), notice: "Developer was successfully updated." }
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
      format.html { redirect_to developers_url, notice: "Developer was successfully destroyed." }
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
