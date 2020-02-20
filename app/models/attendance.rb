class Attendance < ApplicationRecord
    after_create :event_confirmation_send
    belongs_to :user
    belongs_to :event

    def event_confirmation_send
        AttendanceMailer.attendance_email(self).deliver_now
    end
end
