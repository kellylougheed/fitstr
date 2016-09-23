class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show]

  def show
  end

  private

  def require_authorized_for_current_course
    current_course = current_lesson.section.course
    if !current_user.enrolled_in?(current_course)
      redirect_to course_path(current_lesson.section.course), alert: 'You must be registered in this course to view the lessons'
    end
  end

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

end
