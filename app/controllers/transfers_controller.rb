class TransfersController < ApplicationController
  before_action :set_transfer, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  # GET /transfers or /transfers.json
  def index
    @transfers = Transfer.all.limit(5)
    
  end

  # GET /transfers/1 or /transfers/1.json
  def show
  end

  # GET /transfers/new
  def new
    @transfer = Transfer.new
  end

  # GET /transfers/1/edit
  def edit
  end

  # POST /transfers or /transfers.json
  def create
    @transfer = Transfer.new(transfer_params)

    respond_to do |format|
      
        if !params[:transfer][:items].nil?
          total = 0
          params[:transfer][:items].each do |f| 
            item = Item.where(["id = #{f}"]).first
            total += item.amount
          end
          account = Account.where(["id = #{@transfer.account_id}"]).first
          new_total = account.amount - total
          if new_total > 0 
            account.update(amount: new_total)
            params[:transfer][:items].each do |f| 
              Item.where(["id = #{f}"]).first.update(transfer_id: @transfer.id)
            end
            if @transfer.save
              format.html { redirect_to accounts_path, notice: "Transfer was successfully created." }
              format.json { render :show, status: :created, location: @transfer }
            
          end
          else
            format.html { redirect_to budgets_url, notice: "Esa cuenta no tiene suficiente plata"}
            format.json { render json: @transfer.errors, status: :unprocessable_entity }
          end
        end
    end
  end

  # PATCH/PUT /transfers/1 or /transfers/1.json
  def update
    respond_to do |format|
      if @transfer.update(transfer_params)
        format.html { redirect_to accounts_path, notice: "Transfer was successfully updated." }
        format.json { render :show, status: :ok, location: @transfer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transfer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transfers/1 or /transfers/1.json
  def destroy
    @transfer.destroy
    respond_to do |format|
      format.html { redirect_to transfers_url, notice: "Transfer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transfer_params
      params.require(:transfer).permit(:date, :concept, :account_id, items: [:id])
    end
end
