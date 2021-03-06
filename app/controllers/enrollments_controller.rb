class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:edit, :update, :destroy]
   respond_to :html, :xml, :json
  def toggle
    @enrollment = Enrollment.find(params[:id])
    @user = @enrollment.user

    if @enrollment.update_attributes(:cal_hidden => params[:cal_hidden])
      redirect_to @user
    else
      redirect_to @user
    end
  end
  
  def cal_hide
    @enrollment = Enrollment.find(params[:enrollment_id])
    @enrollment.update_attribute(:cal_hidden, true)
    @user = @enrollment.user
    redirect_to @user
  end
  
  def cal_show
    @enrollment = Enrollment.find(params[:enrollment_id])
    @enrollment.update_attribute(:cal_hidden, false)
    @user = @enrollment.user
    redirect_to @user
    
  end
  # GET /enrollments
  # GET /enrollments.json
  def index
    @enrollments = Enrollment.all
  end

  # GET /enrollments/1
  # GET /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
   # @enrollment = Enrollment.new
  end

  # GET /enrollments/1/edit
  def edit
  end

  
  # POST /enrollments
  # POST /enrollments.json
  def create
    @user = User.find(params[:user_id])
    @enrollment = @user.enrollments.new(enrollment_params)
    @section = @enrollment.section

    respond_to do |format|
      if @enrollment.save
        format.js
        format.html { redirect_to sections_wishlist_path, notice: 'Added to wishlist.' }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      else
        format.js
        format.html { render :new }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1
  # PATCH/PUT /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to sections_wishlist_path }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1
  # DELETE /enrollments/1.json
  def destroy
    @section = @enrollment.section
    @enrollment.destroy
    respond_to do |format|
      format.js
      format.html { redirect_to sections_wishlist_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enrollment
      @enrollment = Enrollment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enrollment_params
      params.require(:enrollment).permit(:cal_hidden, :user_id, :section_id)
    end
end
