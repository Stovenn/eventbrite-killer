class AttendancesController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
      @event = Event.find(params[:event_id])
      @amount = @event.price * 100

        customer = Stripe::Customer.create({
          email: params[:stripeEmail],
          source: params[:stripeToken],
        })
      
        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @amount,
          description: 'Rails Stripe customer',
          currency: 'usd',
        })

        Attendance.create(stripe_customer_id:customer.id, user_id:current_user.id, event_id: @event.id)
   
      rescue Stripe::CardError => e
        flash[:error] = e.message
        redirect_to new_event_attendance_path(@event)
    end 

    def index
      @event = Event.find(params[:event_id])
      @list_of_users = @event.users
    end
  end
