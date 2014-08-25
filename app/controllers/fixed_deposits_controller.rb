class FixedDepositsController < ApplicationController
  before_action :set_fixed_deposit, only: [:show, :edit, :update, :destroy]

  # GET /fixed_deposits
  # GET /fixed_deposits.json
  def index
    @fixed_deposits = FixedDeposit.all
  end

  # GET /fixed_deposits/1
  # GET /fixed_deposits/1.json
  def show
  end

  # GET /fixed_deposits/new
  def new
    @fixed_deposit = FixedDeposit.new
  end

  # GET /fixed_deposits/1/edit
  def edit
  end

  # POST /fixed_deposits
  # POST /fixed_deposits.json
  def create
    @fixed_deposit = FixedDeposit.new(fixed_deposit_params)

    respond_to do |format|
      if @fixed_deposit.save
        format.html { redirect_to @fixed_deposit, notice: 'Fixed deposit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fixed_deposit }
      else
        format.html { render action: 'new' }
        format.json { render json: @fixed_deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fixed_deposits/1
  # PATCH/PUT /fixed_deposits/1.json
  def update
    respond_to do |format|
      if @fixed_deposit.update(fixed_deposit_params)
        format.html { redirect_to @fixed_deposit, notice: 'Fixed deposit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fixed_deposit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fixed_deposits/1
  # DELETE /fixed_deposits/1.json
  def destroy
    @fixed_deposit.destroy
    respond_to do |format|
      format.html { redirect_to fixed_deposits_url }
      format.json { head :no_content }
    end
  end

  # GET /fixed_deposits/get_interest_on_date
  # GET /fixed_deposits/get_interest_on_date.json
  def get_interest_on_date
    puts "====params are here ====="
    puts params
    puts "============="
    respond_to do |format|
      format.html do
        render "index"
      end
      format.json do
        fd_interest = FixedDepositInterest.find_by_interest_date(params[:opening_date])
        data = {} 
        # Here we are generating data object based on openening_date of params which we sent from ajax request 
        if fd_interest.present?
          data = {:interest => fd_interest.interest_percentage}
        else
          # some logic to generate interest percentage
          t1 = DateTime.strptime(params[:opening_date], "%d-%m-%Y") #params[:opening_date]'s date format is the format which we mentioned on defining the date picker
          t2 = DateTime.now
          data = {:interest => (t2-t1).to_f*0.25}
        end
        
        render :json => data
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fixed_deposit
      @fixed_deposit = FixedDeposit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fixed_deposit_params
      params.require(:fixed_deposit).permit(:account_number, :customer_id, :opening_date)
    end
end
