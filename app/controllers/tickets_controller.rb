class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.all

    if !@tickets.nil?
      @tickets = @tickets.to_a

      # remove image attribute
      @tickets.map!{|ticket| ticket.attributes.except('image')}

      # sort by created_at datetime
      @tickets.sort_by! {|ticket| ticket['created_at'] }.reverse
    end

    render json: @tickets.to_json()
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])
    render json: @ticket.to_json()
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    obj = JSON[request.body.read]
    @ticket = Ticket.new()
    @ticket.description = obj["description"]
    @ticket.status = obj["status"]
    @ticket.priority = obj["priority"]
    @ticket.category = obj["category"]
    @ticket.private = obj["private"]
    @ticket.lat = obj["lat"].to_f
    @ticket.long = obj["long"].to_f
    @ticket.image = obj["image"]
    logger.debug(@ticket)
    if @ticket.save
      render json: @ticket.to_json()
    else
      render json: @ticket.errors
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params[:ticket]
    end
end
