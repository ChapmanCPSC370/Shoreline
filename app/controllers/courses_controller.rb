class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_filter :find_university, only: [:index, :post]
  respond_to :html, :xml, :json

  # GET /courses
  # GET /courses.json
  def all_courses
    if params[:search]
      @courses = Course.search(params[:search]).order("name ASC")
      @autocomplete_items = Course.all
    else
      @courses = Course.all.order('name ASC')
      @autocomplete_items = Course.all
      respond_with json: @courses
    end
  end
  
  def edit_all
    @courses = Course.all
  end
  
  def destroy_multiple
    Course.destroy(params[:courses])

    respond_to do |format|
      format.html { redirect_to courses_edit_all_path }
      format.json { head :no_content }
    end
  end
  
  def index

    @courses = Course.all.order('created_at DESC')

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
  end

  # POST /courses
  # POST /courses.json
  def create
  #  @university = University.find(params[:university_id])
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_all_courses_path, notice: 'Course was successfully created.' }
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
        format.html { redirect_to courses_all_courses_path, notice: 'Course was successfully updated.' }
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
      format.html { redirect_to courses_all_courses_path, notice: 'Course was successfully destroyed.' }
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
      params.require(:course).permit(:department_tag, :course_number, :university_id, :name, :description, :credits, :department_id)
    end
end
