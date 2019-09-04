class LessonsController < ApplicationController
   before_action :authenticate_user!
   before_action :require_enrollment_for_current_lesson, only: [:show]

   def new
     @lesson = Lesson.new
   end	

   def create
   	@lesson = current_lesson.section.course(lesson_params)
   	if current_user.enrolled_in?
   		redirect_to course_path(@course)
   	end	
   end

   def show

   end	
   
   private

   def require_enrollment_for_current_lesson
   	unless current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path, alert: 'You must be enrolled in'	
    end
   end  

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
