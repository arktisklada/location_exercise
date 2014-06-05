class EventsController < ApplicationController

  before_action :set_user
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :get_states, only: [:new, :show, :edit]


  def index
    if request.xhr?
      request_params = index_params
      @events = Event.events_for_user(@user, request_params[:start], request_params[:end])
    end
    # sleep 2
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @events }
    end
  end

  def show
  end


  def new
    @event = Event.new
  end

  def edit
  end

  def create
    event_hash = event_params
    event_hash.delete(:start_date_time)
    event_hash.delete(:end_date_time)
    event_hash[:start_date] = "#{event_hash[:start_date]} #{event_hash[:start_date_time]}"
    event_hash[:end_date] = "#{event_hash[:end_date]} #{event_hash[:end_date_time]}"
    @event = Event.new(event_hash)
    @user.events << @event

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end



  private

    def set_user
      @user = User.first
    end

    def set_event
      @event = Event.find(params[:id])
    end

    def index_params
      params.permit(:format, :_, :start, :end)
    end
    def event_params
      params.require(:event).permit(:start_date, :start_date_time, :end_date, :end_date_time, :state_id)
    end

    def get_states
      @states = State.all
    end
end
