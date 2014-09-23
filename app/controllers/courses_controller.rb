class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_filter :find_university, only: [:index, :new, :create, :post]
  respond_to :html, :xml, :json

  # GET /courses
  # GET /courses.json
  def all_courses
    @courses = Course.all
  end
  
  def index
    @courses = Course.all
    @university = University.find(params[:university_id])
    @course = @university.courses.new
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end

  # GET /courses/new
  def new
    @course = Course.new
    respond_with(@course)
  end

  # GET /courses/1/edit
  def edit
   # @course = Course.find(params[:id])
    @university = University.find(@course.university_id)
  end

  # POST /courses
  # POST /courses.json
  def create
    @university = University.find(params[:university_id])
    @course = @university.courses.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to university_courses_path(@university), notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @university = @course.university
    @course.destroy
    respond_to do |format|
      format.html { redirect_to university_courses_path(@university), notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end
  
    def find_university
      @university = University.find(params[:university_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:university_id, :name, :description, :credits)
    end
end