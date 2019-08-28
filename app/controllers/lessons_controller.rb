class LessonsController < ApplicationController
   before_action :authenticate_user!
   before_action :require_authorized_for_current_course, only: [:show]

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

   def require_authorized_for_current_lesson
   	if current_lesson.user != current_user
      redirect_to course_path, alert: 'You must be enrolled in'	
    end
   end  

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
