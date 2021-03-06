class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  # GET /tickets
  # GET /tickets.json
  def index
    attributes_excluding_image = (Ticket.attribute_names - ['image']).join(', ')
    @tickets = Ticket.select(attributes_excluding_image).order('created_at DESC')

    render json: @tickets.to_json()
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
    attributes_excluding_image = (Ticket.attribute_names - ['image']).join(', ')
    @ticket = Ticket.select(attributes_excluding_image).where(id: params[:id])[0]

    render json: @ticket.to_json()
  end

  # GET /tickets/new
  def new
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
    @ticket.address = obj["address"]
    @ticket.status = obj["status"]
    @ticket.priority = obj["priority"]
    @ticket.category = obj["category"]
    @ticket.private = obj["private"]
    @ticket.lat = obj["lat"].to_f
    @ticket.lon = obj["lon"].to_f
    @ticket.image = obj["image"]
    if @ticket.save
      @ticket.image = nil
      render json: @ticket.to_json()
    else
      render json: @ticket.errors
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
      a = Ticket.find(params[:id])
      a.destroy()
      render json: "success"
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
