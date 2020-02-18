class Attendance < ApplicationRecord
    after_create :event_confirmation_send

    def event_confirmation_send
        AttendanceMailer.attendance_email(self).deliver_now
    end
end
